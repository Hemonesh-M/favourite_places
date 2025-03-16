import 'package:favourite_places/main.dart';
import 'package:favourite_places/models/place.dart';
import 'package:favourite_places/screens/place_detail_screen.dart';
import 'package:flutter/material.dart';

class PlacesList extends StatelessWidget {
  const PlacesList({required this.listOfPlaces, super.key});
  final List<Place> listOfPlaces;
  @override
  Widget build(BuildContext context) {
    if (listOfPlaces.isEmpty) {
      return Center(
        child: Text(
          "NO Places Adeed, Add Using Button on Top Right Corner",
          style: Theme.of(
            context,
          ).textTheme.bodyLarge!.copyWith(color: colorScheme.onSurface),
        ),
      );
    }
    return ListView.builder(
      itemCount: listOfPlaces.length,

      itemBuilder: (context, index) {
        return ListTile(
          shape: Border.all(
            width: 1,
            color: Theme.of(context).colorScheme.onSurface,
            
          ),
          contentPadding: EdgeInsets.all(9),
          leading: CircleAvatar(
            radius: 26,
            // using child results were bad , image was flowing out
            // child: Image.file(listOfPlaces[index].img!,fit: BoxFit.cover,),
            backgroundImage: FileImage(listOfPlaces[index].img!),
          ),
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) {
                  return PlaceDetailScreen(selectedPlace: listOfPlaces[index]);
                },
              ),
            );
          },
          title: Text(
            listOfPlaces[index].name,
            style: Theme.of(
              context,
            ).textTheme.bodyLarge!.copyWith(color: colorScheme.onSurface),
          ),
        );
      },
    );
  }
}
