import 'package:nylo_framework/nylo_framework.dart';
import 'package:plateau/app/models/profile_summary.dart';
import 'package:plateau/app/networking/profile_api_service.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '/app/controllers/controller.dart';
import 'package:flutter/widgets.dart';

class ProfileController extends Controller {
  final SupabaseClient supabase = Supabase.instance.client;

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
      await supabase.auth.signOut();
      return (success: true, error: '');
    } on AuthException catch (error) {
      return (success: false, error: error.message);
    } catch (error) {
      return (success: false, error: error.toString());
    }
  }

  Future<ProfileSummary?> getProfileSummary() async {
    return await api<ProfileApiService>((request) => request.summary());
  }
}
