import 'package:plateau/app/controllers/controller.dart';
import 'package:plateau/app/models/place.dart';
import 'package:flutter/widgets.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class PlacesController extends Controller {
  @override
  construct(BuildContext context) {
    super.construct(context);
  }

  Future<List<Place>?> list() async {
    final supabase = Supabase.instance.client;
    final userId = supabase.auth.currentUser!.id;
    return await supabase
        .from('places')
        .select()
        .eq('profile_id', userId)
        .order('created_at', ascending: false)
        .then(
            (data) => data.map<Place>((json) => Place.fromJson(json)).toList());
  }
}
