import 'package:nylo_framework/nylo_framework.dart';
import 'package:plateau/app/models/place.dart';
import 'package:plateau/app/networking/places_api_service.dart';

import '/app/controllers/controller.dart';
import 'package:flutter/widgets.dart';

class PlacesController extends Controller {
  @override
  construct(BuildContext context) {
    super.construct(context);
  }

  Future<List<Place>?> list() async {
    return await api<PlacesApiService>((request) => request.list());
  }
}
