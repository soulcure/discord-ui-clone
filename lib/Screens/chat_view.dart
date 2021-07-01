// Copyright 2019 The Fuchsia Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:async';
import 'dart:math';
import 'package:discord_ui_clone/utils/event_bus.dart';
import 'package:flutter/material.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

const numberOfItems = 5001;
const minItemHeight = 20.0;
const maxItemHeight = 150.0;
const scrollDuration = Duration(seconds: 2);

const randomMax = 1 << 32;

/// Example widget that uses [ScrollablePositionedList].
///
/// Shows a [ScrollablePositionedList] along with the following controls:
///   - Buttons to jump or scroll to certain items in the list.
///   - Slider to control the alignment of the items being scrolled or jumped
///   to.
///   - A checkbox to reverse the list.
///
/// If the device this example is being used on is in portrait mode, the list
/// will be vertically scrollable, and if the device is in landscape mode, the
/// list will be horizontally scrollable.
class ScrollablePositionedListPage extends StatefulWidget {
  final int defaultPosition;

  ScrollablePositionedListPage({Key key, this.defaultPosition = 0})
      : super(key: key);
  @override
  _ScrollablePositionedListPageState createState() =>
      _ScrollablePositionedListPageState();
}

class _ScrollablePositionedListPageState
    extends State<ScrollablePositionedListPage> {
  /// Controller to scroll or jump to a particular item.
  final ItemScrollController itemScrollController = ItemScrollController();

  /// Listener that reports the position of items when the list is scrolled.
  final ItemPositionsListener itemPositionsListener =
      ItemPositionsListener.create();
  List<double> itemHeights;
  List<Color> itemColors;
  bool reversed = false;
  StreamSubscription _subscription;

  /// The alignment to be used next time the user scrolls or jumps to an item.
  double alignment = 0;

  @override
  void initState() {
    _subscription = Event.eventBus.on<ListPositon>().listen((event) {
      // Print the runtime type. Such a set up could be used for logging.
      if (event.type == 0) {
        scrollTo(event.positon);
      } else {
        jumpTo(event.positon);
      }
    });

    WidgetsBinding.instance.addPostFrameCallback(
        (_) => itemScrollController.jumpTo(index: 50, alignment: alignment));

    final heightGenerator = Random(328902348);
    final colorGenerator = Random(42490823);
    itemHeights = List<double>.generate(
        numberOfItems,
        (int _) =>
            heightGenerator.nextDouble() * (maxItemHeight - minItemHeight) +
            minItemHeight);
    itemColors = List<Color>.generate(numberOfItems,
        (int _) => Color(colorGenerator.nextInt(randomMax)).withOpacity(1));

    super.initState();
  }

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Material(
        child: OrientationBuilder(
          builder: (context, orientation) => Column(
            children: <Widget>[
              Expanded(
                child: list(orientation),
              ),
            ],
          ),
        ),
      );

  Widget list(Orientation orientation) => ScrollablePositionedList.builder(
        itemCount: numberOfItems,
        itemBuilder: (context, index) => item(index, orientation),
        itemScrollController: itemScrollController,
        itemPositionsListener: itemPositionsListener,
        reverse: reversed,
        scrollDirection: orientation == Orientation.portrait
            ? Axis.vertical
            : Axis.horizontal,
      );

  void scrollTo(int index) => itemScrollController.scrollTo(
      index: index,
      duration: scrollDuration,
      curve: Curves.easeInOutCubic,
      alignment: alignment);

  void jumpTo(int index) =>
      itemScrollController.jumpTo(index: index, alignment: alignment);

  /// Generate item number [i].
  Widget item(int i, Orientation orientation) {
    debugPrint("yao build listview index=$i");
    return SizedBox(
      height: orientation == Orientation.portrait ? itemHeights[i] : null,
      width: orientation == Orientation.landscape ? itemHeights[i] : null,
      child: Container(
        color: itemColors[i],
        child: Center(
          child: Text('Item $i'),
        ),
      ),
    );
  }
}
