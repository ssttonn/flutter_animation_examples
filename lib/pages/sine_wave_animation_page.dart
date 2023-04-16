import 'dart:math';

import 'package:flutter/material.dart';

class SineWaveAnimationPage extends StatelessWidget {
  const SineWaveAnimationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Sine Wave Animation"),
      ),
      body: _body(),
    );
  }

  Widget _body() {
    return Center(
      child: ClipPath(
        clipper: SineWaveClipper(),
        child: Container(
          height: 300,
          width: 300,
          color: Colors.blueAccent,
        ),
      ),
    );
  }
}

class SineWaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    for (var degree = 0; degree <= 360; degree++) {
      path.lineTo(size.width / 2 + 50 * sin((degree * pi * 2) / 360), size.height / 2 + 50 * cos((degree * pi * 2) / 360));
    }

    path.close();
    return path;
  }

  List<Offset> _points(Size size) {
    List<Offset> points = [];
    final amplitude = size.height / 2;
    for (var x = 0; x < size.width; x++) {
      final y = sin(x / 20) * amplitude;
      points.add(Offset(x.toDouble(), y));
      print("x: $x, y: $y");
    }
    return points;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}
