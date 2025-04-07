import 'package:flutter/material.dart';
import 'package:plateau/app/controllers/profile/edit_profile_controller.dart';
import 'package:plateau/app/events/logout_event.dart';
import 'package:plateau/app/models/profile.dart';
import 'package:plateau/resources/widgets/buttons/buttons.dart';
import 'package:plateau/resources/widgets/editable_avatar_widget.dart';
import 'package:nylo_framework/nylo_framework.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class EditProfilePage extends NyStatefulWidget<EditProfileController> {
  static RouteView path = ("/edit-profile", (_) => EditProfilePage());

  EditProfilePage({super.key}) : super(child: () => _EditProfilePageState());
}

class _EditProfilePageState extends NyState<EditProfilePage> {
  static const String pageCode = "U6 ";
  final _usernameController = TextEditingController();
  final _fullNameController = TextEditingController();
  String? _avatarUrl;
  var _loading = true;
  Profile? _profile;

  final supabase = Supabase.instance.client;

  @override
  get init => () {
        _getProfile();
      };

  /// Called once a user id is received within `onAuthenticated()`
  Future<void> _getProfile() async {
    setState(() {
      _loading = true;
    });
    try {
      final userId = supabase.auth.currentSession!.user.id;
      final data =
          await supabase.from('profiles').select().eq('id', userId).single();
      _profile = Profile.fromJson(data);
      _usernameController.text = _profile?.username ?? '';
      _fullNameController.text = _profile?.fullName ?? '';
      _avatarUrl = _profile?.avatarUrl;
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

  /// Called when user taps `Update` button
  Future<void> _updateProfile() async {
    setState(() {
      _loading = true;
    });
    final userName = _usernameController.text.trim();
    final fullName = _fullNameController.text.trim();
    final user = supabase.auth.currentUser;
    final updates = {
      'id': user!.id,
      'username': userName,
      'full_name': fullName,
      'updated_at': DateTime.now().toIso8601String(),
    };
    try {
      await supabase.from('profiles').upsert(updates);
      if (mounted)
        showToastSuccess(description: 'Successfully updated profile!');
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

  Future<void> _signOut() async {
    try {
      await supabase.auth.signOut();
    } on AuthException catch (error) {
      if (mounted) showToastOops(description: error.message);
    } catch (error) {
      if (mounted) {
        showToastOops(description: 'Unexpected error occurred');
      }
    } finally {
      event<LogoutEvent>();
    }
  }

  /// Called when image has been uploaded to Supabase storage from within Avatar widget
  Future<void> _onUpload(String imageUrl) async {
    try {
      final userId = supabase.auth.currentUser!.id;
      await supabase.from('profiles').upsert({
        'id': userId,
        'avatar_url': imageUrl,
      });
      if (mounted) {
        const SnackBar(
          content: Text('Updated your profile image!'),
        );
      }
    } on PostgrestException catch (error) {
      if (mounted) showToastOops(description: error.message);
    } catch (error) {
      if (mounted) {
        showToastOops(description: 'Unexpected error occurred');
      }
    }
    if (!mounted) {
      return;
    }
    setState(() {
      _avatarUrl = imageUrl;
    });
  }

  @override
  Widget view(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Edit Profile'),
        actions: [
          Text(pageCode).titleSmall(color: Colors.white),
        ],
      ),
      body: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              EditableAvatar(
                imageUrl: _avatarUrl,
                onUpload: _onUpload,
                initials: _profile?.getInitials() ?? '',
              ),
              const SizedBox(height: 18),
              TextFormField(
                controller: _usernameController,
                decoration: const InputDecoration(labelText: 'User Name'),
              ),
              const SizedBox(height: 18),
              TextFormField(
                controller: _fullNameController,
                decoration: const InputDecoration(labelText: 'Full Name'),
              ),
              const SizedBox(height: 18),
              Button.primary(
                onPressed: _loading ? null : _updateProfile,
                text: _loading ? 'Saving...' : 'Update',
              ),
              const SizedBox(height: 18),
              Button.secondary(onPressed: _signOut, text: 'Sign Out'),
            ],
          )),
    );
  }
}
