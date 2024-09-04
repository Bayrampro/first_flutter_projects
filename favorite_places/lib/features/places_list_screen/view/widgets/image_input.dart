import 'dart:io';

import 'package:flutter/material.dart';

class ImageInput extends StatelessWidget {
  const ImageInput({
    super.key,
    required this.chooseVariant,
    this.selectedImage,
  });

  final File? selectedImage;
  final VoidCallback chooseVariant;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      width: double.infinity,
      height: 250,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        border: Border.all(
          width: 3,
          color: theme.colorScheme.secondaryContainer,
        ),
      ),
      child: selectedImage == null
          ? TextButton.icon(
              onPressed: chooseVariant,
              label: const Text('Фото'),
              icon: const Icon(Icons.photo_library),
            )
          : GestureDetector(
              onTap: chooseVariant,
              child: Image.file(
                selectedImage!,
                fit: BoxFit.cover,
                width: double.infinity,
                height: double.infinity,
              ),
            ),
    );
  }
}
