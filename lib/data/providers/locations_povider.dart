import 'package:flutter/cupertino.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocationProvider extends ChangeNotifier {
  LatLng _selectedLocation;

  LocationProvider({required double initialLat, required double initialLong})
      : _selectedLocation = LatLng(initialLat, initialLong);

  LatLng get selectedLocation => _selectedLocation;

  void updateSelectedLocation(LatLng newLocation) {
    _selectedLocation = newLocation;
    notifyListeners();
  }
}

