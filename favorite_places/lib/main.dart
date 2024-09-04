import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:uuid/uuid.dart';
import 'app/app.dart';

void main() {
  GetIt.I.registerLazySingleton<Uuid>(
    () => const Uuid(),
  );
  runApp(
    const ProviderScope(
      child: FavoritePlacesApp(),
    ),
  );
}
