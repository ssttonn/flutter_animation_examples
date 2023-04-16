import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animation_examples/widgets/overlapped_page_view.dart';

class OverlappedExamplePage extends StatelessWidget {
  OverlappedExamplePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Overlapped example'),
      ),
      body: _body(),
    );
  }

  final controller = OverlappedPageController(initialPageIndex: 3);

  Widget _body() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        CupertinoButton(
            child: const Text("Jump to new page"),
            onPressed: () {
              controller.gotoPage(5);
            }),
        SizedBox(
          height: 50 * 4,
          child: OverlappedPageView(
            itemWidth: 150,
            visibleFraction: 0.7,
            scrollSensitivity: 0.02,
            scaleFactor: 0.8,
            opacityFactor: 0.6,
            onPageTapped: (index) {
              print("index: $index");
            },
            controller: controller,
            widgets: [Colors.amberAccent, Colors.blueAccent, Colors.greenAccent, Colors.black, Colors.yellowAccent]
                .map((e) => Container(
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.5),
                              spreadRadius: 1,
                              blurRadius: 5,
                              offset: const Offset(0, 3), // changes position of shadow
                            ),
                          ],
                          color: e),
                    ))
                .toList(),
          ),
        ),
      ],
    );
  }
}
