import 'package:supabase_flutter/supabase_flutter.dart';

import 'package:nylo_framework/nylo_framework.dart';

class SupabaseAuthInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final supabase = Supabase.instance.client;

    String? bearerToken = supabase.auth.currentSession?.accessToken;
    String? refreshToken = supabase.auth.currentSession?.refreshToken;

    options.headers.addAll({
      "Authorization": "Bearer ${bearerToken}",
      "Refresh-Token": refreshToken
    });
    return super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    handler.next(err);
  }
}
