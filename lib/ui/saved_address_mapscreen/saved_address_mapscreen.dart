// ignore_for_file: use_build_context_synchronously, library_private_types_in_public_api

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:login_screen_homework/data/models/map/map_model.dart';
import 'package:login_screen_homework/data/providers/address_call_provider.dart';
import 'package:login_screen_homework/data/providers/api_provider.dart';
import 'package:login_screen_homework/ui/map/widget/kind_of_address.dart';
import 'package:login_screen_homework/ui/map/widget/language_of_address.dart';
import 'package:login_screen_homework/ui/map/widget/type_of_map.dart';
import 'package:login_screen_homework/ui/saved_address_mapscreen/widget/changed_location.dart';
import 'package:provider/provider.dart';

class SavedAddressMapScreen extends StatefulWidget {
  final Address address;

  const SavedAddressMapScreen({required this.address, Key? key})
      : super(key: key);

  @override
  _SavedAddressMapScreenState createState() => _SavedAddressMapScreenState();
}

class _SavedAddressMapScreenState extends State<SavedAddressMapScreen> {
  MapType _selectedMapType = MapType.normal;
  late LatLng markerLocation;
  late String updatedTitle;

  @override
  void initState() {
    super.initState();
    markerLocation = LatLng(widget.address.lat, widget.address.long);
    updatedTitle = widget.address.title;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.black.withOpacity(0.8),
        title: const Text('Address'),
      ),
      body: Stack(
        children: [
          GoogleMap(
            mapType: _selectedMapType,
            zoomControlsEnabled: false,
            compassEnabled: false,
            myLocationEnabled: true,
            myLocationButtonEnabled: false,
            initialCameraPosition: CameraPosition(
              target: markerLocation,
              zoom: 15,
            ),
            markers: {
              Marker(
                markerId: const MarkerId('selectedAddress'),
                position: markerLocation,
                infoWindow: InfoWindow(
                  title: widget.address.name,
                  snippet: widget.address.title,
                ),
              ),
            },
            onTap: (LatLng newLocation) async {
              setState(() {
                markerLocation = newLocation;
              });
              final addressProvider =
                  Provider.of<AddressCallProvider>(context, listen: false);
              await addressProvider.getAddressByLatLong(latLng: newLocation);
              setState(() {
                updatedTitle = addressProvider.scrolledAddressText;
              });
            },
          ),
          ChangedLocation(widget: widget, updatedTitle: updatedTitle),
          Positioned(
            right: 3,
            child: TypeOfMap(
              mapType: _selectedMapType,
              onChanged: (mapType) {
                setState(() {
                  _selectedMapType = mapType;
                });
              },
            ),
          ),
          const Positioned(top: 40, right: 2, child: KindOfAddress()),
          const Positioned(top: 80, right: 2, child: LanguageOfAddress()),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black.withOpacity(0.8),
        onPressed: () async {
          final updatedAddress = widget.address.copyWith(
            lat: markerLocation.latitude,
            long: markerLocation.longitude,
            title: updatedTitle,
          );

          await Provider.of<AddressProvider>(context, listen: false)
              .updateAddress(updatedAddress);

          Navigator.pop(context);

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: Colors.black.withOpacity(0.8),
              content: const Text('Location updated.'),
              duration: const Duration(seconds: 1),
            ),
          );
        },
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              CupertinoIcons.location_fill,
              size: 15,
            ),
            Icon(CupertinoIcons.refresh_bold),
          ],
        ),
      ),
    );
  }
}
