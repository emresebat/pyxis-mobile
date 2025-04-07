import 'package:apple_maps_flutter/apple_maps_flutter.dart';
import 'package:flutter/material.dart';
import 'package:nylo_framework/nylo_framework.dart';
import 'package:plateau/app/controllers/places/new_place_controller.dart';
import 'package:plateau/resources/places/view_new_place_page.dart';
import 'package:plateau/resources/widgets/buttons/buttons.dart';

class NewPlacePage extends NyStatefulWidget<NewPlaceController> {
  static RouteView path = ("/new-place", (_) => NewPlacePage());

  NewPlacePage({super.key}) : super(child: () => _NewPlacePageState());
}

class _NewPlacePageState extends NyPage<NewPlacePage> {
  static const String pageCode = "P1 ";

  @override
  get init => () async {
        await widget.controller.getPosition();
      };

  @override
  Widget view(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text("New Place"),
          centerTitle: true,
          actions: [Text(pageCode).titleSmall(color: Colors.white)]),
      body: SafeArea(
        minimum: const EdgeInsets.symmetric(horizontal: 25, vertical: 25),
        child: widget.controller.positionReady
            ? SizedBox(
                height: 600,
                child: Card(
                    clipBehavior: Clip.antiAlias,
                    child: Container(
                        padding: const EdgeInsets.all(25),
                        child: Column(
                          children: [
                            SizedBox(
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
                                )),
                            const SizedBox(height: 18),
                            Button.primary(
                                text: "Create New Place",
                                onPressed: () async {
                                  var place =
                                      await widget.controller.createPlace();
                                  if (place != null) {
                                    routeTo(ViewNewPlacePage.path,
                                        navigationType:
                                            NavigationType.pushReplace,
                                        data: place.id);
                                  } else {
                                    showToastOops(
                                        description: "Failed to create place");
                                  }
                                }),
                            const SizedBox(height: 18),
                            Button.secondary(
                                text: "Cancel",
                                onPressed: () {
                                  pop();
                                }),
                          ],
                        ))))
            : Container(),
      ),
    );
  }
}
