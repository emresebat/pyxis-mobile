import 'package:apple_maps_flutter/apple_maps_flutter.dart';
import 'package:flutter/material.dart';
import 'package:nylo_framework/nylo_framework.dart';
import 'package:plateau/app/controllers/places/add_place2_controller.dart';
import 'package:plateau/resources/widgets/buttons/buttons.dart';

class AddPlace2Page extends NyStatefulWidget<AddPlace2Controller> {
  static RouteView path = ("/add-place2", (_) => AddPlace2Page());

  AddPlace2Page({super.key}) : super(child: () => _AddPlacePage2State());
}

class _AddPlacePage2State extends NyPage<AddPlace2Page> {
  @override
  get init => () async {
        await widget.controller.getPosition();
      };

  @override
  Widget view(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(title: Text("Add Place")),
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
                            Text("New Place").titleLarge(),
                            const SizedBox(height: 18),
                            Text(widget.controller.randomName).titleLarge(),
                            const SizedBox(height: 18),
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
                                    routeTo("/places/${place.slug}");
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
