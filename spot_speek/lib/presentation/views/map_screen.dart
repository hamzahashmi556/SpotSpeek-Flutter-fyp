import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:spot_speek/core/constants/app_colors.dart';

class MapScreen extends StatefulWidget {
  LatLng _selectedLocation;
  MapScreen(this._selectedLocation);

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  // late GoogleMapController _mapController;
  //= (24.8607, 67.0011); // Default Karachi

  final MapController controller = MapController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Select Location")),
      body: Stack(
        children: [
          // Google Map
          FlutterMap(
            mapController: controller,
            options: MapOptions(
                initialCenter: widget._selectedLocation, initialZoom: 13.0),
            children: [
              TileLayer(
                urlTemplate:
                    "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                subdomains: ['a', 'b', 'c'],
              )
            ],
          ),

          // Custom Pin
          Center(child: Icon(Icons.location_pin, size: 40, color: Colors.red)),

          // Save Button
          Positioned(
            bottom: 20,
            left: 20,
            right: 20,
            child: ElevatedButton(
              onPressed: () {
                Navigator.pop(context, controller.camera.center);
              },
              child: Text("Save Location"),
            ),
          ),
        ],
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 60.0),
        child: FloatingActionButton(
          onPressed: () {
            controller.move(widget._selectedLocation, 13.0);
          },
          backgroundColor: AppColors.primary,
          child: Icon(Icons.gps_fixed, color: Colors.white),
        ),
      ),
    );
  }
}
