import 'package:apple_maps_flutter/apple_maps_flutter.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nylo_framework/nylo_framework.dart';
import 'package:plateau/app/controllers/places/view_new_place_controller.dart';
import 'package:plateau/app/models/place.dart';
import 'package:plateau/app/models/list_item.dart';
import 'package:plateau/bootstrap/helpers.dart';
import 'package:plateau/resources/places/edit_new_place_page.dart';
import 'package:plateau/resources/widgets/buttons/buttons.dart';

class ViewNewPlacePage extends NyStatefulWidget<ViewNewPlaceController> {
  static RouteView path = ("/view-new-place", (_) => ViewNewPlacePage());

  ViewNewPlacePage({super.key}) : super(child: () => _ViewNewPlacePageState());
}

class _ViewNewPlacePageState extends NyPage<ViewNewPlacePage> {
  static const String pageCode = "P2 ";
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
          title: Text("View New Place"),
          centerTitle: true,
          actions: [Text(pageCode).titleSmall(color: Colors.white)]),
      body: SafeArea(
        minimum: const EdgeInsets.symmetric(horizontal: 25, vertical: 25),
        child: _place != null
            ? Container(
                padding: const EdgeInsets.all(25),
                child: NyListView.separated(
                  child: (BuildContext context, dynamic data) {
                    var listItem = (data as ListItem);
                    return listItem.displayWidget!;
                  },
                  data: () {
                    return [
                      ListItem(
                        'Title',
                        displayWidget: Text(_place!.name).titleLarge(),
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
                      ListItem('Image',
                          displayWidget: ListTile(
                            leading: SizedBox(
                                height: 50,
                                width: 50,
                                child: Image(
                                    fit: BoxFit.cover,
                                    image: NetworkImage(ImagePlaceholder.get(
                                        _place?.thumbnailUrl, 50, 50,
                                        text: _place?.name)))),
                            trailing: Text('Add Image').titleLarge(),
                            onTap: () async {
                              final picker = ImagePicker();
                              final imageFile = await picker.pickImage(
                                source: ImageSource.gallery,
                                maxWidth: 300,
                                maxHeight: 300,
                              );
                            },
                          )),
                      ListItem('Done',
                          displayWidget: Button.primary(
                              text: "Done",
                              onPressed: () {
                                routeTo(EditNewPlacePage.path,
                                    navigationType: NavigationType.pushReplace,
                                    data: _place?.id);
                              })),
                    ];
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return Divider();
                  },
                ))
            : Container(),
      ),
    );
  }
}
