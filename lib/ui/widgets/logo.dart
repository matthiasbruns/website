import 'package:flutter/cupertino.dart';
import 'package:matthiasbruns/gen/assets.gen.dart';
import 'package:matthiasbruns/gen/colors.gen.dart';

class Logo extends StatelessWidget {
  final double logoWidth;

  const Logo({Key? key, this.logoWidth = 500.0}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: logoWidth,
      height: logoWidth,
      color: ColorName.logoBackground,
      child: Padding(
        padding: EdgeInsets.all(logoWidth < 400.0 ? 40.0 : 80.0),
        child: Center(
          child: Assets.svg.logo.svg(),
        ),
      ),
    );
  }
}
