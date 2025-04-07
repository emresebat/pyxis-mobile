import 'package:apple_maps_flutter/apple_maps_flutter.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:nylo_framework/nylo_framework.dart';
import 'package:plateau/bootstrap/app.dart';

class NearmePage extends NyStatefulWidget {
  static RouteView path = ("/nearme", (_) => NearmePage());

  NearmePage({super.key}) : super(child: () => _NearmePageState());
}

class _NearmePageState extends NyState<NearmePage> {
  static const String pageCode = "N1 ";

  LatLng? _currentLocation;
  bool _isLoading = true;

  late AppleMapController? mapController;
  Map<AnnotationId, Annotation> annotations = <AnnotationId, Annotation>{};

  void _onMapCreated(AppleMapController controller) {
    mapController = controller;
  }

  @override
  get init => () {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          _fetchUserLocation();
        });
      };

  Future<void> _fetchUserLocation() async {
    // Check if location services are enabled
    if (!Main.positionServiceReady) {
      // Handle location services not enabled
      setState(() => _isLoading = false);
      return;
    }

    // Get the current position
    Position position = await Geolocator.getCurrentPosition();
    setState(() {
      _currentLocation = LatLng(position.latitude, position.longitude);
      annotations[AnnotationId('current_location')] = Annotation(
        annotationId: AnnotationId('current_location'),
        position: _currentLocation!,
        infoWindow: const InfoWindow(title: 'You are here'),
      );
      _isLoading = false;
    });
  }

  @override
  Widget view(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('Near Me'),
          centerTitle: true,
          actions: [Text(pageCode).titleSmall(color: Colors.white)]),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : AppleMap(
              onMapCreated: _onMapCreated,
              initialCameraPosition: CameraPosition(
                target: _currentLocation!,
                zoom: 15.0,
              ),
              annotations: Set<Annotation>.of(annotations.values),
            ),
    );
  }
}
