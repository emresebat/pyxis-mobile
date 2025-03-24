import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:plateau/app/events/login_event.dart';
import 'package:nylo_framework/nylo_framework.dart';
import 'package:plateau/bootstrap/extensions.dart';
import 'package:plateau/resources/pages/choose_login_page.dart';
import 'package:plateau/resources/widgets/buttons/buttons.dart';
import 'package:plateau/resources/widgets/logo_widget.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class LinkLoginPage extends NyStatefulWidget {
  static RouteView path = ("/link-login", (_) => LinkLoginPage());

  LinkLoginPage({super.key}) : super(child: () => _LinkLoginPageState());
}

class _LinkLoginPageState extends NyPage<LinkLoginPage> {
  bool _isLoading = false;
  bool _redirecting = false;
  late final TextEditingController _emailController = TextEditingController();
  late final StreamSubscription<AuthState> _authStateSubscription;

  final supabase = Supabase.instance.client;

  @override
  get init => () {
        _authStateSubscription = supabase.auth.onAuthStateChange.listen(
          (data) {
            if (_redirecting) return;
            final session = data.session;
            if (session != null) {
              _redirecting = true;
              event<LoginEvent>();
            }
          },
          onError: (error) {
            if (error is AuthException) {
              showToastOops(description: error.message);
            } else {
              showToastOops(description: 'Unexpected error occurred');
            }
          },
        );
      };

  Future<void> _signIn() async {
    try {
      setState(() {
        _isLoading = true;
      });
      await supabase.auth.signInWithOtp(
        email: _emailController.text.trim(),
        emailRedirectTo:
            kIsWeb ? null : 'io.supabase.flutterquickstart://login-callback/',
      );
      if (mounted) {
        showToastInfo(description: 'Check your email for a login link!');
        _emailController.clear();
      }
    } on AuthException catch (error) {
      if (mounted) showToastOops(description: error.message);
    } catch (error) {
      if (mounted) {
        showToastOops(description: 'Unexpected error occurred');
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _authStateSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: context.color.surfaceBackground,
        title: Logo(height: 80),
      ),
      body: Container(
          padding: const EdgeInsets.all(18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // const Text(
              //   'Sign in via the magic link with your email below',
              //   textAlign: TextAlign.center,
              // ),
              // const SizedBox(height: 18),
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(labelText: 'Email'),
              ),
              const SizedBox(height: 18),
              Button.primary(
                onPressed: _isLoading ? null : _signIn,
                text: _isLoading ? 'Sending...' : 'Send Magic Link',
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
    );
  }
}
