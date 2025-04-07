import 'package:nylo_framework/nylo_framework.dart';

class Profile extends Model {
  static StorageKey key = 'profile';

  final String id;
  final String? username, email, fullName, avatarUrl;

  Profile(this.username, this.email, this.fullName, this.avatarUrl, this.id)
      : super(key: key);

  Profile.fromJson(dynamic data)
      : id = data['id'],
        username = data['username'],
        email = data['email'] ?? '',
        fullName = data['full_name'] ?? '',
        avatarUrl = data['avatar_url'] ?? '',
        super(key: key);

  getInitials() {
    if (fullName != null) {
      final names = fullName!.split(' ');
      if (names.length > 1) {
        return names[0][0] + names[1][0];
      }
      return names[0][0];
    }
    return '';
  }

  hasAvatar() => avatarUrl != null && avatarUrl!.isNotEmpty;

  @override
  toJson() => {
        "id": id,
        "username": username,
        "email": email,
        "full_name": fullName,
        "avatar_url": avatarUrl
      };
}
