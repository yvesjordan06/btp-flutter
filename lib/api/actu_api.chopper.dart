// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'actu_api.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

class _$ActuApi extends ActuApi {
  _$ActuApi([ChopperClient client]) {
    if (client == null) return;
    this.client = client;
  }

  @override
  final definitionType = ActuApi;

  @override
  Future<Response> getActus() {
    final $url = '/realisations';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response> getActu(int id) {
    final $url = '/realisations/$id';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response> getActusByTravailleur(int id) {
    final $url = '/realisations/travailleur/$id';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response> createActu(Map<String, dynamic> body) {
    final $url = '/realisations/creer';
    final $body = body;
    final $request = Request('POST', $url, client.baseUrl, body: $body);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response> sendMessage(int chatID, Map<String, dynamic> body) {
    final $url = '/realisations/message/$chatID';
    final $body = body;
    final $request = Request('POST', $url, client.baseUrl, body: $body);
    return client.send<dynamic, dynamic>($request);
  }

  Future<Response> sendImagse(int actuID, List<int> bytes) {
    final $url = '/realisations/images/upload/$actuID';
    final $parts = <PartValue>[PartValueFile<List<int>>('file', bytes)];
    final $request =
        Request('POST', $url, client.baseUrl, parts: $parts, multipart: true);
    return client.send<dynamic, dynamic>($request);
  }
}
