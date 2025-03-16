import 'package:favourite_places/main.dart';
import 'package:favourite_places/models/place.dart';
import 'package:flutter/material.dart';

class PlaceDetailScreen extends StatelessWidget {
  const PlaceDetailScreen({required this.selectedPlace, super.key});
  final Place selectedPlace;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(selectedPlace.name)),
      body: Center(
        child: Column(
          children: [
            Image.file(selectedPlace.img!,fit: BoxFit.contain,),
            Text(
              selectedPlace.name,
              style: theme.textTheme.titleLarge!.copyWith(
                color: theme.colorScheme.onSurface,
                fontSize: 48
              ),
            ),
          ],
        ),
      ),
    );
  }
}
