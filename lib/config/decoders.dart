import '/app/models/login_request.dart';
import '/app/controllers/login_controller.dart';
import '/app/models/profile_section.dart';
import '/app/controllers/home_controller.dart';
import '../app/models/profile.dart';
import '/app/networking/api_service.dart';

/* Model Decoders
|--------------------------------------------------------------------------
| Model decoders are used in 'app/networking/' for morphing json payloads
| into Models.
|
| Learn more https://nylo.dev/docs/6.x/decoders#model-decoders
|-------------------------------------------------------------------------- */

final Map<Type, dynamic> modelDecoders = {
  Map<String, dynamic>: (data) => Map<String, dynamic>.from(data),

  List<Profile>: (data) =>
      List.from(data).map((json) => Profile.fromJson(json)).toList(),
  //
  Profile: (data) => Profile.fromJson(data),

  List<LoginRequest>: (data) => List.from(data).map((json) => LoginRequest.fromJson(json)).toList(),

  LoginRequest: (data) => LoginRequest.fromJson(data),
};

/* API Decoders
| -------------------------------------------------------------------------
| API decoders are used when you need to access an API service using the
| 'api' helper. E.g. api<MyApiService>((request) => request.fetchData());
|
| Learn more https://nylo.dev/docs/6.x/decoders#api-decoders
|-------------------------------------------------------------------------- */

final Map<Type, dynamic> apiDecoders = {
  ApiService: () => ApiService(),

  // ...
};

/* Controller Decoders
| -------------------------------------------------------------------------
| Controller are used in pages.
|
| Learn more https://nylo.dev/docs/6.x/controllers
|-------------------------------------------------------------------------- */
final Map<Type, dynamic> controllers = {
  HomeController: () => HomeController(),

  // ...

  LoginController: () => LoginController(),
};
