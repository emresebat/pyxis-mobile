import 'package:apple_maps_flutter/apple_maps_flutter.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nylo_framework/nylo_framework.dart';
import 'package:plateau/app/controllers/places/view_new_place_controller.dart';
import 'package:plateau/app/models/place.dart';
import 'package:plateau/app/models/list_item.dart';
import 'package:plateau/resources/widgets/buttons/buttons.dart';

class ViewNewPlacePage extends NyStatefulWidget<ViewNewPlaceController> {
  static RouteView path = ("/view-new-place", (_) => ViewNewPlacePage());

  ViewNewPlacePage({super.key}) : super(child: () => _ViewNewPlacePageState());
}

class _ViewNewPlacePageState extends NyPage<ViewNewPlacePage> {
  Place? _place;

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
      appBar: AppBar(title: Text("View New Place")),
      body: SafeArea(
        minimum: const EdgeInsets.symmetric(horizontal: 25, vertical: 25),
        child: _place != null
            ? SizedBox(
                height: 600,
                child: Card(
                    clipBehavior: Clip.antiAlias,
                    child: Container(
                        padding: const EdgeInsets.all(25),
                        child: NyListView.separated(
                          child: (BuildContext context, dynamic data) {
                            var listItem = (data as ListItem);
                            return listItem.widget!;
                          },
                          data: () {
                            return [
                              ListItem(
                                'Title',
                                widget: Text(_place!.name).titleLarge(),
                              ),
                              ListItem('Map',
                                  widget: SizedBox(
                                      height: 250,
                                      child: AppleMap(
                                        onMapCreated:
                                            widget.controller.onMapCreated,
                                        initialCameraPosition: CameraPosition(
                                          target:
                                              widget.controller.currentCoords,
                                          zoom: 15.0,
                                        ),
                                        annotations: Set<Annotation>.of([
                                          widget.controller
                                              .currentLocationAnnotation
                                        ]),
                                      ))),
                              ListItem('Image',
                                  widget: ListTile(
                                    title: Text('Add Image').titleLarge(),
                                    trailing: Icon(Icons.edit),
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
                                  widget: Button.primary(
                                      text: "Done", onPressed: () async {})),
                            ];
                          },
                          separatorBuilder: (BuildContext context, int index) {
                            return Divider();
                          },
                        ))))
            : Container(),
      ),
    );
  }
}
