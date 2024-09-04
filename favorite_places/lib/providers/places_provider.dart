import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sqflite/sqflite.dart' as sql;
import 'package:sqflite/sqlite_api.dart';
import 'package:path/path.dart' as path;

import '../models/models.dart';

Future<Database> _getDatabase() async {
  final dbPath = await sql.getDatabasesPath();
  final db = await sql.openDatabase(
    path.join(dbPath, 'places.db'),
    onCreate: (db, version) => db.execute(
      'CREATE TABLE user_places(id TEXT PRIMARY KEY, title TEXT, image TEXT, ln REAL, lt REAL, adress TEXT)',
    ),
    version: 1,
  );
  return db;
}

Future<void> _setDatabase(Place place) async {
  final db = await _getDatabase();
  db.insert('user_places', {
    'id': place.id,
    'title': place.title,
    'image': place.image.path,
    'ln': place.placeLocation.ln,
    'lt': place.placeLocation.lt,
    'adress': place.placeLocation.adress,
  });
}

class PlacesNotifier extends StateNotifier<List<Place>> {
  PlacesNotifier() : super(const []);

  Future<void> loadData() async {
    final db = await _getDatabase();
    final data = await db.query('user_places');
    final places = data
        .map(
          (row) => Place(
            title: row['title'] as String,
            image: File(row['image'] as String),
            placeLocation: PlaceLocation(
              ln: row['ln'] as double,
              lt: row['lt'] as double,
              adress: row['adress'] as String,
            ),
          ),
        )
        .toList();
    state = places;
  }

  Future<void> addPlace(Place place) async {
    await _setDatabase(place);
    state = [place, ...state];
  }
}

final placesProvider = StateNotifierProvider<PlacesNotifier, List<Place>>(
  (ref) => PlacesNotifier(),
);
