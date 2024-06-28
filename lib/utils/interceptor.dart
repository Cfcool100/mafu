import 'dart:developer';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:http_interceptor/http_interceptor.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoggerInterceptor extends InterceptorContract {
  @override
  Future<BaseRequest> interceptRequest({
    required BaseRequest request,
  }) async {
    final headers = Map<String, String>.from(request.headers);
    headers[HttpHeaders.contentTypeHeader] = 'application/json; charset=utf-8';

    final SharedPreferences pref = await SharedPreferences.getInstance();

    final token = pref.getString('token');

    if (token != null && token.isNotEmpty) {
      headers['Authorization'] = token;
      return request.copyWith(headers: headers);
    }

    debugPrint('----- Request $token-----');
    debugPrint(request.toString());
    debugPrint(request.headers.toString());

    // if user exist  use request headers, else pass

    return request;
  }

  @override
  Future<BaseResponse> interceptResponse({
    required BaseResponse response,
  }) async {
    log('----- Response -----');
    log('Code: ${response.statusCode}');
    if (response is Response) {
      log((response).body);
    }

    return response;
  }
}
