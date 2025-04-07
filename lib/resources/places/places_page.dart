import 'package:flutter/material.dart';
import 'package:nylo_framework/nylo_framework.dart';
import 'package:plateau/app/controllers/places/places_controller.dart';
import 'package:plateau/app/models/place.dart';
import 'package:plateau/bootstrap/helpers.dart';
import 'package:plateau/resources/places/new_place_page.dart';

class PlacesPage extends NyStatefulWidget<PlacesController> {
  static RouteView path = ("/places", (_) => PlacesPage());

  PlacesPage({super.key}) : super(child: () => _PlacesPageState());
}

class _PlacesPageState extends NyPage<PlacesPage> {
  static const String pageCode = "";

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
      appBar: AppBar(
        centerTitle: true,
        title: Text('Places'),
        actions: [
          Text(pageCode).titleSmall(color: Colors.white),
          IconButton(
              icon: Icon(Icons.add),
              tooltip: 'Add',
              onPressed: () {
                routeTo(NewPlacePage.path);
              })
        ],
      ),
      body: NyPullToRefresh.separated(
        child: (context, item) => ListTile(
          leading: SizedBox(
              height: 50,
              width: 50,
              child: Image(
                  fit: BoxFit.cover,
                  image: NetworkImage(ImagePlaceholder.get(
                      item.thumbnailUrl, 50, 50,
                      text: item.name)))),
          title: Text(item.name),
          subtitle: Text(item.description),
        ),
        separatorBuilder: (context, index) => Divider(),
        data: (int iteration) => _places,
      ),
    );
  }
}
