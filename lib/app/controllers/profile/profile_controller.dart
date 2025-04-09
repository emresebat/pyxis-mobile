import 'package:plateau/app/controllers/controller.dart';
import 'package:plateau/app/models/profile.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter/widgets.dart';

class ProfileController extends Controller {
  @override
  construct(BuildContext context) {
    super.construct(context);
  }

  // Future<({Profile? profile, String error})> getProfile() async {
  //   try {
  //     final userId = supabase.auth.currentSession!.user.id;
  //     final data =
  //         await supabase.from('profiles').select().eq('id', userId).single();
  //     return (profile: Profile.fromJson(data), error: '');
  //   } on PostgrestException catch (error) {
  //     return (profile: null, error: error.message);
  //   } catch (error) {
  //     return (profile: null, error: error.toString());
  //   }
  // }

  Future<({bool success, String error})> signOut() async {
    try {
      final supabase = Supabase.instance.client;

      await supabase.auth.signOut();
      return (success: true, error: '');
    } on AuthException catch (error) {
      return (success: false, error: error.message);
    } catch (error) {
      return (success: false, error: error.toString());
    }
  }

  Future<Profile?> getProfile() async {
    final supabase = Supabase.instance.client;
    final userId = supabase.auth.currentUser!.id;
    final data = await supabase
        .from('profiles_summary')
        .select()
        .eq('id', userId)
        .single();
    return Profile.fromJson(data);
  }
}
