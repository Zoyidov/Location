import 'package:flutter/material.dart';
import 'package:login_screen_homework/ui/saved_address_mapscreen/saved_address_mapscreen.dart';


class ChangedLocation extends StatelessWidget {
  const ChangedLocation({
    super.key,
    required this.widget,
    required this.updatedTitle,
  });

  final SavedAddressMapScreen widget;
  final String updatedTitle;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      margin: const EdgeInsets.only(top: 5, left: 5, right: 50),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(30),color: Colors.black.withOpacity(0.8)),
      child: Text(
        updatedTitle,
        style: const TextStyle(
          fontSize: 12,
          color: Colors.white
        ),
      ),
    );
  }
}
