import 'package:chopper/chopper.dart';

part 'actu_api.chopper.dart';

@ChopperApi(baseUrl: '/realisations')
abstract class ActuApi extends ChopperService {
  static ActuApi create([ChopperClient client]) => _$ActuApi(client);
  @Get()
  Future<Response> getActus();

  @Get(path: '/{id}')
  Future<Response> getActu(@Path('id') int id);

  @Get(path: '/travailleur/{id}')
  Future<Response> getActusByTravailleur(@Path('id') int id);

  @Post(path: '/creer')
  Future<Response> createActu(
    @Body() Map<String, dynamic> body,
  );

  @Post(path: '/message/{chatID}')
  Future<Response> sendMessage(
    @Path('chatID') int chatID,
    @Body() Map<String, dynamic> body,
  );

  Future<Response> sendImages(int actuID, List<String> files) {
    final $url = '/realisations/images/upload/$actuID';
    //final $parts = <PartValue>[PartValueFile<List<int>>('file', bytes)];
    final $parts = <PartValue>[
      ...files.map((file) => PartValueFile<String>('image[]', file)).toList()
    ];
    final $request =
        Request('POST', $url, client.baseUrl, parts: $parts, multipart: true);
    return client.send<dynamic, dynamic>($request);
  }
}
