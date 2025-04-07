import 'package:flutter/material.dart';
import 'package:nylo_framework/nylo_framework.dart';

class MessageBarWidget extends StatefulWidget {
  final Future<bool> Function(String) onSendMessage;

  const MessageBarWidget({Key? key, required this.onSendMessage})
      : super(key: key);

  @override
  State<MessageBarWidget> createState() => _MessageBarWidgetState();
}

class _MessageBarWidgetState extends State<MessageBarWidget> {
  late final TextEditingController _textController;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.grey[200],
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Expanded(
                child: TextFormField(
                  keyboardType: TextInputType.text,
                  maxLines: null,
                  autofocus: true,
                  controller: _textController,
                  decoration: const InputDecoration(
                    hintText: 'Type a message',
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    contentPadding: EdgeInsets.all(8),
                  ),
                  style: context.textTheme().bodyMedium,
                ),
              ),
              IconButton(
                onPressed: () async {
                  var success =
                      await widget.onSendMessage(_textController.text);
                  if (success) {
                    _textController.clear();
                  }
                },
                icon: const Icon(
                  Icons.send,
                  color: Colors.blue,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    _textController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }
}
