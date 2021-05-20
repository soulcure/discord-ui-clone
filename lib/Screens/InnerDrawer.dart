import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

/// Signature for the callback that's called when a [InnerDrawer] is
/// opened or closed.
typedef InnerDrawerCallback = void Function(bool isOpened);

/// Signature for when a pointer that is in contact with the screen and moves to the right or left
/// values between 1 and 0
typedef InnerDragUpdateCallback = void Function(
    double value, InnerDrawerDirection direction);

/// The possible position of a [InnerDrawer].
enum InnerDrawerDirection {
  start,
  end,
}

//width before initState
const double _kWidth = 400;
const double _kMinFlingVelocity = 365.0;
const double _offset = 0.8;
const Duration _kBaseSettleDuration = Duration(milliseconds: 20);

class InnerDrawer extends StatefulWidget {
  const InnerDrawer(
      {GlobalKey key,
      this.leftChild,
      this.rightChild,
      this.scaffold,
      this.onTapClose = false,
      this.tapScaffoldEnabled = false,
      this.velocity = 20,
      this.innerDrawerCallback,
      this.onDragUpdate})
      : assert(leftChild != null || rightChild != null),
        super(key: key);

  /// Left child
  final Widget leftChild;

  /// Right child
  final Widget rightChild;

  /// A Scaffold is generally used but you are free to use other widgets
  final Widget scaffold;

  /// Closes the open scaffold
  final bool tapScaffoldEnabled;

  /// Closes the open scaffold
  final bool onTapClose;

  /// possibility to set the opening and closing velocity
  final double velocity;

  /// Optional callback that is called when a [InnerDrawer] is open or closed.
  final InnerDrawerCallback innerDrawerCallback;

  /// when a pointer that is in contact with the screen and moves to the right or left
  final InnerDragUpdateCallback onDragUpdate;

  @override
  InnerDrawerState createState() => InnerDrawerState();
}

class InnerDrawerState extends State<InnerDrawer>
    with SingleTickerProviderStateMixin {
  final GlobalKey _key = GlobalKey();

  double _initWidth = _kWidth;
  Orientation _orientation = Orientation.portrait;
  final FocusScopeNode _focusScopeNode = FocusScopeNode();
  bool _previouslyOpened = false;

  InnerDrawerDirection _position;
  AnimationController _controller;

  @override
  void initState() {
    _position = _leftChild != null
        ? InnerDrawerDirection.start
        : InnerDrawerDirection.end;

    _controller = AnimationController(
        value: 1, duration: _kBaseSettleDuration, vsync: this)
      ..addListener(_animationChanged)
      ..addStatusListener(_animationStatusChanged);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusScopeNode.dispose();
    super.dispose();
  }

  void _animationChanged() {
    setState(() {
      // The animation controller's state is our build state, and it changed already.
    });

    if (widget.onDragUpdate != null && _controller.value < 1) {
      widget.onDragUpdate((1 - _controller.value), _position);
    }
  }

  void _animationStatusChanged(AnimationStatus status) {
    final bool opened = _controller.value < 0.5 ? true : false;

    switch (status) {
      case AnimationStatus.reverse:
        break;
      case AnimationStatus.forward:
        break;
      case AnimationStatus.dismissed:
        if (_previouslyOpened != opened) {
          _previouslyOpened = opened;
          if (widget.innerDrawerCallback != null)
            widget.innerDrawerCallback(opened);
        }
        break;
      case AnimationStatus.completed:
        if (_previouslyOpened != opened) {
          _previouslyOpened = opened;
          if (widget.innerDrawerCallback != null)
            widget.innerDrawerCallback(opened);
        }
    }
  }

  void _handleDragDown(DragDownDetails details) {
    _controller.stop();
  }

  double get _width {
    return _initWidth;
  }

  double get _velocity {
    return widget.velocity;
  }

  /// get width of screen after initState
  void _updateWidth() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final RenderBox box = _key.currentContext.findRenderObject() as RenderBox;
      //final RenderBox box = context.findRenderObject();
      if (box != null &&
          box.hasSize &&
          box.size != null &&
          box.size.width > 300)
        setState(() {
          _initWidth = box.size.width;
        });
    });
  }

  void _move(DragUpdateDetails details) {
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

    switch (Directionality.of(context)) {
      case TextDirection.rtl:
        _controller.value -= delta + (delta * _offset);
        break;
      case TextDirection.ltr:
        _controller.value += delta + (delta * _offset);
        break;
    }

    final bool opened = _controller.value < 0.5 ? true : false;

    if (opened != _previouslyOpened && widget.innerDrawerCallback != null)
      widget.innerDrawerCallback(opened);

    _previouslyOpened = opened;
  }

  void _settle(DragEndDetails details) {
    if (_controller.isDismissed) return;
    if (details.velocity.pixelsPerSecond.dx.abs() >= _kMinFlingVelocity) {
      double visualVelocity =
          (details.velocity.pixelsPerSecond.dx + _velocity) / _width;
      switch (_position) {
        case InnerDrawerDirection.end:
          break;
        case InnerDrawerDirection.start:
          visualVelocity = -visualVelocity;
          break;
      }
      switch (Directionality.of(context)) {
        case TextDirection.rtl:
          _controller.fling(velocity: -visualVelocity);
          break;
        case TextDirection.ltr:
          _controller.fling(velocity: visualVelocity);
          break;
      }
    } else if (_controller.value < 0.5) {
      open();
    } else {
      close();
    }
  }

  void open({InnerDrawerDirection direction}) {
    if (direction != null) _position = direction;
    _controller.fling(velocity: -_velocity);
  }

  void close({InnerDrawerDirection direction}) {
    if (direction != null) _position = direction;
    _controller.fling(velocity: _velocity);
  }

  /// Open or Close InnerDrawer
  void toggle({InnerDrawerDirection direction}) {
    if (_previouslyOpened)
      close(direction: direction);
    else
      open(direction: direction);
  }

  /// Outer Alignment
  AlignmentDirectional get _drawerOuterAlignment {
    switch (_position) {
      case InnerDrawerDirection.start:
        return AlignmentDirectional.centerEnd;
      case InnerDrawerDirection.end:
        return AlignmentDirectional.centerStart;
    }
    return null;
  }

  /// Inner Alignment
  AlignmentDirectional get _drawerInnerAlignment {
    switch (_position) {
      case InnerDrawerDirection.start:
        return AlignmentDirectional.centerStart;
      case InnerDrawerDirection.end:
        return AlignmentDirectional.centerEnd;
    }
    return null;
  }

  /// Scaffold
  Widget get _scaffold {
    Widget container = Container(
        key: _key, //padding
        child: ClipRRect(
            borderRadius: BorderRadius.circular(10), child: widget.scaffold));
    return container;
  }

  Widget get _leftChild {
    return widget.leftChild;
  }

  Widget get _rightChild {
    return widget.rightChild;
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

  @override
  Widget build(BuildContext context) {
    /// initialize the correct width
    if (_initWidth == 400 ||
        MediaQuery.of(context).orientation != _orientation) {
      _updateWidth();
      _orientation = MediaQuery.of(context).orientation;
    }

    /// wFactor depends of offset and is used by the second Align that contains the Scaffold
    final double offset = 0.5 - _offset * 0.5;
    //NEW
    //final double offset = 1 - _offset * 1;
    final double wFactor = (_controller.value * (1 - offset)) + offset;

    return Container(
      child: Stack(
        alignment: _drawerInnerAlignment,
        children: <Widget>[
          _animatedChild(),
          GestureDetector(
            key: _key,
            onHorizontalDragDown: _handleDragDown,
            onHorizontalDragUpdate: _move,
            onHorizontalDragEnd: _settle,
            excludeFromSemantics: true, //语义树中排除一些手势
            child: Stack(
              children: <Widget>[
                Align(
                  alignment: _drawerOuterAlignment,
                  child: Align(
                      alignment: _drawerInnerAlignment,
                      widthFactor: wFactor,
                      child: _scaffold),
                ),
              ].where((a) => a != null).toList(),
            ),
          ),
        ],
      ),
    );
  }
}

///An immutable set of offset in each of the four cardinal directions.
class IDOffset {
  const IDOffset.horizontal(
    double horizontal,
  )   : left = horizontal,
        top = 0.0,
        right = horizontal,
        bottom = 0.0;

  const IDOffset.only({
    this.left = 0.0,
    this.top = 0.0,
    this.right = 0.0,
    this.bottom = 0.0,
  })  : assert(top >= 0.0 &&
            top <= 1.0 &&
            left >= 0.0 &&
            left <= 1.0 &&
            right >= 0.0 &&
            right <= 1.0 &&
            bottom >= 0.0 &&
            bottom <= 1.0),
        assert(top >= 0.0 && bottom == 0.0 || top == 0.0 && bottom >= 0.0);

  /// The offset from the left.
  final double left;

  /// The offset from the top.
  final double top;

  /// The offset from the right.
  final double right;

  /// The offset from the bottom.
  final double bottom;
}
