import 'package:flutter/material.dart';
import 'package:nylo_framework/nylo_framework.dart';

class ChatTab extends StatefulWidget {
  const ChatTab({super.key});

  @override
  createState() => _ChatTabState();
}

class _ChatTabState extends NyState<ChatTab> {
  @override
  get init => () {};

  @override
  Widget view(BuildContext context) {
    return Container(
      child: Center(
        child: Text("Chat Tab"),
      ),
    );
  }
}
