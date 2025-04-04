import 'package:flutter/material.dart';
import 'package:nylo_framework/nylo_framework.dart';

class Avatar extends StatefulWidget {
  const Avatar({super.key, this.initials, this.imageUrl, this.radius = 50});

  final String? imageUrl;
  final String? initials;
  final double? radius;

  @override
  createState() => _AvatarState();
}

class _AvatarState extends NyState<Avatar> {
  @override
  get init => () {};

  @override
  Widget view(BuildContext context) {
    return CircleAvatar(
      radius: widget.radius,
      backgroundColor: Colors.grey,
      child: widget.imageUrl == null || widget.imageUrl!.isEmpty
          ? Text(widget.initials ?? '')
          : null,
      backgroundImage: widget.imageUrl == null || widget.imageUrl!.isEmpty
          ? null
          : NetworkImage(widget.imageUrl!),
    );
  }
}
