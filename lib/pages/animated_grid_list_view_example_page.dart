import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class AnimatedListGridViewExamplePage extends StatefulWidget {
  const AnimatedListGridViewExamplePage({super.key});

  @override
  State<AnimatedListGridViewExamplePage> createState() => _AnimatedListGridViewExamplePageState();
}

class _AnimatedListGridViewExamplePageState extends State<AnimatedListGridViewExamplePage> {
  List<String> _items = ["A", "B"];
  final GlobalKey<AnimatedListState> _globalKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: _body(),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FloatingActionButton(
            child: Icon(Icons.clear),
            onPressed: () {
              _globalKey.currentState!.removeItem(_items.length - 1, (context, animation) => SizedBox.shrink());

              setState(() {
                _items.removeLast();
              });
            },
          ),
          FloatingActionButton(
            child: Icon(Icons.plus_one),
            onPressed: () {
              _globalKey.currentState!.insertItem(_items.length - 1);

              setState(() {
                _items.add("C");
              });
            },
          ),
        ],
      ),
    );
  }

  Widget _body() {
    return AnimatedList(
        initialItemCount: _items.length,
        key: _globalKey,
        itemBuilder: (context, index, animation) {
          return SlideTransition(
            position: animation.drive(Tween(begin: Offset(1, 0), end: Offset.zero)),
            child: Container(
              margin: const EdgeInsets.all(10),
              color: Color.fromARGB(255, 163, 196, 223),
              height: 100,
              child: Text(_items[index]),
            ),
          );
        });
  }
}
