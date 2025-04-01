import 'package:plateau/app/networking/profile_api_service.dart';

import '/app/models/profile_summary.dart';
import '../app/models/create_place_request.dart';
import 'package:plateau/app/controllers/places/add_place2_controller.dart';

import '../app/controllers/places/add_place_controller.dart';
import '../app/controllers/profile/profile_controller.dart';
import '/app/models/place.dart';
import '../app/controllers/places/places_controller.dart';
import '/app/networking/places_api_service.dart';
import '/app/models/login_request.dart';
import '../app/controllers/profile/login_controller.dart';
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

  List<LoginRequest>: (data) =>
      List.from(data).map((json) => LoginRequest.fromJson(json)).toList(),

  LoginRequest: (data) => LoginRequest.fromJson(data),

  List<Place>: (data) =>
      List.from(data).map((json) => Place.fromJson(json)).toList(),

  Place: (data) => Place.fromJson(data),

  List<CreatePlaceRequest>: (data) =>
      List.from(data).map((json) => CreatePlaceRequest.fromJson(json)).toList(),

  CreatePlaceRequest: (data) => CreatePlaceRequest.fromJson(data),

  List<ProfileSummary>: (data) =>
      List.from(data).map((json) => ProfileSummary.fromJson(json)).toList(),

  ProfileSummary: (data) => ProfileSummary.fromJson(data),
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

  PlacesApiService: PlacesApiService(),
  ProfileApiService: ProfileApiService(),
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
  PlacesController: () => PlacesController(),
  ProfileController: () => ProfileController(),
  AddPlaceController: () => AddPlaceController(),
  AddPlace2Controller: () => AddPlace2Controller(),
};
