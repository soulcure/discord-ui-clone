import 'package:flutter/material.dart';

import 'scroll_app_bar_controller.dart';

class ScrollFlexibleWidget extends StatefulWidget {
  const ScrollFlexibleWidget({this.controller, this.flexibleSpace, Key key})
      : super(key: key);

  final ScrollController controller;

  final Widget flexibleSpace;

  @override
  _ScrollFlexibleWidgetState createState() => _ScrollFlexibleWidgetState();
}

class _ScrollFlexibleWidgetState extends State<ScrollFlexibleWidget> {
  @override
  void didUpdateWidget(covariant ScrollFlexibleWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<double>(
      valueListenable: widget.controller.appBar.heightNotifier,
      builder: _height,
      child: widget.flexibleSpace,
    );
  }

  Widget _height(BuildContext context, double height, Widget child) {
    return _align(height, child);
  }

  Widget _align(double heightFactor, Widget child) {
    return Align(
      alignment: const Alignment(0, 1),
      heightFactor: heightFactor,
      child: _elevation(heightFactor, child),
    );
  }

  Widget _elevation(double heightFactor, Widget child) {
    return Material(
      elevation: 4,
      child: _opacity(heightFactor, child),
    );
  }

  Widget _opacity(double heightFactor, Widget child) {
    return Opacity(
      opacity: const Interval(
        0.5,
        1,
        curve: Curves.fastOutSlowIn,
      ).transform(heightFactor),
      child: child,
    );
  }
}
