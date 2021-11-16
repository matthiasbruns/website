import 'package:flutter/material.dart';

const heroTextStyle = TextStyle(fontSize: 44, height: 50 / 44);

class HeroText extends StatelessWidget {
  final String label;

  const HeroText({Key? key, required this.label}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: heroTextStyle,
      textAlign: TextAlign.end,
    );
  }
}
