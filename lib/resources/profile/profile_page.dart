import 'package:flutter/material.dart';
import 'package:plateau/app/controllers/profile/user_controller.dart';
import 'package:plateau/app/events/logout_event.dart';
import 'package:plateau/app/models/profile.dart';
import 'package:plateau/app/models/profile_section.dart';
import 'package:plateau/resources/profile/edit_profile_tab_widget.dart';
import 'package:nylo_framework/nylo_framework.dart';

class ProfilePage extends NyStatefulWidget<UserController> {
  ProfilePage({super.key}) : super(child: () => _ProfilePageState());
}

class _ProfilePageState extends NyPage<ProfilePage> {
  Profile? _profile;

  @override
  LoadingStyle get loadingStyle => LoadingStyle.skeletonizer();

  @override
  get init => () async {
        var result = await widget.controller.getProfile();
        if (result.profile != null) {
          setState(() {
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
      body: Container(
          padding: const EdgeInsets.all(20),
          child: NyListView.separated(
            child: (BuildContext context, dynamic data) {
              var profileSection = (data as ProfileSection);
              if (_profile != null && profileSection.title == 'Profile') {
                return ListTile(
                  leading: CircleAvatar(
                    radius: 20,
                    backgroundColor: Colors.grey,
                    child: _profile?.hasAvatar() == false
                        ? Text(_profile?.initials ?? '')
                        : null,
                    backgroundImage: _profile?.hasAvatar() == false
                        ? null
                        : NetworkImage(_profile!.avatarUrl!),
                  ),
                  title: Text(_profile?.fullName ?? ''),
                  trailing: Icon(Icons.edit),
                  onTap: () => pushTo(EditProfileTab()),
                );
              }
              return ListTile(
                  title: Text(profileSection.title),
                  trailing: Text(profileSection.detail));
            },
            data: () async {
              return [
                ProfileSection('Profile', 'Edit'),
                ProfileSection('Places', '0 Places'),
                ProfileSection('Wallet', 'None'),
                ProfileSection('History', 'Latest Activity'),
                ProfileSection('Visibility', 'Private'),
              ];
            },
            separatorBuilder: (BuildContext context, int index) {
              return Divider();
            },
          )),
    );
  }
}
