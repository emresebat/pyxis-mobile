import 'package:flutter/material.dart';
import 'package:nylo_framework/nylo_framework.dart';
import 'package:plateau/app/controllers/places/places_controller.dart';
import 'package:plateau/app/models/place.dart';

class PlacesTab extends NyStatefulWidget<PlacesController> {
  PlacesTab({super.key}) : super(child: () => _PlacesTabState());
}

class _PlacesTabState extends NyPage<PlacesTab> {
  List<Place> _places = [];

  @override
  LoadingStyle get loadingStyle => LoadingStyle.skeletonizer();

  @override
  get init => () async {
        _places = await widget.controller.list() ?? [];
      };

  @override
  Widget view(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Places')),
      body: Center(
        child: NyListView.grid(
          child: (context, item) => ListTile(
            title: Text(item.name),
            subtitle: Text(item.description),
          ),
          data: () => _places,
        ),
      ),
    );
  }
}
