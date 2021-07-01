import 'dart:async';

import 'package:discord_ui_clone/utils/event_bus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

///tabbar 1 show  0 close
typedef InnerDrawerCallback = void Function(int value);

/// Signature for when a pointer that is in contact with the screen and moves to the right or left
/// values between 1 and 0
typedef InnerDragUpdateCallback = void Function(
    double value, InnerDrawerDirection direction);

/// The possible position of a [InnerDrawer].
enum InnerDrawerDirection {
  start,
  end,
}

///从 10%显示的地方开始
const double offset = 0.1;

///摔动速度识别定义
const double kMinFlingVelocity = 200;

///只有正负的区别
const double velocity = 20;

class InnerDrawer extends StatefulWidget {
  const InnerDrawer(
      {Key key,
      @required this.leftChild,
      @required this.rightChild,
      @required this.scaffold})
      : super(key: key);

  /// Left child
  final Widget leftChild;

  /// Right child
  final Widget rightChild;

  /// A Scaffold is generally used but you are free to use other widgets
  final Widget scaffold;

  @override
  InnerDrawerState createState() => InnerDrawerState();
}

class InnerDrawerState extends State<InnerDrawer>
    with SingleTickerProviderStateMixin {
  ///屏幕宽度
  double _initWidth = 0;

  InnerDrawerDirection _position = InnerDrawerDirection.start;

  AnimationController _controller;
  StreamSubscription _subscription;

  bool isRightToLeft;
  bool isLeftToRight;
  bool isCallBack;

  void show() {
    Event.eventBus.fire(NavBarStatus(0));
  }

  void hide() {
    Event.eventBus.fire(NavBarStatus(1));
  }

  void open({InnerDrawerDirection direction}) {
    if (direction != null) _position = direction;
    _controller.fling(velocity: -velocity);
  }

  void openLeft() {
    open(direction: InnerDrawerDirection.start);
  }

  void openRight() {
    open(direction: InnerDrawerDirection.end);
  }

  void close({InnerDrawerDirection direction}) {
    if (direction != null) _position = direction;
    _controller.fling(velocity: velocity);
  }

  @override
  void initState() {
    _controller = AnimationController(
        lowerBound: offset,
        upperBound: 1,
        duration: Duration(milliseconds: 20),
        vsync: this)
      ..addListener(_animationChanged)
      ..addStatusListener(_animationStatusChanged);

    _subscription = Event.eventBus.on<InnerDrawerStatus>().listen((event) {
      // Print the runtime type. Such a set up could be used for logging.
      if (event.status == 0) {
        close();
      } else {
        open();
      }
    });

    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    _subscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_initWidth == 0) {
      _initWidth = MediaQuery.of(context).size.width;
    }

    return Container(
      child: Stack(
        alignment: _drawerInnerAlignment,
        children: <Widget>[
          _animatedChild(),
          GestureDetector(
            onHorizontalDragDown: _handleDragDown,
            onHorizontalDragUpdate: _handleDragMove,
            onHorizontalDragEnd: _handleDragEnd,
            excludeFromSemantics: true, //语义树中排除一些手势
            child: Align(
              alignment: _drawerOuterAlignment,
              child: Align(
                  alignment: _drawerInnerAlignment,
                  widthFactor: _controller.value,
                  child: _scaffold),
            ),
          ),
        ],
      ),
    );
  }

  void _animationChanged() {
    setState(() {});
    if (!isCallBack) _callback();
  }

  void _animationStatusChanged(AnimationStatus status) {
    switch (status) {
      case AnimationStatus.reverse:
        if (_position == InnerDrawerDirection.start) {
          if (isLeftToRight) {
            return;
          }
          isRightToLeft = true;
        }
        break;
      case AnimationStatus.forward:
        if (_position == InnerDrawerDirection.start) {
          if (isRightToLeft) {
            return;
          }
          isLeftToRight = true;
        }
        break;
      case AnimationStatus.dismissed:
        show();
        isRightToLeft = false;
        isLeftToRight = false;
        isCallBack = false;
        break;
      case AnimationStatus.completed:
        hide();
        isRightToLeft = false;
        isLeftToRight = false;
        isCallBack = false;
        break;
    }
  }

  void _callback() {
    if (_position == InnerDrawerDirection.start) {
      if (isLeftToRight && _controller.value < 0.8) {
        show();
        isCallBack = true;
      } else if (isRightToLeft && _controller.value > 0.2) {
        hide();
        isCallBack = true;
      }
    }
  }

  void _handleDragDown(DragDownDetails details) {
    _controller.stop();
  }

  void _handleDragMove(DragUpdateDetails details) {
    double delta = details.primaryDelta / _width;

    if (delta > 0 && _controller.value == 1 && _leftChild != null)
      _position = InnerDrawerDirection.start;
    else if (delta < 0 && _controller.value == 1 && _rightChild != null)
      _position = InnerDrawerDirection.end;

    switch (_position) {
      case InnerDrawerDirection.end:
        break;
      case InnerDrawerDirection.start:
        delta = -delta;
        break;
    }

    _controller.value += delta;
  }

  void _handleDragEnd(DragEndDetails details) {
    if (_controller.isDismissed) return;
    if (details.velocity.pixelsPerSecond.dx.abs() >= kMinFlingVelocity) {
      double visualVelocity =
          (details.velocity.pixelsPerSecond.dx + velocity) / _width;

      if (_position == InnerDrawerDirection.start)
        visualVelocity = -visualVelocity;

      _controller.fling(velocity: visualVelocity);
    } else if (_controller.value < 0.5) {
      open();
    } else {
      close();
    }
  }

  double get _width {
    return _initWidth;
  }

  /// Outer Alignment
  AlignmentDirectional get _drawerOuterAlignment {
    if (_position == InnerDrawerDirection.start)
      return AlignmentDirectional.centerEnd;
    return AlignmentDirectional.centerStart;
  }

  /// Inner Alignment
  AlignmentDirectional get _drawerInnerAlignment {
    if (_position == InnerDrawerDirection.end)
      return AlignmentDirectional.centerEnd;
    return AlignmentDirectional.centerStart;
  }

  /// Scaffold
  Widget get _scaffold {
    return widget.scaffold;
  }

  Widget get _leftChild {
    Container child =
        Container(padding: EdgeInsets.only(right: 50), child: widget.leftChild);
    return child;
  }

  Widget get _rightChild {
    Container child =
        Container(padding: EdgeInsets.only(left: 50), child: widget.rightChild);
    return child;
  }

  /// return widget with specific animation
  Widget _animatedChild() {
    Widget child =
        _position == InnerDrawerDirection.start ? _leftChild : _rightChild;

    final Widget container = Container(
      width: _width,
      height: MediaQuery.of(context).size.height,
      child: child,
    );
    return container;
  }
}
