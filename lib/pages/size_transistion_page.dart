import 'package:flutter/material.dart';

class SizeTransistionPage extends StatefulWidget {
  const SizeTransistionPage({super.key});

  @override
  State<SizeTransistionPage> createState() => _SizeTransistionPageState();
}

class _SizeTransistionPageState extends State<SizeTransistionPage> with SingleTickerProviderStateMixin {
  late Animation<double> _animation;
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(vsync: this, duration: const Duration(milliseconds: 2000));
    _animation = Tween<double>(begin: 10, end: 300).animate(_animationController);
    _animation.addListener(() {
      print(_animation.value);
      setState(() {});
    });
    _animationController.forward();
    _animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _animationController.reverse();
      } else if (status == AnimationStatus.dismissed) {
        _animationController.forward();
      }
    });
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
        title: const Text("Size Transistion"),
      ),
      body: _body(),
    );
  }

  Widget _body() {
    return Center(
        child: Container(
      width: _animation.value,
      height: _animation.value,
      color: Colors.red,
    ));
  }
}
