import 'package:flutter/material.dart';
import 'package:nylo_framework/nylo_framework.dart';

class ProfileVisibilityPage extends NyStatefulWidget {
  static RouteView path =
      ("/profile-visibility", (_) => ProfileVisibilityPage());

  ProfileVisibilityPage({super.key})
      : super(child: () => _ProfileVisibilityPageState());
}

class _ProfileVisibilityPageState extends NyPage<ProfileVisibilityPage> {
  static const String pageCode = "U2 ";

  @override
  get init => () {};

  @override
  Widget view(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile Visibility"),
        centerTitle: true,
        actions: [
          Text(pageCode).titleSmall(color: Colors.white),
        ],
      ),
      body: SafeArea(
          child: NyListView.separated(
        child: (context, item) => ListTile(
          leading: Text(item["title"]).titleLarge(),
          trailing: Text(item["detail"]).titleMedium(),
        ),
        data: () => [
          {"title": "Places", "detail": "Always"},
          {"title": "Friends", "detail": "Ask"},
        ],
        separatorBuilder: (BuildContext context, int index) {
          return Divider();
        },
      )),
    );
  }
}
