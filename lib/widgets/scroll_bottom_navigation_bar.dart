import 'dart:async';

import 'package:discord_ui_clone/utils/event_bus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class ScrollBottomNavigationBar extends StatefulWidget {
  final List<BottomNavigationBarItem> items;
  final ValueChanged<int> onTap;
  final int currentIndex;
  final double elevation;
  final BottomNavigationBarType type;
  final Color fixedColor;
  final Color backgroundColor;
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
  final MouseCursor mouseCursor;

  ScrollBottomNavigationBar({
    Key key,
    @required this.items,
    this.onTap,
    this.currentIndex = 0,
    this.elevation,
    this.type,
    this.fixedColor,
    this.backgroundColor,
    this.iconSize = 24.0,
    this.selectedItemColor,
    this.unselectedItemColor,
    this.selectedIconTheme,
    this.unselectedIconTheme,
    this.selectedFontSize = 14.0,
    this.unselectedFontSize = 12.0,
    this.selectedLabelStyle,
    this.unselectedLabelStyle,
    this.showSelectedLabels,
    this.showUnselectedLabels,
    this.mouseCursor,
  }) : super(key: key);

  @override
  ScrollBottomNavigationBarState createState() =>
      ScrollBottomNavigationBarState();
}

class ScrollBottomNavigationBarState extends State<ScrollBottomNavigationBar>
    with SingleTickerProviderStateMixin {
  Color backgroundColor;

  AnimationController _controller;
  StreamSubscription _subscription;

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

    _subscription = Event.eventBus.on<NavBarStatus>().listen((event) {
      // Print the runtime type. Such a set up could be used for logging.
      if (event.status == 0) {
        show();
      } else {
        hide();
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
    final value = 1 - _controller.value;

    return Align(
      heightFactor: value,
      alignment: Alignment(0, -1),
      child: Container(
        child: Opacity(
          opacity: value,
          child: BottomNavigationBar(
            items: widget.items,
            onTap: widget.onTap,
            currentIndex: widget.currentIndex,
            elevation: widget.elevation,
            type: widget.type,
            fixedColor: widget.fixedColor,
            backgroundColor: widget.backgroundColor,
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
            showUnselectedLabels: widget.showUnselectedLabels,
            mouseCursor: widget.mouseCursor,
          ),
        ),
      ),
    );
  }

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
}
