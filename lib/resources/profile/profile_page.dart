import 'package:flutter/material.dart';
import 'package:plateau/app/controllers/profile/profile_controller.dart';
import 'package:plateau/app/models/list_item.dart';
import 'package:plateau/app/models/profile.dart';
import 'package:plateau/app/models/profile_summary.dart';
import 'package:plateau/resources/places/profile_places_page.dart';
import 'package:plateau/resources/places/profile_history_page.dart';
import 'package:plateau/resources/places/profile_visibility_page.dart';
import 'package:plateau/resources/places/profile_wallet_page.dart';
import 'package:plateau/resources/profile/edit_profile_page.dart';
import 'package:nylo_framework/nylo_framework.dart';
import 'package:plateau/resources/widgets/avatar_widget.dart';
import 'package:plateau/resources/widgets/safearea_widget.dart';

class ProfilePage extends NyStatefulWidget<ProfileController> {
  static RouteView path = ("/profile", (_) => ProfilePage());

  ProfilePage({super.key}) : super(child: () => _ProfilePageState());
}

class _ProfilePageState extends NyPage<ProfilePage> {
  static const String pageCode = "U1 ";
  ProfileSummary? _profileSummary;
  Profile? _profile;

  @override
  LoadingStyle get loadingStyle => LoadingStyle.none();

  @override
  get init => () {};

  _loadData() async {
    var result = await widget.controller.getProfileSummary();
    if (result != null) {
      setState(() {
        _profileSummary = result;
        _profile = result.profile;
      });
    }
  }

  @override
  Widget view(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            _profile != null ? '${_profile?.username} \'s Profile' : 'Profile'),
        centerTitle: true,
        actions: [Text(pageCode).titleSmall(color: Colors.white)],
      ),
      body: SafeAreaWidget(
          child: NyPullToRefresh.separated(
        loadingStyle: LoadingStyle.skeletonizer(),
        child: (BuildContext context, dynamic data) {
          var listItem = (data as ListItem);
          if (listItem.displayWidget != null) {
            return listItem.displayWidget!;
          }
          return ListTile(
            title: Text(listItem.title).titleMedium(),
            trailing: Text(listItem.detail ?? '').titleMedium(),
            onTap: () {
              if (listItem.pushToWidget == null) {
                return;
              }
              pushTo(listItem.pushToWidget!);
            },
          );
        },
        data: (int iteration) async {
          await _loadData();
          return [
            ListItem('Profile',
                detail: 'Edit',
                displayWidget: ListTile(
                  leading: Avatar(
                    radius: 20,
                    imageUrl: _profile?.avatarUrl,
                    initials: _profile?.getInitials(),
                  ),
                  title: Text(_profile?.fullName ?? '').titleLarge(),
                  trailing: Icon(Icons.edit),
                  onTap: () => pushTo(EditProfilePage()),
                )),
            ListItem('Places',
                detail: '${_profileSummary?.placesCount} Places',
                pushToWidget: ProfilePlacesPage()),
            ListItem('Wallet',
                detail: '${_profileSummary?.wallet}',
                pushToWidget: ProfileWalletPage()),
            ListItem('History',
                detail: 'Latest Activity', pushToWidget: ProfileHistoryPage()),
            ListItem('Visibility',
                detail: '${_profileSummary?.visibility}',
                pushToWidget: ProfileVisibilityPage()),
          ];
        },
        separatorBuilder: (BuildContext context, int index) {
          return Divider();
        },
      )),
    );
  }
}
