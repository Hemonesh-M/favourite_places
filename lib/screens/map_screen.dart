import 'package:favourite_places/models/place.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({
    super.key,
    this.location = const PlaceLocation(
      latitude: 40.741895,
      longitude: -73.989308,
      address: "New York",
    ),
    this.isSelecting = true,
  });

  final PlaceLocation location;
  final bool isSelecting;
  // final Function(LatLng pos) _getLocationFromMap;

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  String apiLocationIQ = "pk.eb0fcdbf96f84c8ba6f8708c4e9d7f3c";
  LatLng? _selectedLocation;
  final MapController _mapController = MapController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.isSelecting ? "Pick Your Location" : "Your Location",
        ),
        actions: [
          if (widget.isSelecting && _selectedLocation != null)
            IconButton(
              icon: const Icon(Icons.save),
              onPressed: () {
                print("SELECTED POS SEND BACK IS $_selectedLocation:");
                Navigator.of(context).pop(_selectedLocation);
              },
            ),
        ],
      ),
      body: FlutterMap(
        mapController: _mapController,
        options: MapOptions(
          onTap:
              widget.isSelecting
                  ? (tapPosition, point) {
                    setState(() {
                      _selectedLocation = point;
                    });
                  }
                  : null,
          initialCenter: LatLng(
            widget.location.latitude,
            widget.location.longitude,
          ),
          initialZoom: 16,
        ),
        children: [
          TileLayer(
            urlTemplate:
                "https://{s}-tiles.locationiq.com/v3/light/r/{z}/{x}/{y}.png?key=$apiLocationIQ",
            subdomains: ['a', 'b', 'c'],
          ),
          MarkerLayer(
            markers:
                (widget.isSelecting == true && _selectedLocation == null)
                    ? []
                    : [
                      Marker(
                        point:
                            _selectedLocation ??
                            LatLng(
                              widget.location.latitude,
                              widget.location.longitude,
                            ),
                        width: 50,
                        height: 50,
                        child: const Icon(
                          Icons.location_pin,
                          color: Colors.red,
                          size: 40,
                        ),
                      ),
                    ],
          ),
        ],
      ),
    );
  }
}
