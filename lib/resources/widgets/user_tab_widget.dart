import 'package:flutter/material.dart';
import 'package:hyperplace/app/models/profile.dart';
import 'package:hyperplace/app/models/profile_section.dart';
import 'package:hyperplace/resources/widgets/avatar_widget.dart';
import 'package:hyperplace/resources/widgets/profile_tab_widget.dart';
import 'package:nylo_framework/nylo_framework.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class UserTab extends StatefulWidget {
  const UserTab({super.key});

  @override
  createState() => _UserTabState();
}

class _UserTabState extends NyState<UserTab> {
  final supabase = Supabase.instance.client;
  Profile? _profile;
  var _loading = true;

  @override
  get init => () {
        _getProfile();
      };

  Future<void> _getProfile() async {
    setState(() {
      _loading = true;
    });
    try {
      final userId = supabase.auth.currentSession!.user.id;
      final data =
          await supabase.from('profiles').select().eq('id', userId).single();
      _profile = Profile.fromJson(data);
    } on PostgrestException catch (error) {
      if (mounted) showToastOops(description: error.message);
    } catch (error) {
      if (mounted) {
        showToastOops(description: 'Unexpected error occurred');
      }
    } finally {
      if (mounted) {
        setState(() {
          _loading = false;
        });
      }
    }
  }

  @override
  Widget view(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('${_profile?.username} \'s Profile')),
      body: _loading
          ? CircularProgressIndicator()
          : Container(
              padding: const EdgeInsets.all(20),
              child: NyListView.separated(
                child: (BuildContext context, dynamic data) {
                  var profileSection = (data as ProfileSection);
                  if (profileSection.title == 'Profile') {
                    return ListTile(
                      leading: CircleAvatar(
                        radius: 20,
                        backgroundColor: Colors.grey,
                        child: _profile?.hasAvatar() == false
                            ? Text(_profile?.initials ?? '')
                            : null,
                        backgroundImage: _profile?.hasAvatar() == false
                            ? null
                            : NetworkImage(_profile!.avatarUrl!),
                      ),
                      title: Text(_profile?.fullName ?? ''),
                      trailing: Icon(Icons.edit),
                      onTap: () => pushTo(ProfileTab()),
                    );
                  }
                  return ListTile(
                      title: Text(profileSection.title),
                      trailing: Text(profileSection.detail));
                },
                data: () async {
                  return [
                    ProfileSection('Profile', 'Edit'),
                    ProfileSection('Places', '0 Places'),
                    ProfileSection('Wallet', 'None'),
                    ProfileSection('History', 'Latest Activity'),
                    ProfileSection('Visibility', 'Private'),
                  ];
                },
                separatorBuilder: (BuildContext context, int index) {
                  return Divider();
                },
              )),
    );
  }
}
