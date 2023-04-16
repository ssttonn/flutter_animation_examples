import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class RotationTransistionPage extends StatefulWidget {
  const RotationTransistionPage({super.key});

  @override
  State<RotationTransistionPage> createState() => _RotationTransistionPageState();
}

class _RotationTransistionPageState extends State<RotationTransistionPage> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(vsync: this, duration: const Duration(seconds: 15));
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
      appBar: AppBar(
        title: const Text("Rotation Transistion"),
      ),
      body: _body(),
    );
  }

  Widget _body() {
    return Center(
        child: RotationTransition(
      alignment: Alignment.center,
      turns: _animationController,
      child: Container(
        width: 100,
        height: 100,
        color: Colors.red,
      ),
    ));
  }
}
