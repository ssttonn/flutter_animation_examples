import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:vector_math/vector_math_64.dart' show Vector3;

class Session3Page extends StatefulWidget {
  const Session3Page({super.key});

  @override
  State<Session3Page> createState() => _Session3PageState();
}

class _Session3PageState extends State<Session3Page> with TickerProviderStateMixin {
  late AnimationController _xAnimationController;
  late AnimationController _yAnimationController;
  late AnimationController _zAnimationController;

  late Tween<double> _rotateAnimation;

  @override
  void initState() {
    super.initState();
    _xAnimationController = AnimationController(vsync: this, duration: const Duration(seconds: 20));
    _yAnimationController = AnimationController(vsync: this, duration: const Duration(seconds: 30));
    _zAnimationController = AnimationController(vsync: this, duration: const Duration(seconds: 40));

    _rotateAnimation = Tween<double>(begin: 0, end: pi / 2);

    _xAnimationController
      ..reset()
      ..repeat();
    _yAnimationController
      ..reset()
      ..repeat();
    _zAnimationController
      ..reset()
      ..repeat();
  }

  @override
  void dispose() {
    _xAnimationController.dispose();
    _yAnimationController.dispose();
    _zAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Session 3'),
      ),
      body: Center(
        child: AnimatedBuilder(
            animation: Listenable.merge([_xAnimationController, _yAnimationController, _zAnimationController]),
            builder: (context, child) {
              return Transform(
                transform: Matrix4.identity()
                  ..rotateX(_rotateAnimation.evaluate(_xAnimationController))
                  ..rotateY(_rotateAnimation.evaluate(_yAnimationController))
                  ..rotateZ(_rotateAnimation.evaluate(_zAnimationController)),
                child: Stack(alignment: Alignment.center, children: [
                  Container(width: 100, height: 100, color: Colors.red),
                  Transform(alignment: Alignment.topCenter, transform: Matrix4.identity()..rotateX(pi / 2), child: Container(width: 100, height: 100, color: Colors.green)),
                  Transform(alignment: Alignment.bottomCenter, transform: Matrix4.identity()..rotateX(-pi / 2), child: Container(width: 100, height: 100, color: Colors.blue)),
                  Transform(alignment: Alignment.centerLeft, transform: Matrix4.identity()..rotateY(-pi / 2), child: Container(width: 100, height: 100, color: Colors.yellow)),
                  Transform(alignment: Alignment.centerRight, transform: Matrix4.identity()..rotateY(pi / 2), child: Container(width: 100, height: 100, color: Colors.purple)),
                  Transform(transform: Matrix4.identity()..translate(Vector3(0, 0, 100)), child: Container(width: 100, height: 100, color: Colors.orange)),
                ]),
              );
            }),
      ),
    );
  }
}
