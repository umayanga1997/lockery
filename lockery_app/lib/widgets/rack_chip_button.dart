import 'package:flutter/material.dart';
import 'package:lockery_app/controllers/rack_select_controller.dart';
import 'package:lockery_app/helpers/helpers.dart';
import 'package:lockery_app/models/models.dart';
import 'package:provider/provider.dart';

class RackChipButton extends StatelessWidget {
  final RackModel data;
  final bool isSelected;

  const RackChipButton({Key? key, required this.data, required this.isSelected})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => context.read<RackSelectController>().changeRack(data.id!),
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
