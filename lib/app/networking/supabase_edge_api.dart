import 'package:flutter/material.dart';
import 'package:plateau/app/models/create_place_request.dart';
import 'package:plateau/app/models/place.dart';
import 'package:plateau/app/networking/dio/interceptors/supabase_auth_interceptor.dart';
import 'package:nylo_framework/nylo_framework.dart';
import 'package:plateau/config/decoders.dart';

class SupabaseEdgeApiService extends NyApiService {
  SupabaseEdgeApiService({BuildContext? buildContext})
      : super(buildContext, decoders: modelDecoders);

  @override
  String get baseUrl => getEnv('SUPABASE_EDGE_URL');

  @override
  Map<Type, Interceptor> get interceptors => {
        // Add more interceptors for the API Service
        SupabaseAuthInterceptor: SupabaseAuthInterceptor(),
      };

  Future<Place?> createPlace(CreatePlaceRequest payload) async {
    return await network<Place>(
      request: (request) =>
          request.post("/create-new-place", data: payload.toJson()),
    );
  }
}
