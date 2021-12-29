import 'package:flutter/material.dart';

class ReusableCard extends StatelessWidget {
  late final Color colour;
  late final Widget? cardChild;
  late final VoidCallback? onPress;

  ReusableCard({required this.colour, this.cardChild, this.onPress});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: Container(
        child: cardChild,
        margin: EdgeInsets.all(15.0),
        decoration: BoxDecoration(
          color: colour,
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
    );
  }
}