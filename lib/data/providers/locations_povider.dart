import 'package:flutter/cupertino.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocationProvider extends ChangeNotifier {
  LatLng _selectedLocation = LatLng(0,0);
  // LatLng _selectedLocation = LatLng(selectedLocation.latitude,selectedLocation.longitude);

  LatLng get selectedLocation => _selectedLocation;

  void updateSelectedLocation(LatLng newLocation) {
    _selectedLocation = newLocation;
    notifyListeners();
  }
}
