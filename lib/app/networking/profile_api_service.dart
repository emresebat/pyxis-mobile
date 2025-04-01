import 'package:flutter/material.dart';
import 'package:plateau/app/models/profile_summary.dart';
import 'package:plateau/app/networking/dio/interceptors/supabase_auth_interceptor.dart';
import '/config/decoders.dart';
import 'package:nylo_framework/nylo_framework.dart';

class ProfileApiService extends NyApiService {
  ProfileApiService({BuildContext? buildContext})
      : super(buildContext, decoders: modelDecoders);

  @override
  String get baseUrl => getEnv('API_BASE_URL');

  @override
  Map<Type, Interceptor> get interceptors => {
        // Add more interceptors for the API Service
        SupabaseAuthInterceptor: SupabaseAuthInterceptor(),
      };

  Future<ProfileSummary?> summary() async {
    return await network<ProfileSummary>(
      request: (request) => request.get("/profile/summary"),
    );
  }
}
