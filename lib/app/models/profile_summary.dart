import 'package:nylo_framework/nylo_framework.dart';
import 'package:plateau/app/models/profile.dart';

class ProfileSummary extends Model {
  static StorageKey key = "profile_summary";

  final int placesCount;
  final String? wallet, visibility;
  final Profile? profile;

  ProfileSummary(this.placesCount, this.profile, this.wallet, this.visibility)
      : super(key: key);

  ProfileSummary.fromJson(data)
      : profile =
            data['profile'] != null ? Profile.fromJson(data['profile']) : null,
        placesCount = data['placesCount'] as int,
        wallet = data['wallet'] as String?,
        visibility = data['visibility'] as String?,
        super(key: key) {}

  @override
  toJson() => {
        'profile': profile != null ? profile!.toJson() : null,
        'placesCount': placesCount,
        'wallet': wallet,
        'visibility': visibility,
      };
}
