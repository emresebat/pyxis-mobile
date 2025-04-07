import 'package:flutter/material.dart';
import 'package:plateau/app/models/create_place_request.dart';
import 'package:plateau/app/models/place.dart';
import 'package:plateau/app/networking/dio/interceptors/supabase_auth_interceptor.dart';
import 'package:nylo_framework/nylo_framework.dart';
import 'package:plateau/config/decoders.dart';

class PlacesApiService extends NyApiService {
  PlacesApiService({BuildContext? buildContext})
      : super(buildContext, decoders: modelDecoders);

  @override
  String get baseUrl => getEnv('API_BASE_URL');

  @override
  Map<Type, Interceptor> get interceptors => {
        // Add more interceptors for the API Service
        SupabaseAuthInterceptor: SupabaseAuthInterceptor(),
      };

  Future<List<Place>?> getPlaces() async {
    return await network<List<Place>>(
      request: (request) => request.get("/places"),
    );
  }

  Future<Place?> create(CreatePlaceRequest data) async {
    return await network<Place>(
      request: (request) => request.post("/places", data: data.toJson()),
    );
  }

  Future<List<Place>?> getMyPlaces() async {
    return await network<List<Place>>(
      request: (request) => request.get("/places/my"),
    );
  }

  Future<Place?> getById(String id) async {
    return await network<Place>(
      request: (request) => request.get("/places/${id}"),
    );
  }
}
