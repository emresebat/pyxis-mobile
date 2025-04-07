import 'package:flutter/material.dart';
import 'package:nylo_framework/nylo_framework.dart';
import 'package:plateau/app/controllers/chats_controller.dart';
import 'package:plateau/app/models/chat.dart';
import 'package:plateau/app/models/message.dart';
import 'package:plateau/resources/chat/chat_buddle_widget.dart';
import 'package:plateau/resources/chat/message_bar_widget.dart';

class ViewChatPage extends NyStatefulWidget<ChatsController> {
  static RouteView path = ("/view-chat", (_) => ViewChatPage());

  ViewChatPage({super.key}) : super(child: () => _ViewChatPageState());
}

class _ViewChatPageState extends NyState<ViewChatPage> {
  static const String pageCode = "C2 ";
  Chat? _chat;

  @override
  LoadingStyle get loadingStyle => LoadingStyle.skeletonizer();

  @override
  get init => () async {
        var chatId = widget.data() as String;
        _chat = await widget.controller.getChat(chatId);
        _chat?.messages?.sort((a, b) => b.createdAt!.compareTo(a.createdAt!));
      };
  @override
  Widget view(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(_chat?.name ?? 'Chat'),
          centerTitle: true,
          actions: [Text(pageCode).titleSmall(color: Colors.white)]),
      body: SafeArea(
          child: NyPullToRefresh.separated(
        reverse: true,
        child: (context, item) => ChatBubbleWidget(message: item as Message),
        separatorBuilder: (context, index) => Divider(),
        data: (int iteration) => _chat?.messages ?? [],
      )),
      bottomNavigationBar: MessageBarWidget(),
    );
  }
}
