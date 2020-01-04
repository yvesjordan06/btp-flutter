// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'annonce_api.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

class _$AnnonceApi extends AnnonceApi {
  _$AnnonceApi([ChopperClient client]) {
    if (client == null) return;
    this.client = client;
  }

  @override
  final definitionType = AnnonceApi;

  @override
  Future<Response> getAnnonces() {
    final $url = '/annonces';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response> getAnnonce(int id) {
    final $url = '/annonces/$id';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response> getAnnoncesParticulier() {
    final $url = '/annonces/particulier';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response> getAnnoncesEntreprise() {
    final $url = '/annonces/entreprise';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response> getAnnonceByParticulier(int id) {
    final $url = '/annonces/annonceur/particulier/$id';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response> getAnnoncesForTravailleur(int id) {
    final $url = '/annonces/travailleur/$id';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response> postAnnonceParticulier(Map<String, dynamic> body) {
    final $url = '/annonces/particulier/creer';
    final $body = body;
    final $request = Request('POST', $url, client.baseUrl, body: $body);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response> postAnnonceEntreprise(Map<String, dynamic> body) {
    final $url = '/annonces/entreprise/creer';
    final $body = body;
    final $request = Request('POST', $url, client.baseUrl, body: $body);
    return client.send<dynamic, dynamic>($request);
  }
}
