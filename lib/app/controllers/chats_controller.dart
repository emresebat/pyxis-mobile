import 'package:nylo_framework/nylo_framework.dart';
import 'package:plateau/app/controllers/controller.dart';
import 'package:plateau/app/models/chat.dart';
import 'package:plateau/app/models/message.dart';
import 'package:plateau/app/networking/chats_api_service.dart';
import 'package:flutter/widgets.dart';

class ChatsController extends Controller {
  @override
  construct(BuildContext context) {
    super.construct(context);
  }

  Future<List<Chat>?> getChats() async {
    return await api<ChatsApiService>((request) => request.getChats());
  }

  Future<Chat?> getChat(String id) async {
    return await api<ChatsApiService>(
      (request) => request.getById(id),
      onError: (dioException) => null,
    );
  }

  Future<Message?> postMessage(String id, String content) async {
    return await api<ChatsApiService>(
      (request) => request.postMessage(id, content),
      onError: (dioException) => null,
    );
  }
}
