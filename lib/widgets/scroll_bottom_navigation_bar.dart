import 'package:flutter/material.dart';

class ScrollBottomNavigationBar extends StatefulWidget {
  final List<BottomNavigationBarItem> items;
  final double elevation;
  final BottomNavigationBarType type;
  final Color fixedColor;
  final Color backgroundColor;
  final Gradient backgroundGradient;
  final MaterialType materialType;
  final double iconSize;
  final Color selectedItemColor;
  final Color unselectedItemColor;
  final IconThemeData selectedIconTheme;
  final IconThemeData unselectedIconTheme;
  final double selectedFontSize;
  final double unselectedFontSize;
  final TextStyle selectedLabelStyle;
  final TextStyle unselectedLabelStyle;
  final bool showSelectedLabels;
  final bool showUnselectedLabels;

  ScrollBottomNavigationBar({
    Key key,
    @required this.items,
    this.elevation = 8.0,
    this.type,
    this.fixedColor,
    this.backgroundColor = Colors.transparent,
    this.materialType,
    this.backgroundGradient,
    this.iconSize = 24.0,
    this.selectedItemColor,
    this.unselectedItemColor,
    this.selectedIconTheme = const IconThemeData(),
    this.unselectedIconTheme = const IconThemeData(),
    this.selectedFontSize = 14.0,
    this.unselectedFontSize = 12.0,
    this.selectedLabelStyle,
    this.unselectedLabelStyle,
    this.showSelectedLabels = true,
    this.showUnselectedLabels,
  }) : super(key: key);

  @override
  ScrollBottomNavigationBarState createState() =>
      ScrollBottomNavigationBarState();
}

class ScrollBottomNavigationBarState extends State<ScrollBottomNavigationBar>
    with SingleTickerProviderStateMixin {
  Color backgroundColor;

  /// Notifier of the active page index
  final tabNotifier = ValueNotifier<int>(0);

  AnimationController _controller;

  void show() {
    if (!_controller.isAnimating) {
      _controller.reverse();
    }
  }

  void hide() {
    if (!_controller.isAnimating) {
      _controller.forward();
    }
  }

  /// Set a new tab
  void setTab(int index) => tabNotifier.value = index;

  @override
  void initState() {
    _controller = AnimationController(
        vsync: this,
        lowerBound: 0,
        upperBound: 1,
        duration: Duration(milliseconds: 300))
      ..addListener(() {
        setState(() {
          // The animation controller's state is our build state, and it changed already.
        });
      });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.backgroundGradient == null) {
      backgroundColor = widget.backgroundColor ??
          Theme.of(context).canvasColor ??
          Colors.white;
    }

    return ValueListenableBuilder<int>(
      valueListenable: tabNotifier,
      builder: _tab,
    );
  }

  @override
  void dispose() {
    tabNotifier.dispose();
    _controller.dispose();
    super.dispose();
  }

  Widget _tab(BuildContext context, int index, Widget child) {
    Widget bottomNavigationBar = BottomNavigationBar(
      onTap: setTab,
      currentIndex: index,
      items: widget.items,
      elevation: 0.0,
      type: widget.type,
      fixedColor: widget.fixedColor,
      backgroundColor: Colors.transparent,
      iconSize: widget.iconSize,
      selectedItemColor: widget.selectedItemColor,
      unselectedItemColor: widget.unselectedItemColor,
      selectedIconTheme: widget.selectedIconTheme,
      unselectedIconTheme: widget.unselectedIconTheme,
      selectedFontSize: widget.selectedFontSize,
      unselectedFontSize: widget.unselectedFontSize,
      selectedLabelStyle: widget.selectedLabelStyle,
      unselectedLabelStyle: widget.unselectedLabelStyle,
      showSelectedLabels: widget.showSelectedLabels,
    );
    final value = 1 - _controller.value;

    return Align(
      heightFactor: value,
      alignment: Alignment(0, -1),
      child: Material(
        elevation: widget.elevation,
        type: widget.materialType != null
            ? widget.materialType
            : MaterialType.canvas,
        child: Container(
          decoration: BoxDecoration(
            color: backgroundColor,
            gradient: widget.backgroundGradient,
          ),
          child: Opacity(
            opacity: value,
            child: bottomNavigationBar,
          ),
        ),
      ),
    );
  }
}
