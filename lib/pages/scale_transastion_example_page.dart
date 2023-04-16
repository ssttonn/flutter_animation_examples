import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ScaleTransistionExamplePage extends StatefulWidget {
  const ScaleTransistionExamplePage({super.key});

  @override
  State<ScaleTransistionExamplePage> createState() => _ScaleTransistionExamplePageState();
}

class _ScaleTransistionExamplePageState extends State<ScaleTransistionExamplePage> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(vsync: this, duration: const Duration(seconds: 1));
    _scaleAnimation = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(parent: _animationController, curve: Curves.bounceInOut));
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Scale Transastion Example'),
      ),
      body: Center(
        child: Column(
          children: [
            ScaleTransition(
                scale: _scaleAnimation.drive(CurveTween(curve: Curves.easeIn)),
                child: const FlutterLogo(
                  size: 200,
                )),
            CupertinoButton(
                child: const Text("Animate"),
                onPressed: () {
                  if (_animationController.status == AnimationStatus.completed) {
                    _animationController.reverse();
                  } else {
                    _animationController.forward();
                  }
                })
          ],
        ),
      ),
    );
  }
}
