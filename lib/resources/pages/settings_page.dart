import 'package:flutter/material.dart';
import 'package:flutter_app/app/events/logout_event.dart';
import 'package:nylo_framework/nylo_framework.dart';

class SettingsPage extends NyStatefulWidget {
  static RouteView path = ("/settings", (_) => SettingsPage());

  SettingsPage({super.key}) : super(child: () => _SettingsPageState());
}

class _SettingsPageState extends NyPage<SettingsPage> {
  @override
  get init => () {};

  @override
  Widget view(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Settings"),
        actions: [
          IconButton(
              onPressed: () => event<LogoutEvent>(), icon: Icon(Icons.logout))
        ],
      ),
      body: SafeArea(
        child: Container(),
      ),
    );
  }
}
