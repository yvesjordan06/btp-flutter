import 'package:btpp/api/annonce_api.dart';
import 'package:btpp/api/chat_api.dart';
import 'package:chopper/chopper.dart';

import 'actu_api.dart';
import 'authentication_api.dart';

export './authentication_api.dart';

String token =
    'G1meHgz9daQp0mDoJ2xQanOWUajA1lERCDPAmBP2amnhaRcmiPnOm9vKBJ7gdjQFfY0=';

const String mainUrl = 'https://btp-partnership.herokuapp.com';
ChopperClient chopper = ChopperClient(
    baseUrl: mainUrl,
    services: [
      AuthenticationApi.create(),
      AnnonceApi.create(),
    ],
    converter: JsonConverter(),
    interceptors: [
      HeadersInterceptor({'X-Auth-Token': token}),
      HttpLoggingInterceptor(),
      (Request r) {
        print(r.headers);
        print(r.parts);
        print(r.baseUrl);
        print(r.url);
        return r;
      },
      (Response r) async {
        print(r.error);
        if (r.statusCode == 401) {
          Request r2 = lastRequest;
          token = await authApi.authenticateApi();
          return await chopper.send(r2);
        }
        return r;
      }
    ]);

final authApi = AuthenticationApi.create(chopper);
Request lastRequest;
final annonceApi = AnnonceApi.create(chopper);
final actuApi = ActuApi.create(chopper);
final chatApi = ChatApi.create(chopper);
