import 'package:flutter/material.dart';
import 'package:plateau/app/controllers/profile/login_controller.dart';
import 'package:nylo_framework/nylo_framework.dart';
import 'package:plateau/app/events/login_event.dart';
import 'package:plateau/app/forms/login_form.dart';
import 'package:plateau/app/models/login_request.dart';
import 'package:plateau/bootstrap/extensions.dart';
import 'package:plateau/resources/widgets/buttons/buttons.dart';
import 'package:plateau/resources/widgets/logo_widget.dart';

class LoginPage extends NyStatefulWidget<LoginController> {
  static RouteView path = ("/login", (_) => LoginPage());

  LoginPage({super.key}) : super(child: () => _LoginPageState());
}

class _LoginPageState extends NyPage<LoginPage> {
  LoginForm form = LoginForm();

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
              NyForm(
                  form: form,
                  footer: Column(
                    children: [
                      Button.primary(
                        onPressed: () {
                          form.submit(onSuccess: (data) async {
                            // Do something with the data
                            var loginRequest = LoginRequest.fromJson(data);
                            var result =
                                await widget.controller.onLogin(loginRequest);
                            if (result.success) {
                              // redirect to home
                              event<LoginEvent>();
                            } else {
                              showToastOops(description: result.error);
                            }
                          });
                        },
                        text: "Login",
                      ),
                      const SizedBox(height: 18),
                      Button.secondary(
                        onPressed: () {
                          pop();
                        },
                        text: "Back",
                      )
                    ],
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
