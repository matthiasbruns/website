import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:matthiasbruns/ui/widgets/navbar/navbar_link.dart';

class Navbar extends StatelessWidget {
  const Navbar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: const [
            Padding(
              padding: EdgeInsets.only(right: 16),
              child: NavbarButton(label: "INTRO"),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: NavbarButton(label: "PORTFOLIO"),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: NavbarButton(label: "SERVICES"),
            ),
            Padding(
              padding: EdgeInsets.only(left: 16),
              child: NavbarButton(label: "CONTACT"),
            )
          ],
        ),
      ],
    );
  }
}
