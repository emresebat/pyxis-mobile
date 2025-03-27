import 'package:plateau/app/models/login_request.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '/app/controllers/controller.dart';
import 'package:flutter/widgets.dart';

class LoginController extends Controller {
  final supabase = Supabase.instance.client;

  @override
  construct(BuildContext context) {
    super.construct(context);
  }

  Future<({bool success, String error})> onLogin(
      LoginRequest loginRequest) async {
    // login
    try {
      var loginResponse = await supabase.auth.signInWithPassword(
        email: loginRequest.email,
        password: loginRequest.password,
      );
      if (loginResponse.session != null) {
        return (success: true, error: '');
      } else {
        return (success: false, error: 'Login failed');
      }
    } on AuthException catch (e) {
      return (success: false, error: e.message);
    } catch (e) {
      return (success: false, error: e.toString());
    }
  }
}
