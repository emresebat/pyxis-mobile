import 'package:flutter/material.dart';
import 'package:nylo_framework/nylo_framework.dart';

class PlacesTab extends StatefulWidget {
  const PlacesTab({super.key});

  @override
  createState() => _PlacesTabState();
}

class _PlacesTabState extends NyState<PlacesTab> {
  @override
  get init => () {};

  @override
  Widget view(BuildContext context) {
    return Container(
      child: Center(
        child: Text("Places Tab"),
      ),
    );
  }
}
