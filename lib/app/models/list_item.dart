import 'package:flutter/material.dart';

class ListItem {
  final String title;
  final String? detail;

  /// Widget to be displayed in the list item.
  final Widget? widget;

  /// Route to navigate to when the list item is tapped.
  final String? targetRoute;

  ListItem(this.title, {this.detail, this.targetRoute, this.widget});
}
