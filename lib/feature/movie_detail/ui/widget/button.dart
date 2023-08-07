import 'package:flutter/material.dart';

class ButtonCustom extends StatelessWidget {
  final Icon iconData;
  const ButtonCustom({super.key, required this.iconData});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(4),
        decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.6),
            borderRadius: BorderRadius.circular(8)),
        child: Icon(
          iconData.icon,
          size: 28,
          color: Colors.white,
        ));
  }
}
