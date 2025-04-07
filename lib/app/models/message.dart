import 'package:nylo_framework/nylo_framework.dart';
import 'package:plateau/app/models/profile.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class Message extends Model {
  static StorageKey key = "message";

  final String id, profileId, content;
  final DateTime? createdAt;
  final bool isMine;
  final Profile? profile;

  Message(this.id, this.content, this.createdAt, this.profileId, this.isMine,
      this.profile)
      : super(key: key);

  Message.fromJson(data)
      : id = data['id'],
        profileId = data['profile_id'],
        content = data['content'],
        createdAt = data['created_at'] != null
            ? DateTime.parse(data['created_at'])
            : null,
        isMine =
            data['profile_id'] == Supabase.instance.client.auth.currentUser?.id,
        profile =
            data['profile'] != null ? Profile.fromJson(data['profile']) : null,
        super(key: key) {}

  @override
  toJson() => {
        'id': id,
        'content': content,
        'profileId': profileId,
        'isMine': isMine,
        'profile': profile?.toJson(),
        'createdAt': createdAt?.toIso8601String()
      };
}
