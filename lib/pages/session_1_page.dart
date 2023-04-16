import 'dart:math';

import 'package:flutter/material.dart';

class Session1Page extends StatefulWidget {
  const Session1Page({super.key});

  @override
  State<Session1Page> createState() => _Session1PageState();
}

class _Session1PageState extends State<Session1Page> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _rotateAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(vsync: this, duration: const Duration(seconds: 1));

    _rotateAnimation = Tween<double>(begin: 0, end: pi * 2).animate(_animationController);
    _animationController.repeat();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Session 1 page")),
      body: Center(
        child: AnimatedBuilder(
            animation: _rotateAnimation,
            builder: (context, child) {
              return Transform(
                alignment: Alignment.center,
                transform: Matrix4.identity()..rotateY(_rotateAnimation.value),
                child: Container(
                  width: 100,
                  height: 100,
                  color: Colors.blueAccent,
                ),
              );
            }),
      ),
    );
  }
}
