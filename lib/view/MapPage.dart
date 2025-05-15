// map_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:location/location.dart';
import '../Service/LocationService.dart';

class MapScreen extends StatefulWidget {
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  late LocationService _location;
  late LatLng _currentLocation;
  late MapController _mapController;

  @override
  void initState() {
    super.initState();
    _location = LocationService();
    _currentLocation = LatLng(0.0, 0.0); // Default location
    _mapController = MapController(); // Initialize the map controller
    _getCurrentLocation();
  }

  // Mendapatkan lokasi pengguna
  void _getCurrentLocation() async {
    LocationData? location = await _location.getLocation();
    if (location != null) {
      setState(() {
        _currentLocation = LatLng(location.latitude!, location.longitude!);
      });
      _mapController.move(_currentLocation, 15.0); // Pindahkan kamera ke lokasi pengguna
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Flutter Map with Location"),
      ), 
      body: FlutterMap(
        mapController: _mapController, // Pass the map controller to FlutterMap
        options: MapOptions(
          initialCenter: _currentLocation,
          initialZoom: 13.0,
        ),
        children: [
          TileLayer(
            urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
            subdomains: ['a', 'b', 'c'],
          ),
          MarkerLayer(
            markers: [
              Marker(
                point: _currentLocation,
                width: 40.0,
                height: 40.0,
                child: Icon(
                  Icons.location_on,
                  color: Colors.red,
                  size: 40.0,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
