import 'package:flutter/material.dart';
import 'package:nylo_framework/nylo_framework.dart';

class OfflinePage extends NyStatefulWidget {
  static RouteView path = ("/offline", (_) => OfflinePage());

  OfflinePage({super.key}) : super(child: () => _OfflinePageState());
}

class _OfflinePageState extends NyState<OfflinePage> {
  @override
  get init => () {};

  @override
  Widget view(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(title: Text("Not Found")),
      body: SafeArea(
        child: Center(
          child: Text("App is offline"),
        ),
      ),
    );
  }
}
