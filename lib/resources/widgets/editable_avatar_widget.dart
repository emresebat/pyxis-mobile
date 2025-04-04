import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nylo_framework/nylo_framework.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class EditableAvatar extends StatefulWidget {
  const EditableAvatar(
      {super.key, this.initials, this.imageUrl, required this.onUpload});

  final String? imageUrl;
  final String? initials;
  final void Function(String) onUpload;

  @override
  createState() => _EditableAvatarState();
}

class _EditableAvatarState extends NyState<EditableAvatar> {
  bool _isLoading = false;
  final supabase = Supabase.instance.client;

  @override
  get init => () {};

  Future<void> _upload() async {
    final picker = ImagePicker();
    final imageFile = await picker.pickImage(
      source: ImageSource.gallery,
      maxWidth: 300,
      maxHeight: 300,
    );
    if (imageFile == null) {
      return;
    }
    setState(() => _isLoading = true);
    try {
      final bytes = await imageFile.readAsBytes();
      final fileExt = imageFile.path.split('.').last;
      final fileName = '${DateTime.now().toIso8601String()}.$fileExt';
      final filePath = fileName;
      await supabase.storage.from('avatars').uploadBinary(
            filePath,
            bytes,
            fileOptions: FileOptions(contentType: imageFile.mimeType),
          );
      final imageUrlResponse = await supabase.storage
          .from('avatars')
          .createSignedUrl(filePath, 60 * 60 * 24 * 365 * 10);
      widget.onUpload(imageUrlResponse);
    } on StorageException catch (error) {
      if (mounted) {
        showToastOops(description: error.message);
      }
    } catch (error) {
      if (mounted) {
        showToastOops(description: 'Unexpected error occurred');
      }
    }
    setState(() => _isLoading = false);
  }

  @override
  Widget view(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 50,
          backgroundColor: Colors.grey,
          child: widget.imageUrl == null || widget.imageUrl!.isEmpty
              ? Text(widget.initials ?? '')
              : null,
          backgroundImage: widget.imageUrl == null || widget.imageUrl!.isEmpty
              ? null
              : NetworkImage(widget.imageUrl!),
        ),
        // if (widget.imageUrl == null || widget.imageUrl!.isEmpty)
        //   Container(
        //     width: 150,
        //     height: 150,
        //     color: Colors.grey,
        //     child: const Center(
        //       child: Text('No Image'),
        //     ),
        //   )
        // else
        //   Image.network(
        //     widget.imageUrl!,
        //     width: 150,
        //     height: 150,
        //     fit: BoxFit.cover,
        //   ),
        ElevatedButton(
          onPressed: _isLoading ? null : _upload,
          child: const Text('Upload'),
        ),
      ],
    );
  }
}
