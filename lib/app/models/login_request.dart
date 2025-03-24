import 'package:nylo_framework/nylo_framework.dart';

class LoginRequest extends Model {
  static StorageKey key = "login_request";

  String? email, password;

  LoginRequest() : super(key: key);

  LoginRequest.fromJson(data) : super(key: key) {
    email = data['email'];
    password = data['password'];
  }

  @override
  toJson() => {"email": email, "password": password};
}
