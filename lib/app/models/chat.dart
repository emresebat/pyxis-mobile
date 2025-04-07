import 'package:nylo_framework/nylo_framework.dart';
import 'package:plateau/app/models/message.dart';
import 'package:plateau/app/models/place.dart';

class Chat extends Model {
  static StorageKey key = "chat";

  final String id, name;
  final DateTime? createdAt;
  final Place? place;
  final List<Message>? messages;

  Chat(this.id, this.name, this.createdAt, this.messages, this.place)
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
        super(key: key) {}

  @override
  toJson() => {
        'id': id,
        'name': name,
        'created_at': createdAt?.toIso8601String(),
        'messages': messages?.map((message) => message.toJson()).toList(),
        'place': place?.toJson(),
      };
}
