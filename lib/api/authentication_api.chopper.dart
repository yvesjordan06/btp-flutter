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
  Future<Response> travailleurLogin(Map<String, String> credential) {
    final $url = '/travailleurs/login';
    final $body = credential;
    final $request = Request('POST', $url, client.baseUrl, body: $body);
    return client.send<dynamic, dynamic>($request);
  }
}
