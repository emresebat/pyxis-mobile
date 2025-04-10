import 'package:plateau/app/controllers/controller.dart';
import 'package:plateau/app/models/chat.dart';
import 'package:plateau/app/models/message.dart';
import 'package:flutter/widgets.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ChatsController extends Controller {
  @override
  construct(BuildContext context) {
    super.construct(context);
  }

  Future<List<Chat>?> getChats() async {
    final supabase = Supabase.instance.client;
    final userId = supabase.auth.currentUser!.id;
    final data = await supabase.from('chat_participants').select('''
        chat:chats(
            id, name, created_at,
            participants:chat_participants (
                profile:profiles(id, username, full_name, avatar_url)
        ),         
        place:places(id, slug, name))''').eq('profile_id', userId);
    return data.map<Chat>((json) => Chat.fromJson(json['chat'])).toList();
  }

  Future<Chat?> getChat(String id) async {
    final supabase = Supabase.instance.client;

    final data = await supabase.from('chats').select('''
        id, name, created_at,
        messages (id, profile_id, created_at, content, 
            profile:profiles(id, username, full_name, avatar_url)
        ), 
        participants:chat_participants (
            profile:profiles(id, username, full_name, avatar_url)
        ), 
        place:places(id, slug, name)''').eq('id', id).single();

    return Chat.fromJson(data);
  }

  Future<Message?> postMessage(String id, String content) async {
    final supabase = Supabase.instance.client;
    final userId = supabase.auth.currentUser!.id;

    final data = await supabase.from('messages').insert({
      'chat_id': id,
      'profile_id': userId,
      'content': content
    }).select('''
        id, profile_id, created_at, content,
        profile:profiles(id, username, full_name, avatar_url)
        ''').single();

    return Message.fromJson(data, userId: userId);
  }

  Stream<List<Message>> getMessagesStream(String chatId) {
    final supabase = Supabase.instance.client;
    final userId = supabase.auth.currentUser!.id;
    final messagesStream = supabase
        .from('messages')
        .stream(primaryKey: ['id'])
        .eq('chat_id', chatId)
        .order('created_at')
        .map((maps) =>
            maps.map((map) => Message.fromJson(map, userId: userId)).toList());
    return messagesStream;
  }
}
