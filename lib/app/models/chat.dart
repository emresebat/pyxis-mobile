import 'package:collection/collection.dart';
import 'package:nylo_framework/nylo_framework.dart';
import 'package:plateau/app/models/message.dart';
import 'package:plateau/app/models/place.dart';
import 'package:plateau/app/models/profile.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class Chat extends Model {
  static StorageKey key = "chat";

  final String id, name;
  final DateTime? createdAt;
  final Place? place;
  final List<Message>? messages;
  final List<Profile>? participants;

  Chat(this.id, this.name, this.createdAt, this.messages, this.place,
      this.participants)
      : super(key: key);

  Chat.fromJson(data)
      : id = data['id'],
        name = data['name'],
        createdAt = data['created_at'] != null
            ? DateTime.parse(data['created_at'])
            : null,
        messages = data['messages'] != null
            ? (data['messages'] as List)
                .map((message) => Message.fromJson(message))
                .toList()
            : null,
        place = data['place'] != null ? Place.fromJson(data['place']) : null,
        participants = data['participants'] != null
            ? (data['participants'] as List)
                .map((participant) => Profile.fromJson(participant['profile']))
                .toList()
            : null,
        super(key: key) {}

  Profile? getFromParticipant() {
    if (participants != null && participants!.isNotEmpty) {
      final fromProfile = participants!.firstWhereOrNull((participant) =>
          participant.id != Supabase.instance.client.auth.currentUser?.id);
      if (fromProfile != null) {
        return fromProfile;
      }
    }
    return null;
  }

  @override
  toJson() => {
        'id': id,
        'name': name,
        'created_at': createdAt?.toIso8601String(),
        'messages': messages?.map((message) => message.toJson()).toList(),
        'place': place?.toJson(),
        'participants':
            participants?.map((participant) => participant.toJson()).toList(),
      };
}
