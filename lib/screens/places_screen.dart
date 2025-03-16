import 'package:favourite_places/provider/list_of_places.dart';
import 'package:favourite_places/screens/add_places_screen.dart';
import 'package:favourite_places/widgets/places_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PlacesScreen extends ConsumerWidget {
  const PlacesScreen({super.key});
  @override
  Widget build(BuildContext context,WidgetRef ref) {
    final listOfPlaces =ref.watch(newPlaceProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text("Your Places"),
        actions: [IconButton(onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (context) {
            return AddPlacesScreen();
          },));
          // MaterialPageRoute(builder: MaterialApp.router())
        }, icon: Icon(Icons.add_box))],
      ),
      body: Padding(padding: EdgeInsets.all(9),child: PlacesList(listOfPlaces:listOfPlaces )),
    );
  }
}
