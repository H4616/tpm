//location service
import 'package:location/location.dart';

class LocationService {
  Location _location = Location();

  Future<LocationData?> getLocation() async {
    try {
      return await _location.getLocation();
    } catch (e) {
      return null;
    }
  }
}
