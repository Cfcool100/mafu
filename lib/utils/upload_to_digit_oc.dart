import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:crypto/crypto.dart';
import 'package:http/http.dart' as http;
import 'package:mafuriko/constant/constants.dart';
import 'package:mime/mime.dart';

Future<Uri?> uploadFile(File filePath, String folderName) async {
  http.Client httpClient = http.Client();

  int? contentLength = await filePath.length();
  Digest contentSha256 = await sha256.bind(filePath.openRead()).first;
  String uriStr =
      "https://${Configs.BUCKET}.${Configs.region}.digitaloceanspaces.com/$folderName/${DateTime.now().millisecondsSinceEpoch.toString()}";
  http.StreamedRequest request = http.StreamedRequest('PUT', Uri.parse(uriStr));
  Stream<List<int>> stream = filePath.openRead();
  stream.listen(request.sink.add,
      onError: request.sink.addError, onDone: request.sink.close);

  request.headers['x-amz-acl'] = 'public-read';
  request.headers['Content-Length'] = contentLength.toString();
  request.headers['Content-Type'] =
      lookupMimeType(filePath.path) ?? 'application/octet-stream';
  signRequest(request, contentSha256: contentSha256);
  http.StreamedResponse response = await httpClient.send(request);
  //String body = await utf8.decodeStream(response.stream);
  if (response.statusCode != 200) {
    // ClientException(response.statusCode, response.reasonPhrase, response.headers, body);
    return null;
  }
  log("request url  ${response.request!.url}");

  return response.request!.url;
}

String _trimAll(String str) {
  String res = str.trim();
  int len;
  do {
    len = res.length;
    res = res.replaceAll('  ', ' ');
  } while (res.length != len);
  return res;
}

String _uriEncode(String str) {
  return Uri.encodeQueryComponent(str).replaceAll('+', '%20');
}

String? signRequest(
  http.BaseRequest request, {
  Digest? contentSha256,
  bool preSignedUrl = false,
  int expires = 86400,
}) {
  String httpMethod = request.method;
  String canonicalURI = request.url.path;
  String host = request.url.host;
  String service = 's3';

  DateTime date = DateTime.now().toUtc();
  String dateIso8601 = date.toIso8601String();
  dateIso8601 =
      '${dateIso8601.substring(0, dateIso8601.indexOf('.')).replaceAll(':', '').replaceAll('-', '')}Z';
  String dateYYYYMMDD = date.year.toString().padLeft(4, '0') +
      date.month.toString().padLeft(2, '0') +
      date.day.toString().padLeft(2, '0');

  String hashedPayloadStr =
      contentSha256 == null ? 'UNSIGNED-PAYLOAD' : '$contentSha256';

  String credential =
      '${Configs.ACCESSKEYID}/$dateYYYYMMDD/${Configs.region}/$service/aws4_request';

  // Build canonical headers string
  Map<String, String?> headers = <String, String?>{};
  if (!preSignedUrl) {
    request.headers['x-amz-date'] = dateIso8601; // date in header
    if (contentSha256 != null) {
      request.headers['x-amz-content-sha256'] =
          hashedPayloadStr; // payload hash in header
    }
    for (var name in request.headers.keys) {
      (headers[name.toLowerCase()] = request.headers[name]);
    }
  }
  headers['host'] = host; // Host is a builtin header
  List<String> headerNames = headers.keys.toList()..sort();
  String canonicalHeaders =
      headerNames.map((s) => '$s:${_trimAll(headers[s]!)}' '\n').join();

  String signedHeaders = headerNames.join(';');

  Map<String, String> queryParameters = <String, String>{}
    ..addAll(request.url.queryParameters);
  if (preSignedUrl) {
    // query parameters
    queryParameters['X-Amz-Algorithm'] = 'AWS4-HMAC-SHA256';
    queryParameters['X-Amz-Credential'] = credential;
    queryParameters['X-Amz-Date'] = dateIso8601;
    queryParameters['X-Amz-Expires'] = expires.toString();
    if (contentSha256 != null) {
      queryParameters['X-Amz-Content-Sha256'] = hashedPayloadStr;
    }
    queryParameters['X-Amz-SignedHeaders'] = signedHeaders;
  }
  List<String> queryKeys = queryParameters.keys.toList()..sort();
  String canonicalQueryString = queryKeys
      .map((s) => '${_uriEncode(s)}=${_uriEncode(queryParameters[s]!)}')
      .join('&');

  if (preSignedUrl) {
    // TODO: Specific payload upload with pre-signed URL not supported on DigitalOcean?
    hashedPayloadStr = 'UNSIGNED-PAYLOAD';
  }

  // Sign headers
  String canonicalRequest =
      '$httpMethod\n$canonicalURI\n$canonicalQueryString\n$canonicalHeaders\n$signedHeaders\n$hashedPayloadStr';

  Digest canonicalRequestHash = sha256.convert(utf8.encode(canonicalRequest));

  String stringToSign =
      'AWS4-HMAC-SHA256\n$dateIso8601\n$dateYYYYMMDD/${Configs.region}/s3/aws4_request\n$canonicalRequestHash';

  Digest dateKey = Hmac(sha256, utf8.encode("AWS4${Configs.SECRETACCESSKEY}"))
      .convert(utf8.encode(dateYYYYMMDD));
  Digest dateRegionKey =
      Hmac(sha256, dateKey.bytes).convert(utf8.encode(Configs.region));
  Digest dateRegionServiceKey =
      Hmac(sha256, dateRegionKey.bytes).convert(utf8.encode(service));
  Digest signingKey = Hmac(sha256, dateRegionServiceKey.bytes)
      .convert(utf8.encode("aws4_request"));

  Digest signature =
      Hmac(sha256, signingKey.bytes).convert(utf8.encode(stringToSign));

  // Set signature in header
  request.headers['Authorization'] =
      'AWS4-HMAC-SHA256 Credential=$credential, SignedHeaders=$signedHeaders, Signature=$signature';

  if (preSignedUrl) {
    queryParameters['X-Amz-Signature'] = '$signature';
    return request.url.replace(queryParameters: queryParameters).toString();
  } else {
    return null;
  }
}

class ClientException {
  final int statusCode;
  final String? reasonPhrase;
  final Map<String, String> responseHeaders;
  final String responseBody;
  const ClientException(this.statusCode, this.reasonPhrase,
      this.responseHeaders, this.responseBody);
  @override
  String toString() {
    return "DOException { statusCode: $statusCode, reasonPhrase: \"$reasonPhrase\", responseBody: \"$responseBody\" }";
  }
}
