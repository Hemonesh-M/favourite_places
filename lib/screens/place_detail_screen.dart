import 'package:favourite_places/main.dart';
import 'package:favourite_places/models/place.dart';
import 'package:favourite_places/screens/map_screen.dart';
import 'package:flutter/material.dart';

class PlaceDetailScreen extends StatelessWidget {
  PlaceDetailScreen({required this.selectedPlace, super.key})
    : selectedLocation = selectedPlace.location;
  final Place selectedPlace;
  final PlaceLocation selectedLocation;
  String _getLocationImage() {
    final lat = selectedLocation.latitude;
    final lon = selectedLocation.longitude;
    String apiLocationIQ = "pk.eb0fcdbf96f84c8ba6f8708c4e9d7f3c";
    return ("https://maps.locationiq.com/v3/staticmap?key=$apiLocationIQ&center=$lat,$lon&zoom=16&size=100x100&format=jpeg&maptype=streets&markers=icon:<icon>|$lat,$lon&markers=icon:<icon>|$lat,$lon");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(selectedPlace.name)),
      body: Center(
        child: Stack(
          children: [
            Image.file(
              selectedPlace.img!,
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Colors.transparent, Colors.black54],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 44, horizontal: 22),
                    child: Column(
                      children: [
                        Text(
                          selectedPlace.name,
                          style: theme.textTheme.titleLarge!.copyWith(
                            color: theme.colorScheme.onSurface,
                            fontSize: 48,
                          ),
                        ),
                        GestureDetector(
                          onTap: (){
                            Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                              return MapScreen(location: selectedLocation,isSelecting: false ,);
                            },));
                          },
                          child: CircleAvatar(
                            radius: 70,
                            backgroundImage: NetworkImage(_getLocationImage()),
                            // child: Image.network(_getLocationImage()),
                          ),
                        ),
                        Text(
                          textAlign: TextAlign.center,
                          selectedPlace.location.address,
                          style: Theme.of(context).textTheme.bodyLarge!
                              .copyWith(color: colorScheme.onSurface),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
