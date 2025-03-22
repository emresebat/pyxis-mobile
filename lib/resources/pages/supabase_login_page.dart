import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hyperplace/app/events/login_event.dart';
import 'package:nylo_framework/nylo_framework.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseLoginPage extends NyStatefulWidget {
  static RouteView path = ("/login", (_) => SupabaseLoginPage());

  SupabaseLoginPage({super.key})
      : super(child: () => _SupabaseLoginPageState());
}

class _SupabaseLoginPageState extends NyPage<SupabaseLoginPage> {
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
      // appBar: AppBar(title: const Text('Sign In')),
      body: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                "public/images/logo.png",
                height: 100,
              ),
              const SizedBox(height: 20),
              const Text(
                'Sign in via the magic link with your email below',
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 18),
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(labelText: 'Email'),
              ),
              const SizedBox(height: 18),
              ElevatedButton(
                onPressed: _isLoading ? null : _signIn,
                child: Text(_isLoading ? 'Sending...' : 'Send Magic Link'),
              ),
            ],
          )),
    );
  }
}
