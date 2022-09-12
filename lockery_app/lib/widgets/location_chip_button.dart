import 'package:flutter/material.dart';
import 'package:lockery_app/controllers/controllers.dart';
import 'package:lockery_app/controllers/rack_select_controller.dart';
import 'package:lockery_app/helpers/helpers.dart';
import 'package:lockery_app/models/locations.dart';
import 'package:provider/provider.dart';

class LocationChipButton extends StatelessWidget {
  final LocationModel data;
  final bool isSelected;

  const LocationChipButton(
      {Key? key, required this.data, required this.isSelected})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (context.read<LocationSelectController>().currentValue != data) {
          context.read<LocationSelectController>().changeLocation(data);
          context.read<RackSelectController>().changeRack(null);
        }
      },
      borderRadius: BorderRadius.circular(15.0),
      child: Chip(
        label: Text(data.name!),
        backgroundColor: isSelected ? greenColor : whiteColor,
        labelStyle: TextStyle(color: isSelected ? whiteColor : greenColor),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        elevation: 1,
        clipBehavior: Clip.antiAlias,
        labelPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
      ),
    );
  }
}
