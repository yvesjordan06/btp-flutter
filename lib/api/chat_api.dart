import 'package:chopper/chopper.dart';

part 'chat_api.chopper.dart';

@ChopperApi(baseUrl: '/chats')
abstract class ChatApi extends ChopperService {
  static ChatApi create([ChopperClient client]) => _$ChatApi(client);
  @Get()
  Future<Response> getChats();

  @Get(path:'/annonceur/{id}')
  Future<Response> getChatsForAnnonceur(@Path('id') int id);

  @Get(path:'/travailleur/{id}')
  Future<Response> getChatsForTravailleur(@Path('id') int id);

  @Get(path:'/annonce/{id}')
  Future<Response> getChatsForAnnonce(@Path('id') int id);

  @Get(path:'/message/chat/{id}')
  Future<Response> getMessagesForChat(@Path('id') int id);

  @Post(path:'/creer')
  Future<Response> createChat(
      @Body() Map<String, dynamic> body,
      );

  @Post(path:'/message/{chatID}')
  Future<Response> sendMessage(
      @Path('chatID') int chatID,
      @Body() Map<String, dynamic> body,
      );

  @Post(path:'/message/image/upload/{chatID}')
  @multipart
  Future<Response> sendImage(
      @Path('chatID') int chatID,
      @PartFile('file') List<int> bytes,
      );

  @Post(path:'/entreprise/creer')
  Future<Response> postChatEntreprise(
      @Body() Map<String, dynamic> body,
      );

}
