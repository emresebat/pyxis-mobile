import 'package:flutter/material.dart';
import 'package:plateau/app/models/chat.dart';
import 'package:plateau/app/networking/dio/interceptors/supabase_auth_interceptor.dart';
import '/config/decoders.dart';
import 'package:nylo_framework/nylo_framework.dart';

class ChatsApiService extends NyApiService {
  ChatsApiService({BuildContext? buildContext})
      : super(buildContext, decoders: modelDecoders);

  @override
  String get baseUrl => getEnv('API_BASE_URL');

  @override
  Map<Type, Interceptor> get interceptors => {
        // Add more interceptors for the API Service
        SupabaseAuthInterceptor: SupabaseAuthInterceptor(),
      };

  Future<List<Chat>?> getChats() async {
    return await network<List<Chat>>(
      request: (request) => request.get("/chats"),
    );
  }

  Future<Chat?> getById(String id) async {
    return await network<Chat>(
      request: (request) => request.get("/chats/${id}"),
    );
  }
}
