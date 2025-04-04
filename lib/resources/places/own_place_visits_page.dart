import 'package:flutter/material.dart';
import 'package:nylo_framework/nylo_framework.dart';

class OwnPlaceVisitsPage extends NyStatefulWidget {
  static RouteView path = ("/own-place-visits", (_) => OwnPlaceVisitsPage());

  OwnPlaceVisitsPage({super.key})
      : super(child: () => _OwnPlaceVisitsPageState());
}

class _OwnPlaceVisitsPageState extends NyPage<OwnPlaceVisitsPage> {
  static const String pageCode = "17 ";

  @override
  LoadingStyle get loadingStyle => LoadingStyle.skeletonizer();

  @override
  get init => () {};

  @override
  Widget view(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Visits"),
        centerTitle: true,
        actions: [
          Text(pageCode).titleSmall(),
        ],
      ),
      body: SafeArea(
        child: NyPullToRefresh.separated(
          child: (context, item) => ListTile(
            leading: Icon(Icons.person),
            title: Text(item["title"]),
            trailing: Text(item["detail"]),
          ),
          separatorBuilder: (context, index) => Divider(),
          data: (int iteration) => [
            {
              "title": "Ana",
              "detail": "Visited on ${DateTime.now().toIso8601String()}"
            },
            {
              "title": "John",
              "detail": "Visited on ${DateTime.now().toIso8601String()}"
            },
            {
              "title": "Visitor 3",
              "detail": "Visited on ${DateTime.now().toIso8601String()}"
            },
          ],
        ),
      ),
    );
  }
}
