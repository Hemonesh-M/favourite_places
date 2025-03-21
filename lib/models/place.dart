import 'dart:io';

import 'package:uuid/uuid.dart';

final uuid = Uuid();
class PlaceLocation{
  const PlaceLocation({required this.latitude,required this.longitude,required this.address});
  final double latitude;
  final double longitude;
  final String address;
}
class Place {
  Place(this.img, {required this.name,required this.location,id}) : id = id??uuid.v4();
  final String id;
  final String name;
  final File? img;
  final PlaceLocation location;

}
