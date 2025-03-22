import 'package:flutter/material.dart';
import 'package:hyperplace/app/events/logout_event.dart';
import 'package:hyperplace/resources/widgets/buttons/buttons.dart';
import 'package:nylo_framework/nylo_framework.dart';

class ProfileTab extends StatefulWidget {
  const ProfileTab({super.key});

  @override
  createState() => _ProfileTabState();
}

class _ProfileTabState extends NyState<ProfileTab> {
  @override
  get init => () {};

  @override
  Widget view(BuildContext context) {
    return Container(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Profile Tab',
              style: TextStyle(fontSize: 20),
            ),
            Button.secondary(
                text: "Logout", onPressed: () => event<LogoutEvent>()),
          ],
        ),
      ),
    );
  }
}
