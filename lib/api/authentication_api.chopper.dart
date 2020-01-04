// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'authentication_api.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

class _$AuthenticationApi extends AuthenticationApi {
  _$AuthenticationApi([ChopperClient client]) {
    if (client == null) return;
    this.client = client;
  }

  @override
  final definitionType = AuthenticationApi;

  @override
  Future<Response> _authenticateApi(Map<String, String> body) {
    final $url = '/auth-tokens';
    final $body = body;
    final $request = Request('POST', $url, client.baseUrl, body: $body);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response> annonceurLogin(Map<String, String> credential) {
    final $url = '/annonceurs/login';
    final $body = credential;
    final $request = Request('POST', $url, client.baseUrl, body: $body);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response> getAnnonceurParticulierById(int id) {
    final $url = '/annonceurs/particuliers/$id';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response> getAnnonceurEntrepriseById(int id) {
    final $url = '/annonceurs/entreprises/$id';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response> getTravailleurById(int id) {
    final $url = '/travailleurs/$id';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response> travailleurLogin(Map<String, String> credential) {
    final $url = '/travailleurs/login';
    final $body = credential;
    final $request = Request('POST', $url, client.baseUrl, body: $body);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response> createTravailleur(Map<String, dynamic> body) {
    final $url = '/travailleurs/creer';
    final $body = body;
    final $request = Request('POST', $url, client.baseUrl, body: $body);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response> createAnnonceurParticulier(Map<String, dynamic> body) {
    final $url = '/annonceurs/particuliers/creer';
    final $body = body;
    final $request = Request('POST', $url, client.baseUrl, body: $body);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response> createAnnonceurEntreprises(Map<String, dynamic> body) {
    final $url = '/annonceurs/entreprises/creer';
    final $body = body;
    final $request = Request('POST', $url, client.baseUrl, body: $body);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response> updateAnnonceurEntreprise(
      int annonceurID, Map<String, dynamic> body) {
    final $url = '/annonceurs/entreprises/modifier/clients/$annonceurID';
    final $body = body;
    final $request = Request('POST', $url, client.baseUrl, body: $body);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response> updateAnnonceurParticulier(
      int annonceurID, Map<String, dynamic> body) {
    final $url = '/annonceurs/particulier/modifier/clients/$annonceurID';
    final $body = body;
    final $request = Request('POST', $url, client.baseUrl, body: $body);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response> updateTravailleur(
      int travailleurID, Map<String, dynamic> body) {
    final $url = '/travailleur/modifier/clients/$travailleurID';
    final $body = body;
    final $request = Request('POST', $url, client.baseUrl, body: $body);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response> changeTravailleurPicture(int id, List<int> bytes) {
    final $url = '/travailleurs/image_profile/upload/$id';
    final $parts = <PartValue>[PartValueFile<List<int>>('image', bytes)];
    final $request =
        Request('POST', $url, client.baseUrl, parts: $parts, multipart: true);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response> changeAnnonceurEntreprisePicture(int id, List<int> bytes) {
    final $url = '/annonceurs/entreprises/image_profile/upload/$id';
    final $parts = <PartValue>[PartValueFile<List<int>>('image', bytes)];
    final $request =
        Request('POST', $url, client.baseUrl, parts: $parts, multipart: true);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response> changeAnnonceurParticulierPicture(int id, String bytes) {
    final $url = '/annonceurs/particuliers/image_profile/upload/$id';
    final $parts = <PartValue>[PartValueFile<String>('image', bytes)];
    final $request =
        Request('POST', $url, client.baseUrl, parts: $parts, multipart: true);
    return client.send<dynamic, dynamic>($request);
  }
}
