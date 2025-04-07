import 'package:flutter/material.dart';
import 'package:nylo_framework/nylo_framework.dart';

class ProfileHistoryPage extends NyStatefulWidget {
  static RouteView path = ("/profile-history", (_) => ProfileHistoryPage());

  ProfileHistoryPage({super.key})
      : super(child: () => _ProfileHistoryPageState());
}

class _ProfileHistoryPageState extends NyPage<ProfileHistoryPage> {
  static const String pageCode = "U3 ";

  @override
  get init => () {};

  @override
  Widget view(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile History"),
        centerTitle: true,
        actions: [
          Text(pageCode).titleSmall(color: Colors.white),
        ],
      ),
      body: SafeArea(
        child: Container(),
      ),
    );
  }
}
