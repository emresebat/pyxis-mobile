import 'package:flutter/material.dart';
import 'package:nylo_framework/nylo_framework.dart';

class SignupPage extends NyStatefulWidget {

  static RouteView path = ("/signup", (_) => SignupPage());
  
  SignupPage({super.key}) : super(child: () => _SignupPageState());
}

class _SignupPageState extends NyPage<SignupPage> {

  @override
  get init => () {

  };

  @override
  Widget view(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Signup")
      ),
      body: SafeArea(
         child: Container(),
      ),
    );
  }
}
