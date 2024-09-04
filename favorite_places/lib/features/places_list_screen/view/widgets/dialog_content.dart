import 'package:flutter/material.dart';

import 'widgets.dart';

class DialogContent extends StatelessWidget {
  const DialogContent({
    super.key,
    required this.chooseCamera,
    required this.chooseGallery,
  });

  final VoidCallback chooseCamera;
  final VoidCallback chooseGallery;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ChoosingButton(
          label: 'Камера',
          icon: Icons.photo_camera,
          onPressed: chooseCamera,
        ),
        ChoosingButton(
          label: 'Галерея',
          icon: Icons.photo_library,
          onPressed: chooseGallery,
        ),
      ],
    );
  }
}
