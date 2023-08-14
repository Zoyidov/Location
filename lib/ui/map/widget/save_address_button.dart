import 'package:flutter/material.dart';
import 'package:login_screen_homework/data/providers/locations_povider.dart';
import 'package:provider/provider.dart';
import 'package:login_screen_homework/data/models/map/map_model.dart';
import 'package:login_screen_homework/data/providers/address_call_provider.dart';
import 'package:login_screen_homework/data/providers/api_provider.dart';

class SaveAddressButton extends StatelessWidget {
  const SaveAddressButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: Colors.black.withOpacity(0.8),
      onPressed: () async {
        final addressProvider =
            Provider.of<AddressCallProvider>(context, listen: false);
        final selectedAddress = addressProvider.scrolledAddressText;

        final locationProvider =
            Provider.of<LocationProvider>(context, listen: false);
        final selectedLocation = locationProvider.selectedLocation;

        Provider.of<AddressProvider>(context, listen: false).addAddress(
          Address(
            id: DateTime.now().millisecondsSinceEpoch,
            name: 'Location',
            title: selectedAddress,
            lat: selectedLocation.latitude,
            long: selectedLocation.longitude,
          ),
        );

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.black.withOpacity(0.8),
            content: const Text('Location saved.'),
            duration: const Duration(seconds: 1),
          ),
        );
      },
      child: const Icon(Icons.add),
    );
  }
}
