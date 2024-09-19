import 'package:chat_app/firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:image_picker/image_picker.dart';

import 'app/app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  GetIt.I.registerLazySingleton<FirebaseAuth>(
    () => FirebaseAuth.instance,
  );
  GetIt.I.registerLazySingleton<ImagePicker>(
    () => ImagePicker(),
  );
  runApp(const ChatApp());
}
