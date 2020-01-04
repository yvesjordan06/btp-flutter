import 'package:btpp/Pages/Auth/login.dart';
import 'package:btpp/bloc/bloc.dart';
import 'package:chopper/chopper.dart';
part 'authentication_api.chopper.dart';

const Map<String, String> cred = {
  'login': 'castel@gmail.com',
  'password': 'testtest'
};

const String mainUrl = 'https://btp-partnership.herokuapp.com';

@ChopperApi(baseUrl: '/')
abstract class AuthenticationApi extends ChopperService {
  @Post(path: 'auth-tokens')
  Future<Response> _authenticateApi(
    @Body() Map<String, String> body,
  );

  Future<String> authenticateApi() async {
    try {
      Response a = await _authenticateApi(cred);
      return a.body['value'];
    } catch (e) {
      throw e;
    }
  }

  @Post(path: 'annonceurs/login')
  Future<Response> annonceurLogin(@Body() Map<String, String> credential);

  @Post(path: 'travailleurs/login')
  Future<Response> travailleurLogin(@Body() Map<String, String> credential);

  static AuthenticationApi create() {
    final ChopperClient client = ChopperClient(
        baseUrl: mainUrl,
        services: [
          _$AuthenticationApi(),
        ],
        converter: JsonConverter(),
        interceptors: [
          HeadersInterceptor({'X-Auth-Token': authBloc.token})
        ]);

    return _$AuthenticationApi(client);
  }
}
