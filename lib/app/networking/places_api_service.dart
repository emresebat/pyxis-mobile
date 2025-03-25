import 'package:flutter/material.dart';
import 'package:plateau/app/models/place.dart';
import 'package:plateau/app/networking/dio/interceptors/supabase_auth_interceptor.dart';
import '/config/decoders.dart';
import 'package:nylo_framework/nylo_framework.dart';

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

  Future<List<Place>?> list() async {
    return await network<List<Place>>(
      request: (request) => request.get("/places"),
    );
  }
}
