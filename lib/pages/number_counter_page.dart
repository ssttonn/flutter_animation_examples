import 'package:flutter/material.dart';

class NumberCounterPage extends StatelessWidget {
  const NumberCounterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: _body(),
    );
  }

  Widget _body() {
    return Center(
      child: NumberCounterWidget(
        10000,
        duration: const Duration(seconds: 10),
        onEnd: () {
          print("onEnd");
        },
      ),
    );
  }
}

class NumberCounterWidget extends StatelessWidget {
  final int number;
  final Duration? duration;
  final VoidCallback? onEnd;
  const NumberCounterWidget(this.number, {super.key, this.duration, this.onEnd});

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder(
        tween: IntTween(begin: 0, end: number),
        duration: duration ?? const Duration(seconds: 2),
        onEnd: onEnd,
        builder: (context, value, child) {
          return Text(value.toString());
        });
  }
}
