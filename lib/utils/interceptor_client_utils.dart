import 'package:http_interceptor/http_interceptor.dart';

import 'package:http/http.dart' as http;
import 'package:mafuriko/utils/interceptor.dart';

class ClientService {
  static Client client =
      InterceptedClient.build(client: http.Client(), interceptors: [
    LoggerInterceptor(),
  ]);
}
