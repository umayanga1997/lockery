// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:lockery_app/helpers/colors.dart';

class CustomButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final Function onPressed;
  const CustomButton(
      {Key? key,
      required this.icon,
      required this.label,
      required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FlatButton.icon(
      minWidth: double.infinity,
      onPressed: () => onPressed(),
      icon: Icon(
        icon,
        size: 25,
        color: greenColor,
      ),
      label: Text(
        label,
        style: TextStyle(color: greenColor),
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: BorderSide(
          color: greenColor,
          width: 0.8,
        ),
      ),
    );
  }
}
