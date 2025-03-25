import 'package:flutter/material.dart';
import 'package:plateau/resources/widgets/chat_tab_widget.dart';
import 'package:plateau/resources/widgets/nearme_tab_widget.dart';
import 'package:plateau/resources/widgets/places_tab_widget.dart';
import 'package:plateau/resources/widgets/user_tab_widget.dart';
import 'package:nylo_framework/nylo_framework.dart';

class BaseNavigationHub extends NyStatefulWidget with BottomNavPageControls {
  static RouteView path = ("/base", (_) => BaseNavigationHub());

  BaseNavigationHub()
      : super(
            child: () => _BaseNavigationHubState(),
            stateName: path.stateName());

  /// State actions
  static NavigationHubStateActions stateActions =
      NavigationHubStateActions(path.stateName());
}

class _BaseNavigationHubState extends NavigationHub<BaseNavigationHub> {
  /// Layouts:
  /// - [NavigationHubLayout.bottomNav] Bottom navigation
  /// - [NavigationHubLayout.topNav] Top navigation
  NavigationHubLayout? layout = NavigationHubLayout.bottomNav(
      // backgroundColor: Colors.white,
      );

  /// Should the state be maintained
  @override
  bool get maintainState => false;

  /// Navigation pages
  _BaseNavigationHubState()
      : super(() async {
          return {
            0: NavigationTab(
              title: "Profile",
              page:
                  UserTab(), // create using: 'dart run nylo_framework:main make:stateful_widget home_tab'
              icon: Icon(Icons.person_outline),
              activeIcon: Icon(Icons.person),
            ),
            1: NavigationTab(
              title: "Places",
              page:
                  PlacesTab(), // create using: 'dart run nylo_framework:main make:stateful_widget settings_tab'
              icon: Icon(Icons.pin_drop_outlined),
              activeIcon: Icon(Icons.pin_drop),
            ),
            2: NavigationTab(
              title: "NearMe",
              page:
                  NearmeTab(), // create using: 'dart run nylo_framework:main make:stateful_widget settings_tab'
              icon: Icon(Icons.near_me_outlined),
              activeIcon: Icon(Icons.near_me),
            ),
            3: NavigationTab(
              title: "Chat",
              page:
                  ChatTab(), // create using: 'dart run nylo_framework:main make:stateful_widget settings_tab'
              icon: Icon(Icons.chat_outlined),
              activeIcon: Icon(Icons.chat),
            ),
          };
        });

  /// Handle the tap event
  @override
  onTap(int index) {
    super.onTap(index);
  }
}
