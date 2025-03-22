import 'package:flutter/material.dart';
import 'package:nylo_framework/nylo_framework.dart';

class NearmeTab extends StatefulWidget {
  const NearmeTab({super.key});

  @override
  createState() => _NearmeTabState();
}

class _NearmeTabState extends NyState<NearmeTab> {
  @override
  get init => () {};

  @override
  Widget view(BuildContext context) {
    return Container(
      child: Center(
        child: Text("Nearme Tab"),
      ),
    );
  }
}
