import 'package:flutter/material.dart';
import 'package:plateau/app/controllers/profile/profile_controller.dart';
import 'package:plateau/app/events/logout_event.dart';
import 'package:plateau/app/models/list_item.dart';
import 'package:plateau/app/models/profile.dart';
import 'package:plateau/app/models/profile_summary.dart';
import 'package:plateau/resources/profile/edit_profile_tab_widget.dart';
import 'package:nylo_framework/nylo_framework.dart';
import 'package:plateau/resources/widgets/avatar_widget.dart';
import 'package:plateau/resources/widgets/safearea_widget.dart';

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
          child: NyPullToRefresh.separated(
        child: (BuildContext context, dynamic data) {
          var listItem = (data as ListItem);
          if (listItem.widget != null) {
            return listItem.widget!;
          }
          return ListTile(
              title: Text(listItem.title).titleMedium(),
              trailing: Text(listItem.detail ?? '').titleMedium());
        },
        data: (int iteration) {
          return [
            ListItem('Profile',
                detail: 'Edit',
                widget: ListTile(
                  leading: Avatar(
                    radius: 20,
                    imageUrl: _profile?.avatarUrl,
                    initials: _profile?.getInitials(),
                  ),
                  title: Text(_profile?.fullName ?? '').titleLarge(),
                  trailing: Icon(Icons.edit),
                  onTap: () => pushTo(EditProfileTab()),
                )),
            ListItem('Places',
                detail: '${_profileSummary?.placesCount} Places'),
            ListItem('Wallet', detail: '${_profileSummary?.wallet}'),
            ListItem('History', detail: 'Latest Activity'),
            ListItem('Visibility', detail: '${_profileSummary?.visibility}')
          ];
        },
        separatorBuilder: (BuildContext context, int index) {
          return Divider();
        },
      )),
    );
  }
}
