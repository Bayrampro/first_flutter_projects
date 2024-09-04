import 'package:flutter/material.dart';

import '../features/places_list_screen/places_list.dart';
import '../ui/ui.dart';

class FavoritePlacesApp extends StatelessWidget {
  const FavoritePlacesApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Great Places',
      theme: theme,
      home: const PlacesListScreen(),
    );
  }
}
