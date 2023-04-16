import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animation_examples/pages/animated_grid_list_view_example_page.dart';
import 'package:flutter_animation_examples/pages/beam_clipper_page.dart';
import 'package:flutter_animation_examples/pages/number_counter_page.dart';
import 'package:flutter_animation_examples/pages/overlapped_example_page.dart';
import 'package:flutter_animation_examples/pages/rotation_transistion_page.dart';
import 'package:flutter_animation_examples/pages/scale_transastion_example_page.dart';
import 'package:flutter_animation_examples/pages/session_1_page.dart';
import 'package:flutter_animation_examples/pages/session_2_page.dart';
import 'package:flutter_animation_examples/pages/session_3_page.dart';
import 'package:flutter_animation_examples/pages/session_4_page.dart';
import 'package:flutter_animation_examples/pages/session_6_page.dart';
import 'package:flutter_animation_examples/pages/sine_wave_animation_page.dart';
import 'package:flutter_animation_examples/pages/size_transistion_page.dart';
import 'package:flutter_animation_examples/pages/tween_animation_builder_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Animation examples"),
        ),
        body: ListView(children: [
          const SizedBox(height: 10),
          _button("Session 1 page", onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (settings) => const Session1Page()));
          }),
          const SizedBox(
            height: 10,
          ),
          _button("Session 2 page", onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (settings) => const Session2Page()));
          }),
          const SizedBox(
            height: 10,
          ),
          _button("Session 3 page", onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (settings) => const Session3Page()));
          }),
          const SizedBox(
            height: 10,
          ),
          _button("Session 4 page", onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (settings) => const Session4Page()));
          }),
          const SizedBox(height: 10),
          _button("ScaleTransastion example page", onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (settings) => const ScaleTransistionExamplePage()));
          }),
          const SizedBox(height: 10),
          _button("Overlapped example page", onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (settings) => OverlappedExamplePage()));
          }),
          const SizedBox(height: 10),
          _button("Session 6 page", onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (settings) => const Session6Page()));
          }),
          const SizedBox(height: 10),
          _button("Animated Grid, List view page", onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (settings) => const AnimatedListGridViewExamplePage()));
          }),
          const SizedBox(height: 10),
          _button("SizeTransistion page", onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (settings) => const SizeTransistionPage()));
          }),
          const SizedBox(height: 10),
          _button("TweenAnimationBuilder page", onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (settings) => const TweenAnimationBuilderPage()));
          }),
          const SizedBox(height: 10),
          _button("RotationTransistion page", onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (settings) => const RotationTransistionPage()));
          }),
          const SizedBox(height: 10),
          _button("BeamClipper page", onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (settings) => const BeamClipperPage()));
          }),
          const SizedBox(height: 10),
          _button("NumberCounter page", onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (settings) => const NumberCounterPage()));
          }),
          const SizedBox(height: 10),
          _button("SineWaveAnimation page", onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (settings) => const SineWaveAnimationPage()));
          }),
        ]));
  }

  Widget _button(String title, {VoidCallback? onPressed}) {
    return CupertinoButton(
        onPressed: onPressed,
        padding: EdgeInsets.zero,
        child: Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(color: Colors.lightBlue, borderRadius: BorderRadius.circular(14)),
          child: Text(title, style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
        ));
  }
}
