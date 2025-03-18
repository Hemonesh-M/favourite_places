import 'dart:io';

import 'package:favourite_places/models/place.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ListOfPlacesNotifier extends StateNotifier<List<Place>> {
  ListOfPlacesNotifier():super(const []);
  void addPlace(String name,File img,PlaceLocation loc){
    final newState=Place(img,name: name,location: loc);
    state=[...state,newState];
  }
}
 final newPlaceProvider=StateNotifierProvider<ListOfPlacesNotifier,List<Place>>((ref) {
   return ListOfPlacesNotifier();
 },);