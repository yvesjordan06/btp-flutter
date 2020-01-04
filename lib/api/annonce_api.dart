import 'package:chopper/chopper.dart';

part 'annonce_api.chopper.dart';

@ChopperApi(baseUrl: '/annonces')
abstract class AnnonceApi extends ChopperService {
  static AnnonceApi create([ChopperClient client]) => _$AnnonceApi(client);
  @Get()
  Future<Response> getAnnonces();

  @Get(path:'/{id}')
  Future<Response> getAnnonce(@Path('id') int id);

  @Get(path:'/particulier')
  Future<Response> getAnnoncesParticulier();

  @Get(path:'/entreprise')
  Future<Response> getAnnoncesEntreprise();

  @Get(path:'/annonceur/particulier/{id}')
  Future<Response> getAnnonceByParticulier(@Path('id') int id);

  @Get(path:'/travailleur/{id}')
  Future<Response> getAnnoncesForTravailleur(@Path('id') int id);

  @Post(path:'/particulier/creer')
  Future<Response> postAnnonceParticulier(
      @Body() Map<String, dynamic> body,
      );

  @Post(path:'/entreprise/creer')
  Future<Response> postAnnonceEntreprise(
      @Body() Map<String, dynamic> body,
      );

}
