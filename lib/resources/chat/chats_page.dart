import 'package:flutter/material.dart';
import 'package:nylo_framework/nylo_framework.dart';
import 'package:plateau/app/controllers/chats_controller.dart';
import 'package:plateau/app/models/chat.dart';
import 'package:plateau/resources/chat/view_chat_page.dart';
import '/bootstrap/extensions.dart';

class ChatsPage extends NyStatefulWidget<ChatsController> {
  static RouteView path = ("/chats", (_) => ChatsPage());

  ChatsPage({super.key}) : super(child: () => _ChatsPageState());
}

class _ChatsPageState extends NyState<ChatsPage> {
  static const String pageCode = "C1 ";
  final String chatsState = "chatsState";
  List<Chat> _chats = [];

  @override
  LoadingStyle get loadingStyle => LoadingStyle.none();

  @override
  get init => () {};

  Future<List<Chat>> _loadData() async {
    _chats = await widget.controller.getChats() ?? [];
    return _chats;
  }

  @override
  Widget view(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('Chat'),
          centerTitle: true,
          actions: [Text(pageCode).titleSmall(color: Colors.white)]),
      body: SafeArea(
          child: NyPullToRefresh.separated(
        stateName: chatsState,
        loadingStyle: LoadingStyle.skeletonizer(),
        child: (context, item) {
          var chat = item as Chat;
          return ListTile(
            leading: Text(chat.name).titleMedium(),
            title: Text(chat.place?.name ?? ''),
            trailing: Text(chat.createdAt!.toDateString()),
            onTap: () => routeTo(
              ViewChatPage.path,
              data: item.id,
            ),
          );
        },
        separatorBuilder: (context, index) => Divider(),
        data: (int iteration) => _loadData(),
      )),
    );
  }
}
