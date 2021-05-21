import 'dart:async';

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

class ScrollBottomNavigationBarState extends State<ScrollBottomNavigationBar> {
  Widget bottomNavigationBar;
  Color backgroundColor;

  /// Notifier of the active page index
  final tabNotifier = ValueNotifier<int>(0);

  /// Notifier of the visible height factor of bar
  final heightNotifier = ValueNotifier<double>(1.0);

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
    heightNotifier.dispose();
    super.dispose();
  }

  double height = 56.0;

  void show() {
    const duration = const Duration(milliseconds: 40);
    Timer.periodic(duration, (timer) {
      switch (timer.tick) {
        case 1:
          heightNotifier.value = 0.1;
          break;
        case 2:
          heightNotifier.value = 0.2;
          break;
        case 3:
          heightNotifier.value = 0.3;
          break;
        case 4:
          heightNotifier.value = 0.4;
          break;
        case 5:
          heightNotifier.value = 0.5;
          break;
        case 6:
          heightNotifier.value = 0.6;
          break;
        case 7:
          heightNotifier.value = 0.7;
          break;
        case 8:
          heightNotifier.value = 0.8;
          break;
        case 9:
          heightNotifier.value = 0.9;
          break;
        case 9:
          heightNotifier.value = 1.0;
          timer.cancel();
          break;
      }
    });
  }

  void hide() {
    const duration = const Duration(milliseconds: 40);
    Timer.periodic(duration, (timer) {
      switch (timer.tick) {
        case 1:
          heightNotifier.value = 0.9;
          break;
        case 2:
          heightNotifier.value = 0.8;
          break;
        case 3:
          heightNotifier.value = 0.7;
          break;
        case 4:
          heightNotifier.value = 0.6;
          break;
        case 5:
          heightNotifier.value = 0.5;
          break;
        case 6:
          heightNotifier.value = 0.4;
          break;
        case 7:
          heightNotifier.value = 0.3;
          break;
        case 8:
          heightNotifier.value = 0.2;
          break;
        case 9:
          heightNotifier.value = 0.1;
          break;
        case 9:
          heightNotifier.value = 0.0;
          timer.cancel();
          break;
      }
    });
  }

  /// Set a new tab
  void setTab(int index) => tabNotifier.value = index;

  Widget _tab(BuildContext context, int index, Widget child) {
    bottomNavigationBar = BottomNavigationBar(
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

    return ValueListenableBuilder<double>(
      valueListenable: heightNotifier,
      builder: _height,
    );
  }

  Widget _height(BuildContext context, double height, Widget child) {
    return _align(height);
  }

  Widget _align(double heightFactor) {
    return Align(
      heightFactor: heightFactor,
      alignment: Alignment(0, -1),
      child: _elevation(heightFactor),
    );
  }

  Widget _elevation(double heightFactor) {
    return Material(
      elevation: widget.elevation,
      type: widget.materialType != null
          ? widget.materialType
          : MaterialType.canvas,
      child: _decoratedContainer(heightFactor),
    );
  }

  Widget _decoratedContainer(double heightFactor) {
    return Container(
      height: height,
      decoration: BoxDecoration(
        color: backgroundColor,
        gradient: widget.backgroundGradient,
      ),
      child: _opacity(heightFactor),
    );
  }

  Widget _opacity(double heightFactor) {
    return Opacity(
      opacity: heightFactor,
      child: bottomNavigationBar,
    );
  }
}
