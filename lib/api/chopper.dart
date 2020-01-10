import 'package:btpp/api/annonce_api.dart';
import 'package:btpp/api/chat_api.dart';
import 'package:chopper/chopper.dart';

import 'actu_api.dart';
import 'authentication_api.dart';

export './authentication_api.dart';

String token =
    'Y6lF5Ap+QzMyDAL2++1VwD+IrVSuVdfciNHDyBHSNXInNkC9LpA87f2501Kz674ZtWM=s';

const String mainUrl = 'https://btp-partnership.herokuapp.com';
ChopperClient get chopper => ChopperClient(
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
          return await chopper
              .send(r2.replace(headers: {'X-Auth-Token': token}));
        }
        return r;
      }
    ]);

AuthenticationApi get authApi => AuthenticationApi.create(chopper);
Request lastRequest;
AnnonceApi get annonceApi => AnnonceApi.create(chopper);
ActuApi get actuApi => ActuApi.create(chopper);
ChatApi get chatApi => ChatApi.create(chopper);
TachesApi get tachesApi => TachesApi.create(chopper);
