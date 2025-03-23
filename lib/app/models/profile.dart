import 'package:nylo_framework/nylo_framework.dart';

class Profile extends Model {
  String? username, email, fullName, avatarUrl;
  String initials = 'U';

  static StorageKey key = 'profile';

  Profile() : super(key: key);

  Profile.fromJson(dynamic data) {
    username = data['username'];
    email = data['email'];
    fullName = data['full_name'];
    avatarUrl = data['avatar_url'];
    initials = _getInitials();
  }

  _getInitials() {
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
        "username": username,
        "email": email,
        "full_name": fullName,
        "avatar_url": avatarUrl
      };
}
