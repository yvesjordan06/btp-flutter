import 'package:btpp/api/annonce_api.dart';
import 'package:btpp/api/chat_api.dart';
import 'package:chopper/chopper.dart';
import 'package:flutter/cupertino.dart';

import 'actu_api.dart';
import 'authentication_api.dart';

export './authentication_api.dart';

String token = '';

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
          (Request r) async {
        if (r.url != "/auth-tokens" && token.isEmpty) {
          debugPrint("!!! Token is Empty ${r.url} ");
          token = await authApi.authenticateApi();
        }

        print("!!! CHOPPER HEADERS  ${r.headers} ");
        print("!!! CHOPPER BODY  ${r.body} ");
        print("!!! CHOPPER URL  ${r.url} ");
        //print("r.url");
        return r.replace(headers: {'X-Auth-Token': token});
      },
      (Response r) async {
        if (r.statusCode == 401) {
          token = await authApi.authenticateApi();
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
