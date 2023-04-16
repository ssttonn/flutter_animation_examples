import 'dart:math';

import 'package:flutter/material.dart';

class PageModel {
  final int id;
  double zIndex;
  final Widget? child;

  PageModel({required this.id, this.zIndex = 0.0, this.child});

  PageModel copyWith({Widget? child}) {
    return PageModel(id: id, zIndex: zIndex, child: child ?? this.child);
  }
}

abstract class OverlappedPageControllerDelegate {
  void onGotoNewPage({required int pageIndex, Curve? curve, Duration? duration});
}

class OverlappedPageController {
  set delegate(OverlappedPageControllerDelegate delegate) {
    _delegate = delegate;
  }

  OverlappedPageControllerDelegate? _delegate;

  int currentPageIndex = 0;

  OverlappedPageController({int initialPageIndex = 0}) {
    currentPageIndex = initialPageIndex;
  }

  void onPageChanged(int index) {
    currentPageIndex = index;
  }

  void gotoPage(int pageIndex, {Curve? curve, Duration? duration}) {
    currentPageIndex = pageIndex;
    _delegate?.onGotoNewPage(pageIndex: pageIndex);
  }
}

class OverlappedPageView extends StatefulWidget {
  final List<Widget> widgets;
  final Function(int index)? onPageTapped;
  final Function(int index)? onPageChanged;
  final bool shouldScrollToItemPositionWhenTapped;
  final double itemWidth;
  final double visibleFraction;
  final double scrollSensitivity;
  final int? limitItemOnEachSide;
  final double scaleFactor;
  final double opacityFactor;
  final OverlappedPageController? controller;
  const OverlappedPageView(
      {super.key,
      this.onPageTapped,
      this.onPageChanged,
      this.controller,
      this.opacityFactor = 1,
      this.widgets = const [],
      this.shouldScrollToItemPositionWhenTapped = true,
      required this.itemWidth,
      this.visibleFraction = 1,
      this.limitItemOnEachSide,
      this.scrollSensitivity = 0.01,
      this.scaleFactor = 1});

  @override
  State<OverlappedPageView> createState() => _OverlappedPageViewState();
}

class _OverlappedPageViewState extends State<OverlappedPageView> with TickerProviderStateMixin implements OverlappedPageControllerDelegate {
  double _currentIndex = 0;
  double maxWidth = 0;
  double maxHeight = 0;

  late Animation<double> _scrollAnimation;
  AnimationController? _scrollAnimationController;

  List<PageModel> _cards = [];

  @override
  void initState() {
    super.initState();
    if (widget.controller != null) {
      widget.controller!.delegate = this;
      _currentIndex = widget.controller?.currentPageIndex.toDouble() ?? 1;
    }

    _cards = List.generate(
      widget.widgets.length,
      (index) => PageModel(id: index, child: widget.widgets[index]),
    );
  }

  @override
  void dispose() {
    _scrollAnimationController?.dispose();
    super.dispose();
  }

  void _scrollToItemPosition({required double from, required double to, Curve? curve, Duration? duration}) {
    _scrollAnimationController = AnimationController(vsync: this, duration: duration ?? const Duration(milliseconds: 300));
    _scrollAnimation = Tween<double>(begin: from, end: to).animate(CurvedAnimation(parent: _scrollAnimationController!, curve: curve ?? Curves.easeInOut));
    _scrollAnimationController?.addListener(() {
      setState(() {
        _currentIndex = _scrollAnimation.value;
      });
      widget.onPageChanged?.call(_currentIndex.round());
    });
    _scrollAnimationController?.forward();
  }

  double _calculateCardPosition(int index) {
    final double centerOffset = maxWidth / 2;

    // Calculate the x-position of the card in the center
    final double middleCardLeftEdgePosition = centerOffset - (widget.itemWidth / 2);

    // Calculate the offset from the center card
    final indexOffset = _currentIndex - index;

    if (indexOffset == 0) {
      // If the offset is 0, then the card is in the center and will be the selected car, so we return the base position
      return middleCardLeftEdgePosition;
    } else {
      if (indexOffset > 0) {
        // Calculate the left cards positions when scrolling to the left
        return middleCardLeftEdgePosition - widget.itemWidth * indexOffset.abs() * widget.visibleFraction;
      } else {
        // Calculate the right cards positions when scrolling to the right
        return middleCardLeftEdgePosition + widget.itemWidth * indexOffset.abs() * widget.visibleFraction;
      }
    }
  }

  double _calculateOpacity(int index) {
    final indexOffset = _currentIndex - index;
    // Calculate the offset from the center card
    return pow(widget.opacityFactor, indexOffset.abs()).toDouble();
  }

  Matrix4 _calculateTransformMatrix4(int index) {
    final indexOffset = _currentIndex - index;

    var transform = Matrix4.identity();
    if (_currentIndex != index) {
      transform.scale(pow(widget.scaleFactor, indexOffset.abs()));
    }
    return transform;
  }

  Widget _buildItem(PageModel item) {
    final int index = item.id;
    final position = _calculateCardPosition(index);

    return Positioned(
      key: Key(index.toString()),
      left: position,
      child: AnimatedOpacity(
        duration: const Duration(milliseconds: 100),
        opacity: _calculateOpacity(index),
        child: GestureDetector(
          onTap: () {
            if (_currentIndex != index && widget.shouldScrollToItemPositionWhenTapped) {
              _scrollToItemPosition(from: _currentIndex, to: index.toDouble());
            }
            widget.onPageTapped?.call(index);
          },
          child: Transform(
            transform: _calculateTransformMatrix4(index),
            alignment: FractionalOffset.center,
            child: SizedBox(width: widget.itemWidth, height: maxHeight, child: item.child!),
          ),
        ),
      ),
    );
  }

  List<Widget> _sortItems(List<PageModel> widgets) {
    _cards = widgets;
    for (int i = 0; i < _cards.length; i++) {
      if (_cards[i].id == _currentIndex) {
        _cards[i].zIndex = _cards.length.toDouble();
      } else if (_cards[i].id < _currentIndex) {
        _cards[i].zIndex = _cards[i].id.toDouble();
      } else {
        _cards[i].zIndex = _cards.length.toDouble() - _cards[i].id.toDouble();
      }
    }
    _cards.sort((a, b) => a.zIndex.compareTo(b.zIndex));
    return _cards.map((e) {
      double indexOffset = (_currentIndex - e.id).abs();

      if (widget.limitItemOnEachSide == null) {
        return _buildItem(e);
      }

      if (indexOffset >= 0 && indexOffset <= widget.limitItemOnEachSide!) {
        return _buildItem(e);
      } else {
        return Container();
      }
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      maxWidth = constraints.maxWidth;
      maxHeight = constraints.maxHeight;
      return GestureDetector(
          onPanDown: (details) {
            // TODO: Implement pan down function here
          },
          onPanUpdate: (details) {
            setState(() {
              _currentIndex = _currentIndex - details.delta.dx * widget.scrollSensitivity;
            });
          },
          onPanEnd: (details) {
            _scrollToItemPosition(from: _currentIndex, to: _currentIndex.round().toDouble(), duration: const Duration(milliseconds: 300));
          },
          child: Stack(alignment: Alignment.center, children: _sortItems(_cards)));
    });
  }

  @override
  void onGotoNewPage({required int pageIndex, Curve? curve, Duration? duration}) {
    widget.onPageTapped?.call(pageIndex);

    // Check if user tapped on the same page
    if (_currentIndex == pageIndex) return;

    _scrollToItemPosition(from: _currentIndex, to: pageIndex.toDouble(), curve: curve, duration: duration);
  }
}
