import 'dart:io';
import 'package:favourite_places/main.dart';
import 'package:favourite_places/models/place.dart';
import 'package:favourite_places/provider/list_of_places.dart';
import 'package:favourite_places/widgets/add_image.dart';
import 'package:favourite_places/widgets/pick_location.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AddPlacesScreen extends ConsumerStatefulWidget {
  const AddPlacesScreen({super.key});

  @override
  ConsumerState<AddPlacesScreen> createState() {
    return _AddPlacesScreenState();
  }
}

class _AddPlacesScreenState extends ConsumerState<AddPlacesScreen> {
  final _titleController = TextEditingController();
  File? selectedImage;
  PlaceLocation? selectedLocation;
  void onPickImage(File img){
    selectedImage=img;
  }
  void onPickLocation(PlaceLocation loc){
    selectedLocation=loc;
  }
  void _savePlace() {
    String enteredName = _titleController.text;
    if (enteredName.isEmpty ) {
      return;
    }
    ref.read(newPlaceProvider.notifier).addPlace(enteredName,selectedImage!,selectedLocation!);
    Navigator.of(context).pop();
  }

  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Add Place")),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              decoration: InputDecoration(labelText: "Name"),
              controller: _titleController,
              style: TextStyle(color: theme.colorScheme.onSurface),
            ),
            SizedBox(height: 25,),
            AddImage(onPickImage: onPickImage),
            SizedBox(height: 25,),
            PickLocation(onPickLocation:onPickLocation),
            ElevatedButton.icon(
              onPressed: () {
                _savePlace();
              },
              icon: Icon(Icons.save),
              label: Text("Add This Place"),

            ),
          ],
        ),
      ),
    );
  }
}
