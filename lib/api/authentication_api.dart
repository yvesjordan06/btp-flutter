import 'package:chopper/chopper.dart';

part 'authentication_api.chopper.dart';

const Map<String, String> cred = {
  'login': 'castel@gmail.com',
  'password': 'testtest'
};

const String mainUrl = 'https://btp-partnership.herokuapp.com';

@ChopperApi(baseUrl: '/')
abstract class AuthenticationApi extends ChopperService {
  static AuthenticationApi create([ChopperClient client]) =>
      _$AuthenticationApi(client);
  @Post(path: 'auth-tokens')
  Future<Response> _authenticateApi(
    @Body() Map<String, String> body,
  );

  Future<String> authenticateApi() async {
    try {
      Response a = await _authenticateApi(cred);
      print(a.body);
      return a.body['value'];
    } catch (e) {
      throw e;
    }
  }

  @Post(path: 'annonceurs/login')
  Future<Response> annonceurLogin(@Body() Map<String, String> credential);

  @Get(path: 'annonceurs/particuliers/{id}')
  Future<Response> getAnnonceurParticulierById(@Path('id') int id);

  @Get(path: 'metiers')
  Future<Response> getMetiers();

  @Post(path: 'travailleurs/lierTravailleurMetiers')
  Future<Response> addMetierToTravailleur(@Body() Map<String, dynamic> body);

  @Post(path: 'travailleurs/delier-tavailleur-metiers')
  Future<Response> removeMetierToTravailleur(@Body() Map<String, dynamic> body);

  @Post(path: 'CVs/comptence/ajouter/{id}')
  Future<Response> addCompetenceToCv(@Path('id') int travailleurID,
      @Body() Map<String, dynamic> body);

  @Post(path: 'CVs/cursus/ajouter/{id}')
  Future<Response> addCursusToCv(@Path('id') int travailleurID,
      @Body() Map<String, dynamic> body);

  @Post(path: 'CVs/comptence/delete/{id}')
  Future<Response> deleteCompetenceToCv(@Path('id') int travailleurID,
      @Body() Map<String, dynamic> body);

  @Post(path: 'CVs/cursus/delete/{id}')
  Future<Response> deleteCursusToCv(@Path('id') int travailleurID,
      @Body() Map<String, dynamic> body);

  @Post(path: 'CVs/biographie/modifier/{id}')
  Future<Response> addBiographyToCv(@Path('id') int travailleurID,
      @Body() Map<String, dynamic> body);

  @Get(path: 'annonceurs/entreprises/{id}')
  Future<Response> getAnnonceurEntrepriseById(@Path('id') int id);

  @Get(path: 'travailleurs/{id}')
  Future<Response> getTravailleurById(@Path('id') int id);

  @Post(path: 'travailleurs/login')
  Future<Response> travailleurLogin(@Body() Map<String, String> credential);

  @Post(path: 'travailleurs/creer')
  Future<Response> createTravailleur(
    @Body() Map<String, dynamic> body,
  );

  @Post(path: 'annonceurs/particuliers/creer')
  Future<Response> createAnnonceurParticulier(
    @Body() Map<String, dynamic> body,
  );

  @Post(path: 'annonceurs/entreprises/creer')
  Future<Response> createAnnonceurEntreprises(
    @Body() Map<String, dynamic> body,
  );

  @Post(path: 'annonceurs/entreprises/modifier/client/{id}')
  Future<Response> updateAnnonceurEntreprise(
    @Path('id') int annonceurID,
    @Body() Map<String, dynamic> body,
  );

  @Post(path: 'annonceurs/particulier/modifier/client/{id}')
  Future<Response> updateAnnonceurParticulier(
    @Path('id') int annonceurID,
    @Body() Map<String, dynamic> body,
  );

  @Post(path: 'travailleurs/modifier/client/{id}')
  Future<Response> updateTravailleur(
    @Path('id') int travailleurID,
    @Body() Map<String, dynamic> body,
  );

  @Post(path: 'travailleurs/image_profile/upload/{id}')
  @multipart
  Future<Response> changeTravailleurPicture(
    @Path('id') int id,
    @PartFile('image') String bytes,
  );

  @Post(path: 'annonceurs/entreprises/image_profile/upload/{id}')
  @multipart
  Future<Response> changeAnnonceurEntreprisePicture(
    @Path('id') int id,
    @PartFile('image') String bytes,
  );

  @Post(path: 'annonceurs/particuliers/image_profile/upload/{id}')
  @multipart
  Future<Response> changeAnnonceurParticulierPicture(
    @Path('id') int id,
    @PartFile('image') String bytes,
  );
}
