import 'dart:convert';

import 'package:favourite_places/models/place.dart';
import 'package:favourite_places/screens/map_screen.dart';
import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import 'package:location/location.dart';
import 'package:http/http.dart' as http;

class PickLocation extends StatefulWidget {
  const PickLocation({required this.onPickLocation, super.key});
  final Function(PlaceLocation) onPickLocation;
  @override
  State<PickLocation> createState() {
    return _PickLocationState();
  }
}

class _PickLocationState extends State<PickLocation> {
  PlaceLocation? selectedLocation;
  bool isLoadingLocation = false;
  Future<void> _savePlace(LatLng pos) async {
    final lat = pos.latitude;
    final lon = pos.longitude;
    //LocationIQ
    String apiLocationIQ = "pk.eb0fcdbf96f84c8ba6f8708c4e9d7f3c";
    Uri url = Uri.parse(
      "https://us1.locationiq.com/v1/reverse?key=$apiLocationIQ&lat=$lat&lon=$lon&format=json&",
    );
    //GoProMap
    // String apiGoProMap="AlzaSy-n3rstMgXELQhMZ30dNAPj1C1Ddu3DvzU";
    // Uri url=Uri.parse("https://maps.googleapis.com/maps/api/geocode/json?latlng=$lat,$lon&key=$apiGoProMap");
    final response = await http.get(url);
    final data = json.decode(response.body);
    // String add=data["results"][0]["formatted_address"];
    String add = data["display_name"];
    setState(() {
      selectedLocation = PlaceLocation(
        latitude: pos.latitude,
        longitude: pos.longitude,
        address: add,
      );
    });
    setState(() {
      isLoadingLocation = false;
    });
    widget.onPickLocation(selectedLocation!);
  }

  void _getCurrentLocation() async {
    Location location = Location();

    bool serviceEnabled;
    PermissionStatus permissionGranted;
    LocationData locationData;

    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return;
      }
    }

    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return;
      }
    }
    setState(() {
      isLoadingLocation = true;
    });
    locationData = await location.getLocation();
    final pos = LatLng(locationData.latitude!, locationData.longitude!);
    _savePlace(pos);
  }

  void _getLocationFromMap() async {
    final pos = await Navigator.of(context).push<LatLng>(
      MaterialPageRoute(
        builder: (context) {
          return MapScreen();
        },
      ),
    );
    if (pos == null) {
      return;
    }
    setState(() {
      isLoadingLocation = true;
    });
    await _savePlace(pos);
  }

  String _getLocationImage() {
    if (selectedLocation == null) return "";
    final lat = selectedLocation!.latitude;
    final lon = selectedLocation!.longitude;
    String apiLocationIQ = "pk.eb0fcdbf96f84c8ba6f8708c4e9d7f3c";
    return ("https://maps.locationiq.com/v3/staticmap?key=$apiLocationIQ&center=$lat,$lon&zoom=250&size=<width>x<height>&format=<format>&maptype=<MapType>&markers=icon:<icon>|$lat,$lon&markers=icon:<icon>|$lat,$lon");
  }

  @override
  Widget build(BuildContext context) {
    Widget previewContent = Text(
      "No Location Selected",
      textAlign: TextAlign.center,
      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
        color: Theme.of(context).colorScheme.onSurface,
      ),
    );
    if (isLoadingLocation
    // && selectedLocation == null
    ) {
      previewContent = CircularProgressIndicator();
    } else if (selectedLocation != null) {
      // previewContent=Text(selectedLocation!.address);
      previewContent = Image.network(
        _getLocationImage(),
        fit: BoxFit.cover,
        width: double.infinity,
        height: double.infinity,
      );
    }
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            border: Border.all(
              width: 1,
              color: Theme.of(context).colorScheme.primary.withValues(alpha: 2),
            ),
          ),
          height: 170,
          width: double.infinity,
          alignment: Alignment.center,
          child: previewContent,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextButton.icon(
              onPressed: () {
                _getCurrentLocation();
              },
              label: Text("Select Current Location"),
              icon: Icon(Icons.location_on),
            ),
            TextButton.icon(
              label: Text("Pick Location Manually"),
              onPressed: () {
                _getLocationFromMap();
              },
              icon: Icon(Icons.map_outlined),
            ),
          ],
        ),
      ],
    );
  }
}
