import 'package:flutter/material.dart';

class BeamClipperPage extends StatefulWidget {
  const BeamClipperPage({super.key});

  @override
  State<BeamClipperPage> createState() => _BeamClipperPageState();
}

class _BeamClipperPageState extends State<BeamClipperPage> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(vsync: this, duration: const Duration(seconds: 1));
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
        title: const Text("Beam Clipper"),
      ),
      body: BeamTransition(animation: _animationController),
    );
  }
}

class BeamTransition extends AnimatedWidget {
  const BeamTransition({super.key, required Animation<double> animation}) : super(listenable: animation);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 1000,
      decoration: BoxDecoration(
        gradient: RadialGradient(radius: 1.5, colors: const [
          Colors.yellow,
          Colors.transparent,
        ], stops: [
          0,
          (listenable as Animation<double>).value
        ]),
      ),
    );
  }

  Widget _body() {
    return Center(
      child: Container(
        width: 100,
        height: 100,
        color: Colors.red,
      ),
    );
  }
}

class BeamClipper extends CustomClipper<Path> {
  const BeamClipper();

  @override
  getClip(Size size) {
    return Path()
      ..lineTo(size.width / 2, size.height / 2)
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height)
      ..lineTo(size.width / 2, size.height / 2)
      ..close();
  }

  /// Return false always because we always clip the same area.
  @override
  bool shouldReclip(CustomClipper oldClipper) => false;
}
