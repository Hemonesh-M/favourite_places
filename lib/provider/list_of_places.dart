import 'dart:io';

import 'package:favourite_places/models/place.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path_provider/path_provider.dart' as syspath;
import 'package:path/path.dart' as path;
import 'package:sqflite/sqflite.dart' as sql;

Future<sql.Database> _getDB() async {
  final dbPath = await sql.getDatabasesPath();
  final db = await sql.openDatabase(
    path.join(dbPath, "Fav_Places.db"),
    onCreate: (db, version) {
      return db.execute(
        "CREATE TABLE listOfPlace(id TEXT PRIMARY KEY,name TEXT,image TEXT,lat REAL,lon REAL,address TEXT )",
      );
    },
    version: 1,
  );
  return db;
}

class ListOfPlacesNotifier extends StateNotifier<List<Place>> {
  ListOfPlacesNotifier() : super(const []);
  Future<void> loadPlaces() async {
    final db = await _getDB();
    final data = await db.query("listOfPlace");
    final mapData =
        data.map((row) {
          return Place(
            File(row["image"] as String),
            name: row["name"] as String,
            location: PlaceLocation(
              latitude: row["lat"] as double,
              longitude: row["lon"] as double,
              address: row["address"] as String,
            ),
            id: row["id"] as String,
          );
        }).toList();
    state = mapData;
  }


  void addPlace(String name, File img, PlaceLocation loc) async {
    final appdir = await syspath.getApplicationDocumentsDirectory();
    final fileName = path.basename(img.path);
    final copiedImage = await img.copy("${appdir.path}/$fileName");
    final newState = Place(copiedImage, name: name, location: loc);
    final db = await _getDB();
    db.insert("listOfPlace", {
      "id": newState.id,
      "name": newState.name,
      "image": newState.img!.path,
      "lat": newState.location.latitude,
      "lon": newState.location.longitude,
      "address": newState.location.address,
    });

    state = [...state, newState];
  }
}

final newPlaceProvider =
    StateNotifierProvider<ListOfPlacesNotifier, List<Place>>((ref) {
      return ListOfPlacesNotifier();
    });
