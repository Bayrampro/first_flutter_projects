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
    return SizedBox(
      height: 100,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ChoosingButton(
            iconData: Icons.photo_camera,
            label: 'Камера',
            onPressed: chooseCamera,
          ),
          const SizedBox(width: 16.0),
          ChoosingButton(
            iconData: Icons.photo_library,
            label: 'Галерея',
            onPressed: chooseGallery,
          ),
        ],
      ),
    );
  }
}
