import 'package:apple_maps_flutter/apple_maps_flutter.dart';
import 'package:flutter/material.dart';
import 'package:nylo_framework/nylo_framework.dart';
import 'package:plateau/app/controllers/places/add_place_controller.dart';
import 'package:plateau/resources/widgets/buttons/buttons.dart';

class AddPlacePage extends NyStatefulWidget<AddPlaceController> {
  static RouteView path = ("/add-place", (_) => AddPlacePage());

  AddPlacePage({super.key}) : super(child: () => _AddPlacePageState());
}

class _AddPlacePageState extends NyPage<AddPlacePage> {
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
            ? Card(
                clipBehavior: Clip.antiAlias,
                child: Column(
                  children: [
                    Text("New Place").titleLarge(),
                    const SizedBox(height: 18),
                    SizedBox(
                        height: 250,
                        child: AppleMap(
                          onMapCreated: widget.controller.onMapCreated,
                          initialCameraPosition: CameraPosition(
                            target: widget.controller.currentCoords,
                            zoom: 15.0,
                          ),
                          annotations: Set<Annotation>.of(
                              [widget.controller.currentLocationAnnotation]),
                        )),
                    const SizedBox(height: 18),
                    Button.primary(text: "Create New Place", onPressed: () {}),
                    const SizedBox(height: 18),
                    Button.secondary(
                        text: "Cancel",
                        onPressed: () {
                          pop();
                        }),
                  ],
                ))
            : Container(),
      ),
    );
  }
}
