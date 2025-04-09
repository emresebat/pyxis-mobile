import 'package:nylo_framework/nylo_framework.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseProvider implements NyProvider {
  @override
  boot(Nylo nylo) async {
    return null;
  }

  @override
  afterBoot(Nylo nylo) async {
    await Supabase.initialize(
        url: getEnv('SUPABASE_URL'),
        anonKey: getEnv('SUPABASE_ANONKEY'),
        debug: getEnv('APP_DEBUG'));

    final Supabase supabase = Supabase.instance;

    supabase.client.auth.onAuthStateChange.listen((data) async {
      final AuthChangeEvent event = data.event;
      final Session? session = data.session;

      if (event == AuthChangeEvent.signedIn) {
        await Auth.authenticate(data: {"session": session?.accessToken});
        routeToAuthenticatedRoute();
        return;
      }
    });
  }
}
