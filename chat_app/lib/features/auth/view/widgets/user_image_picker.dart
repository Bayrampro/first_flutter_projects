import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:image_picker/image_picker.dart';

import 'widgets.dart';

class UserImagePicker extends StatefulWidget {
  const UserImagePicker({
    super.key,
    required this.onPickImage,
  });

  final void Function(File pickedImage) onPickImage;

  @override
  State<UserImagePicker> createState() => _UserImagePickerState();
}

class _UserImagePickerState extends State<UserImagePicker> {
  File? pickedImageFile;
  final imagePicker = GetIt.I.get<ImagePicker>();

  Future<void> _pickImage(ImageSource source) async {
    final pickedImage = await imagePicker.pickImage(
      source: source,
      imageQuality: 50,
      maxWidth: 150,
    );
    if (pickedImage == null) {
      return;
    }
    setState(() {
      pickedImageFile = File(pickedImage.path);
    });
    widget.onPickImage(pickedImageFile!);
    Navigator.of(context).pop();
  }

  void _chooseCamera() {
    _pickImage(ImageSource.camera);
  }

  void _chooseGallery() {
    _pickImage(ImageSource.gallery);
  }

  void _chooseVariant() {
    if (Platform.isAndroid) {
      final theme = Theme.of(context);
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(
            'Выбери вариант',
            style: theme.textTheme.titleLarge,
          ),
          content: DialogContent(
            chooseCamera: _chooseCamera,
            chooseGallery: _chooseGallery,
          ),
        ),
      );
    } else {
      showCupertinoModalPopup(
        context: context,
        builder: (context) => CupertinoAlertDialog(
          title: const Text('Выбери вариант'),
          content: DialogContent(
            chooseCamera: _chooseCamera,
            chooseGallery: _chooseGallery,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return CircleAvatar(
      backgroundColor: theme.hintColor.withOpacity(0.5),
      foregroundImage:
          pickedImageFile != null ? FileImage(pickedImageFile!) : null,
      radius: 60,
      child: IconButton(
        onPressed: _chooseVariant,
        icon: const Icon(Icons.image),
      ),
    );
  }
}
