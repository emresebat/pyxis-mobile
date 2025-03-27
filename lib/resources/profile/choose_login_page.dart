import 'package:flutter/material.dart';
import 'package:nylo_framework/nylo_framework.dart';
import 'package:plateau/resources/profile/link_login_page.dart';
import 'package:plateau/resources/profile/login_page.dart';
import 'package:plateau/resources/widgets/buttons/buttons.dart';
import 'package:plateau/resources/widgets/logo_widget.dart';
import '/bootstrap/extensions.dart';

class ChooseLoginPage extends NyStatefulWidget {
  static RouteView path = ("/choose-login", (_) => ChooseLoginPage());

  ChooseLoginPage({super.key}) : super(child: () => _ChooseLoginPageState());
}

class _ChooseLoginPageState extends NyPage<ChooseLoginPage> {
  @override
  get init => () {};

  @override
  Widget view(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: context.color.surfaceBackground,
        title: Logo(height: 80),
      ),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Button.icon(
                onPressed: () {
                  routeTo(LoginPage.path);
                },
                icon: Icon(Icons.email),
                text: "Login with Email",
              ),
              const SizedBox(height: 18),
              Button.icon(
                onPressed: () {
                  routeTo(LinkLoginPage.path);
                },
                icon: Icon(Icons.link),
                text: "Login with magic link",
              ),
              const SizedBox(height: 18),
              Button.icon(
                onPressed: () {},
                icon: Icon(Icons.wallet_membership),
                text: "Connect wallet",
              ),
              const SizedBox(height: 18),
              Button.icon(
                onPressed: () {
                  routeTo(LinkLoginPage.path);
                },
                color: context.color.primaryAccent,
                icon: Icon(Icons.person_add),
                text: "Register",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
