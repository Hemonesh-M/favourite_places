import 'package:favourite_places/models/place.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({
    super.key,
    this.location = const PlaceLocation(longitude: 0, latitude: 0, address: ""),
    this.isSelecting = true,
  });

  final PlaceLocation location;
  final bool isSelecting;

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
          if (widget.isSelecting)
            IconButton(
              icon: Icon(Icons.save),
              onPressed:
                  _selectedLocation == null
                      ? null
                      : () {
                        Navigator.pop(context, _selectedLocation);
                      },
            ),
        ],
      ),
      body: FlutterMap(
        mapController: _mapController,
        options: MapOptions(
          initialCenter: LatLng(
            widget.location.latitude,
            widget.location.longitude,
          ),
          initialZoom: 13,
          onTap: (tapPosition, point) {
            if (!widget.isSelecting) return;
            setState(() {
              _selectedLocation = point;
            });
          },
        ),
        children: [
          TileLayer(
            urlTemplate:
                "https://{s}-tiles.locationiq.com/v3/light/r/{z}/{x}/{y}.png?key=$apiLocationIQ",
            subdomains: ['a', 'b', 'c'],
          ),
          MarkerLayer(
            markers: [
              if (_selectedLocation != null)
                Marker(
                  point: _selectedLocation!,
                  width: 50,
                  height: 50,
                  child:
                       const Icon(
                        Icons.location_pin,
                        color: Colors.red,
                        size: 40,
                      ),
                  // child: null,
                ),
            ],
          ),
        ],
      ),
      floatingActionButton:
          widget.isSelecting
              ? FloatingActionButton(
                child: const Icon(Icons.check),
                onPressed:
                    _selectedLocation == null
                        ? null
                        : () {
                          Navigator.pop(context, _selectedLocation);
                        },
              )
              : null,
    );
  }
}
