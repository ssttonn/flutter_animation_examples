import 'dart:math';

import 'package:flutter/material.dart';

class Session2Page extends StatefulWidget {
  const Session2Page({super.key});

  @override
  State<Session2Page> createState() => _Session2PageState();
}

class _Session2PageState extends State<Session2Page> with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _clockwiseRotateAnimation;

  late AnimationController _flipAnimationController;
  late Animation<double> _flipAnimation;

  @override
  void initState() {
    super.initState();

    // create animation controller
    _animationController = AnimationController(vsync: this, duration: const Duration(milliseconds: 500));

    // create animation, which will be used to rotate the circle by 90 degrees counter-clockwise
    _clockwiseRotateAnimation = Tween<double>(begin: 0, end: -(pi / 2)).animate(CurvedAnimation(parent: _animationController, curve: Curves.easeIn));

    // create animation controller for flip animation
    _flipAnimationController = AnimationController(vsync: this, duration: const Duration(milliseconds: 500));

    // create animation, which will be used to flip the circle in horizontal axis
    _flipAnimation = Tween<double>(begin: 0, end: pi).animate(CurvedAnimation(parent: _flipAnimationController, curve: Curves.easeIn));

    _animationController.addStatusListener((status) {
      // check if animation is completed
      if (status == AnimationStatus.completed) {
        _flipAnimation =
            Tween<double>(begin: _flipAnimation.value, end: _flipAnimation.value + pi).animate(CurvedAnimation(parent: _flipAnimationController, curve: Curves.bounceInOut));
        //reset flip animation then forward it
        _flipAnimationController
          ..reset()
          ..forward();
      }
    });

    _flipAnimationController.addStatusListener((status) {
      // check if animation is completed
      if (status == AnimationStatus.completed) {
        _clockwiseRotateAnimation = Tween<double>(begin: _clockwiseRotateAnimation.value, end: _clockwiseRotateAnimation.value - (pi / 2))
            .animate(CurvedAnimation(parent: _animationController, curve: Curves.bounceInOut));
        //reset flip animation then forward it
        _animationController
          ..reset()
          ..forward();
      }
    });

    // start animation after 1 second
    Future.delayed(const Duration(seconds: 1), () {
      _animationController.forward();
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    _flipAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Session 2'),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 14),
        child: AnimatedBuilder(
            animation: _clockwiseRotateAnimation,
            builder: (context, child) {
              return Transform(
                transform: Matrix4.identity()..rotateZ(_clockwiseRotateAnimation.value),
                alignment: Alignment.center,
                child: Row(
                  children: [
                    Flexible(
                      child: AnimatedBuilder(
                          animation: _flipAnimation,
                          builder: (context, child) {
                            return Transform(
                              transform: Matrix4.identity()..rotateY(_flipAnimation.value),
                              alignment: Alignment.centerRight,
                              child: AspectRatio(
                                aspectRatio: 1,
                                child: ClipPath(
                                  clipper: HalfCircleClipper(side: CircleSide.left),
                                  child: Container(
                                    color: Colors.blueAccent,
                                  ),
                                ),
                              ),
                            );
                          }),
                    ),
                    Flexible(
                        child: AnimatedBuilder(
                            animation: _flipAnimation,
                            builder: (context, child) {
                              return Transform(
                                  transform: Matrix4.identity()..rotateY(_flipAnimation.value),
                                  alignment: Alignment.centerLeft,
                                  child:
                                      AspectRatio(aspectRatio: 1, child: ClipPath(clipper: HalfCircleClipper(side: CircleSide.right), child: Container(color: Colors.redAccent))));
                            }))
                  ],
                ),
              );
            }),
      ),
    );
  }
}

class HalfCircleClipper extends CustomClipper<Path> {
  final CircleSide side;

  HalfCircleClipper({required this.side});

  @override
  Path getClip(Size size) {
    return side.toPath(size);
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}

enum CircleSide { left, right }

extension ToPath on CircleSide {
  Path toPath(Size size) {
    final path = Path();
    late Offset offset;
    late bool clockwise;

    switch (this) {
      case CircleSide.left:
        path.moveTo(size.width, 0);
        offset = Offset(size.width, size.width);
        clockwise = false;
        break;
      case CircleSide.right:
        offset = Offset(0, size.height);
        clockwise = true;
        break;
    }
    path.arcToPoint(offset, radius: Radius.elliptical(size.width / 2, size.height / 2), clockwise: clockwise);
    path.close();

    return path;
  }
}
