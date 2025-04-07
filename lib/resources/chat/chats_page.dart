import 'package:flutter/material.dart';
import 'package:nylo_framework/nylo_framework.dart';
import 'package:plateau/app/controllers/chats_controller.dart';
import 'package:plateau/app/models/chat.dart';
import 'package:plateau/resources/chat/view_chat_page.dart';
import 'package:plateau/resources/widgets/avatar_widget.dart';
import '/bootstrap/extensions.dart';

class ChatsPage extends NyStatefulWidget<ChatsController> {
  static RouteView path = ("/chats", (_) => ChatsPage());

  ChatsPage({super.key}) : super(child: () => _ChatsPageState());
}

class _ChatsPageState extends NyState<ChatsPage> {
  static const String pageCode = "C1 ";
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
              child: (context, item) {
                var chat = item as Chat;
                var fromProfile = chat.getFromParticipant();
                return ListTile(
                  leading: Avatar(
                    radius: 20,
                    imageUrl: fromProfile?.avatarUrl,
                    initials: fromProfile?.getInitials(),
                  ),
                  title: Text(chat.place?.name ?? ''),
                  trailing: Text(chat.createdAt!.toDateString()),
                  onTap: () => routeTo(
                    ViewChatPage.path,
                    data: item.id,
                  ),
                );
              },
              separatorBuilder: (context, index) => Divider(),
              data: (int iteration) async {
                if (iteration == 1) {
                  return await _loadData();
                }
                return [];
              })),
    );
  }
}
