import 'dart:io';

import 'package:favorite_places/models/models.dart';
import 'package:get_it/get_it.dart';
import 'package:uuid/uuid.dart';

final uuid = GetIt.I.get<Uuid>();

class Place {
  Place({
    required this.title,
    required this.image,
    required this.placeLocation,
  }) : id = uuid.v4();

  final String id;
  final String title;
  final File image;
  final PlaceLocation placeLocation;
}
