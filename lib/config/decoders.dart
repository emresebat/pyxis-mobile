import 'package:plateau/app/networking/chats_api_service.dart';

import '/app/models/message.dart';
import '/app/models/chat.dart';
import '/app/controllers/chats_controller.dart';
import '../app/controllers/places/edit_new_place_controller.dart';
import '../app/controllers/profile/edit_profile_controller.dart';
import '../app/controllers/places/own_place_visits_controller.dart';
import 'package:plateau/app/controllers/home_controller.dart';
import 'package:plateau/app/controllers/places/places_controller.dart';
import 'package:plateau/app/controllers/places/profile_places_controller.dart';
import 'package:plateau/app/controllers/places/view_new_place_controller.dart';
import 'package:plateau/app/controllers/places/view_own_place_controller.dart';
import 'package:plateau/app/controllers/profile/login_controller.dart';
import 'package:plateau/app/controllers/profile/profile_controller.dart';
import 'package:plateau/app/models/create_place_request.dart';
import 'package:plateau/app/models/login_request.dart';
import 'package:plateau/app/models/place.dart';
import 'package:plateau/app/models/profile.dart';
import 'package:plateau/app/models/profile_summary.dart';
import 'package:plateau/app/networking/api_service.dart';
import 'package:plateau/app/networking/places_api_service.dart';
import 'package:plateau/app/networking/profile_api_service.dart';

import 'package:plateau/app/controllers/places/new_place_controller.dart';

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

  List<Chat>: (data) =>
      List.from(data).map((json) => Chat.fromJson(json)).toList(),

  Chat: (data) => Chat.fromJson(data),

  List<Message>: (data) =>
      List.from(data).map((json) => Message.fromJson(json)).toList(),

  Message: (data) => Message.fromJson(data),
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
  ChatsApiService: ChatsApiService(),
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
  ProfilePlacesController: () => ProfilePlacesController(),
  NewPlaceController: () => NewPlaceController(),
  ViewNewPlaceController: () => ViewNewPlaceController(),
  ViewOwnPlaceController: () => ViewOwnPlaceController(),
  OwnPlaceVisitsController: () => OwnPlaceVisitsController(),
  EditProfileController: () => EditProfileController(),
  EditNewPlaceController: () => EditNewPlaceController(),

  ChatsController: () => ChatsController(),
};
