import 'package:flutter/material.dart';
import 'package:flutter_app/app/events/login_event.dart';
import 'package:nylo_framework/nylo_framework.dart';

class LoginPage extends NyStatefulWidget {
  static RouteView path = ("/login", (_) => LoginPage());

  LoginPage({super.key}) : super(child: () => _LoginPageState());
}

class _LoginPageState extends NyPage<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  get init => () {};

  @override
  Widget view(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login"),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              NyTextField.emailAddress(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: "Email",
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.emailAddress,
              ),
              SizedBox(height: 16),
              NyTextField.password(
                controller: _passwordController,
                decoration: InputDecoration(
                  labelText: "Password",
                  border: OutlineInputBorder(),
                ),
                obscureText: true,
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  // Handle login logic here
                  final email = _emailController.text;
                  final password = _passwordController.text;
                  print("Email: $email, Password: $password");

                  validate(
                      rules: {
                        "email": [
                          email,
                          FormValidator.email(message: "Invalid email address")
                              .rules
                        ],
                        "password": [
                          password,
                          FormValidator.password(
                                  strength: 1,
                                  message:
                                      "Password must be at least 8 characters")
                              .rules
                        ],
                      },
                      onSuccess: () => event<LoginEvent>(data: {
                            "email": email,
                            "password": password,
                          }));
                },
                child: Text("Login"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
