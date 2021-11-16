import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:matthiasbruns/gen/colors.gen.dart';
import 'package:matthiasbruns/ui/widgets/logo.dart';
import 'package:matthiasbruns/ui/widgets/navbar/navbar.dart';
import 'package:matthiasbruns/ui/widgets/text/hero_text.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {
  late ScrollController _bodyScrollController;
  late AnimationController _animationController;
  late Animation<Color?> _backgroundScrollTween;
  late Animation<Offset> _logoOffsetTween;
  late Animation<double> _navbarOpacityTween;

  @override
  void initState() {
    super.initState();
    _bodyScrollController = ScrollController();

    _animationController = AnimationController(vsync: this, duration: const Duration(milliseconds: 250));

    _backgroundScrollTween =
        ColorTween(begin: ColorName.logoBackground, end: ColorName.background).animate(_animationController);
    _logoOffsetTween = Tween<Offset>(begin: const Offset(1, 1), end: const Offset(0, 0)).animate(_animationController);
    _navbarOpacityTween = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(
          0.5,
          1.0,
          curve: Curves.easeIn,
        ),
      ),
    );

    _bodyScrollController.addListener(() {
      _animationController.animateTo(
        _bodyScrollController.offset * 0.0015,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    _bodyScrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    final size = MediaQuery.of(context).size;
    final contentPadding = max(32.0, min((size.width - 670.0) / 2, (size.width - 920.0) / 4));
    final contentWidth = size.width - 2 * contentPadding;
    final logoWidth = max(250.0, size.width / 2.5);

    return Scaffold(
      backgroundColor: ColorName.white,
      body: Stack(
        children: [
          SingleChildScrollView(
            controller: _bodyScrollController,
            child: AnimatedBuilder(
              builder: (context, child) {
                return Container(
                  height: 20000,
                  width: double.infinity,
                  color: _backgroundScrollTween.value,
                );
              },
              animation: _backgroundScrollTween,
            ),
          ),
          FadeTransition(
            opacity: _navbarOpacityTween,
            child: Padding(
              padding: EdgeInsets.only(top: 70, right: contentPadding),
              child: const Navbar(),
            ),
          ),
          Positioned(
            top: 250,
            right: contentPadding,
            child: FadeTransition(
              opacity: _navbarOpacityTween,
              child: IgnorePointer(
                child: Container(
                  constraints: const BoxConstraints(maxWidth: 540),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      const HeroText(label: "Android and Flutter Freelancer based on Cologne."),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: const [
                          Text("+491718310017"),
                          Text("info@matthiasbruns.com"),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
          ScaleTransition(
            scale: Tween(begin: 1.0, end: 0.5).animate(_animationController),
            child: AnimatedBuilder(
              builder: (context, child) {
                var offset = Offset(
                  ((size.width / 2) * _logoOffsetTween.value.dx) +
                      ((1 - _logoOffsetTween.value.dx) * contentPadding * 2) -
                      logoWidth / 2,
                  size.height / 2 * _logoOffsetTween.value.dy - logoWidth / 2,
                );
                return Transform.translate(
                  offset: offset,
                  child: child,
                );
              },
              animation: _logoOffsetTween,
              child: IgnorePointer(child: Logo(logoWidth: logoWidth)),
            ),
          ),
        ],
      ),
    );
  }
}
