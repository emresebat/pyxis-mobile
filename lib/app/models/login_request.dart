import 'package:nylo_framework/nylo_framework.dart';

class LoginRequest extends Model {
  static StorageKey key = "login_request";

  final String email, password;

  LoginRequest(this.email, this.password) : super(key: key);

  LoginRequest.fromJson(data)
      : email = data["email"],
        password = data["password"],
        super(key: key);

  @override
  toJson() => {"email": email, "password": password};
}
