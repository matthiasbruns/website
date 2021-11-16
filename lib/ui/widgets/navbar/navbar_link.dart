import 'package:flutter/material.dart';

class NavbarButton extends StatelessWidget {
  final String label;

  const NavbarButton({Key? key, required this.label}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        // Respond to button press
      },
      child: Text(label),
    );
  }
}
