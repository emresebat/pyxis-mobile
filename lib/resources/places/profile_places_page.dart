import 'package:flutter/material.dart';
import 'package:nylo_framework/nylo_framework.dart';
import 'package:plateau/app/controllers/places/profile_places_controller.dart';
import 'package:plateau/app/models/place.dart';
import 'package:plateau/bootstrap/helpers.dart';
import 'package:plateau/resources/places/new_place_page.dart';
import 'package:plateau/resources/places/view_own_place_page.dart';

class ProfilePlacesPage extends NyStatefulWidget<ProfilePlacesController> {
  static RouteView path = ("/profile-places", (_) => ProfilePlacesPage());

  ProfilePlacesPage({super.key})
      : super(child: () => _ProfilePlacesPageState());
}

class _ProfilePlacesPageState extends NyPage<ProfilePlacesPage> {
  static const String pageCode = "U5 ";

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
        title: Text("Profile Places"),
        centerTitle: true,
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
      body: SafeArea(
        child: NyPullToRefresh.separated(
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
            onTap: () {
              routeTo(ViewOwnPlacePage.path, data: item.id.toString());
            },
          ),
          separatorBuilder: (context, index) => Divider(),
          data: (int iteration) => _places,
        ),
      ),
    );
  }
}
