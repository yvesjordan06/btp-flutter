// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_api.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

class _$ChatApi extends ChatApi {
  _$ChatApi([ChopperClient client]) {
    if (client == null) return;
    this.client = client;
  }

  @override
  final definitionType = ChatApi;

  @override
  Future<Response> getChats() {
    final $url = '/chats';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response> getChatsForAnnonceur(int id) {
    final $url = '/chats/annonceur/$id';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response> getChatsForTravailleur(int id) {
    final $url = '/chats/travailleur/$id';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response> getChatsForAnnonce(int id) {
    final $url = '/chats/annonce/$id';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response> getMessagesForChat(int id) {
    final $url = '/chats/message/chat/$id';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response> createChat(Map<String, dynamic> body) {
    final $url = '/chats/creer';
    final $body = body;
    final $request = Request('POST', $url, client.baseUrl, body: $body);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response> sendMessage(int chatID, Map<String, dynamic> body) {
    final $url = '/chats/message/$chatID';
    final $body = body;
    final $request = Request('POST', $url, client.baseUrl, body: $body);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response> sendImage(int chatID, List<int> bytes) {
    final $url = '/chats/message/image/upload/$chatID';
    final $parts = <PartValue>[PartValueFile<List<int>>('file', bytes)];
    final $request =
        Request('POST', $url, client.baseUrl, parts: $parts, multipart: true);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response> postChatEntreprise(Map<String, dynamic> body) {
    final $url = '/chats/entreprise/creer';
    final $body = body;
    final $request = Request('POST', $url, client.baseUrl, body: $body);
    return client.send<dynamic, dynamic>($request);
  }
}
