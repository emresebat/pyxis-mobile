import 'package:flutter/material.dart';
import 'package:nylo_framework/nylo_framework.dart';

class ProfileWalletPage extends NyStatefulWidget {
  static RouteView path = ("/profile-wallet", (_) => ProfileWalletPage());

  ProfileWalletPage({super.key})
      : super(child: () => _ProfileWalletPageState());
}

class _ProfileWalletPageState extends NyPage<ProfileWalletPage> {
  static const String pageCode = "8 ";

  @override
  get init => () {};

  @override
  Widget view(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile Wallet"),
        centerTitle: true,
        actions: [
          Text(pageCode).titleSmall(),
        ],
      ),
      body: SafeArea(
        child: Container(),
      ),
    );
  }
}
