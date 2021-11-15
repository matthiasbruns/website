import 'package:flutter/material.dart';
import 'package:matthiasbruns/gen/assets.gen.dart';
import 'package:matthiasbruns/gen/colors.gen.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {
  late ScrollController _bodyScrollController;
  late AnimationController _animationController;
  late Animation<double> _logoScaleTween;
  late Animation<Color?> _backgroundScrollTween;
  late Animation<Offset> _logoOffsetTween;

  @override
  void initState() {
    super.initState();
    _bodyScrollController = ScrollController();

    _animationController = AnimationController(vsync: this, duration: const Duration(milliseconds: 250));

    _logoScaleTween = Tween(begin: 1.0, end: .5).animate(_animationController);
    _backgroundScrollTween =
        ColorTween(begin: ColorName.logoBackground, end: ColorName.background).animate(_animationController);
    _logoOffsetTween =
        Tween<Offset>(begin: const Offset(.5, .5), end: const Offset(0.25, 0)).animate(_animationController);

    _bodyScrollController.addListener(() {
      _animationController.animateTo(_bodyScrollController.offset * 0.001);
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
          ScaleTransition(
            scale: _logoScaleTween,
            child: AnimatedBuilder(
              builder: (context, child) {
                var offset = Offset(
                  size.width * _logoOffsetTween.value.dx - 250,
                  size.height * _logoOffsetTween.value.dy - 250,
                );
                return Transform.translate(
                  offset: offset,
                  child: child,
                );
              },
              animation: _logoOffsetTween,
              child: Container(
                width: 500,
                height: 500,
                color: ColorName.logoBackground,
                child: Padding(
                  padding: const EdgeInsets.all(80.0),
                  child: Center(
                    child: Assets.svg.logo.svg(),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
