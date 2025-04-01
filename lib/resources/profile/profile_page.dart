import 'package:flutter/material.dart';
import 'package:plateau/app/controllers/profile/profile_controller.dart';
import 'package:plateau/app/events/logout_event.dart';
import 'package:plateau/app/models/profile.dart';
import 'package:plateau/app/models/profile_section.dart';
import 'package:plateau/app/models/profile_summary.dart';
import 'package:plateau/bootstrap/extensions.dart';
import 'package:plateau/resources/profile/edit_profile_tab_widget.dart';
import 'package:nylo_framework/nylo_framework.dart';
import 'package:plateau/resources/widgets/safearea_widget.dart';
import 'package:plateau/resources/widgets/theme_toggle_widget.dart';

class ProfilePage extends NyStatefulWidget<ProfileController> {
  ProfilePage({super.key}) : super(child: () => _ProfilePageState());
}

class _ProfilePageState extends NyPage<ProfilePage> {
  ProfileSummary? _profileSummary;
  Profile? _profile;

  @override
  LoadingStyle get loadingStyle => LoadingStyle.skeletonizer();

  @override
  get init => () async {
        var result = await widget.controller.getProfileSummary();
        if (result != null) {
          setState(() {
            _profileSummary = result;
            _profile = result.profile;
          });
        }
      };

  @override
  Widget view(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${_profile?.username} \'s Profile'),
        actions: [
          TextButton(
              onPressed: () async {
                var result = await widget.controller.signOut();
                if (result.success) {
                  event<LogoutEvent>();
                } else {
                  showToastOops(description: result.error);
                }
              },
              child: const Text('Sign Out')),
        ],
      ),
      body: SafeAreaWidget(
          child: NyListView.separated(
        child: (BuildContext context, dynamic data) {
          var profileSection = (data as ProfileSection);
          if (_profile != null && profileSection.title == 'Profile') {
            return ListTile(
              leading: CircleAvatar(
                radius: 20,
                backgroundColor: Colors.grey,
                child: _profile?.hasAvatar() == false
                    ? Text(_profile?.getInitials() ?? '')
                    : null,
                backgroundImage: _profile?.hasAvatar() == false
                    ? null
                    : NetworkImage(_profile!.avatarUrl!),
              ),
              title: Text(_profile?.fullName ?? '').titleLarge(),
              trailing: Icon(Icons.edit),
              onTap: () => pushTo(EditProfileTab()),
            );
          } else if (profileSection.title == 'Theme') {
            return ThemeToggle();
          }
          return ListTile(
              title: Text(profileSection.title).titleMedium(),
              trailing: Text(profileSection.detail).titleMedium());
        },
        data: () async {
          return [
            ProfileSection('Profile', 'Edit'),
            ProfileSection('Places', '${_profileSummary?.placesCount} Places'),
            ProfileSection('Wallet', 'None'),
            ProfileSection('History', 'Latest Activity'),
            ProfileSection('Visibility', 'Private'),
            ProfileSection('Theme', '')
          ];
        },
        separatorBuilder: (BuildContext context, int index) {
          return Divider();
        },
      )),
    );
  }
}
