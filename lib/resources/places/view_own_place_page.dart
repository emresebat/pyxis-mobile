import 'package:apple_maps_flutter/apple_maps_flutter.dart';
import 'package:flutter/material.dart';
import 'package:nylo_framework/nylo_framework.dart';
import 'package:plateau/app/controllers/places/view_own_place_controller.dart';
import 'package:plateau/app/models/place.dart';
import 'package:plateau/app/models/list_item.dart';
import 'package:plateau/resources/places/own_place_visits_page.dart';
import 'package:plateau/resources/widgets/buttons/buttons.dart';

class ViewOwnPlacePage extends NyStatefulWidget<ViewOwnPlaceController> {
  static RouteView path = ("/view-own-place", (_) => ViewOwnPlacePage());

  ViewOwnPlacePage({super.key}) : super(child: () => _ViewOwnPlacePageState());
}

class _ViewOwnPlacePageState extends NyPage<ViewOwnPlacePage> {
  static const String pageCode = "T1 ";
  Place? _place;

  @override
  LoadingStyle get loadingStyle => LoadingStyle.skeletonizer();

  @override
  get init => () async {
        var placeId = widget.data() as String;
        var result = await widget.controller.getPlace(placeId);
        setState(() {
          _place = result;
        });
      };

  @override
  Widget view(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_place?.name ?? "View Own Place"),
        centerTitle: true,
        actions: [
          Text(pageCode).titleSmall(color: Colors.white),
        ],
      ),
      body: SafeArea(
        minimum: const EdgeInsets.symmetric(horizontal: 25, vertical: 25),
        child: _place != null
            ? NyListView.separated(
                child: (BuildContext context, dynamic data) {
                  var listItem = (data as ListItem);
                  return listItem.displayWidget!;
                },
                data: () {
                  return [
                    ListItem(
                      'Title',
                      displayWidget: Text(_place!.description).titleLarge(),
                    ),
                    ListItem('Map',
                        displayWidget: SizedBox(
                            height: 250,
                            child: AppleMap(
                              onMapCreated: widget.controller.onMapCreated,
                              initialCameraPosition: CameraPosition(
                                target: widget.controller.currentCoords,
                                zoom: 15.0,
                              ),
                              annotations: Set<Annotation>.of([
                                widget.controller.currentLocationAnnotation
                              ]),
                            ))),
                    ListItem('Visits',
                        displayWidget: ListTile(
                          leading: Icon(Icons.people),
                          title: Text('3 Visits').titleMedium(),
                          trailing: Text('View History').titleMedium(),
                          onTap: () {
                            routeTo(OwnPlaceVisitsPage.path);
                          },
                        )),
                    ListItem('Edit',
                        displayWidget: Button.primary(
                            text: "Edit Place", onPressed: () async {})),
                  ];
                },
                separatorBuilder: (BuildContext context, int index) {
                  return Divider();
                },
              )
            : Container(),
      ),
    );
  }
}
