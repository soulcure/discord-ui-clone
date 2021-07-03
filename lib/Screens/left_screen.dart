import 'dart:ui';
import 'package:discord_ui_clone/utils/event_bus.dart';
import 'package:discord_ui_clone/utils/github_repo.dart';
import 'package:discord_ui_clone/utils/http.dart';
import 'package:discord_ui_clone/widgets/guild_list.dart';
import 'package:flutter/material.dart';

class LeftScreen extends StatelessWidget {
  testCompute() async {
    List<GithubRepo> test = await HttpClient().getGitHub1();

    test.forEach((element) => print("yao e=$element"));
    print(test);
  }

  testMain() async {
    List<GithubRepo> test = await HttpClient().getGitHub2();

    test.forEach((element) => print("yao e=$element"));
    print(test);
  }

  @override
  Widget build(BuildContext context) {
    print("build left");
    return Container(
      child: Row(
        children: <Widget>[
          Expanded(
            child: GuildListView(),
            flex: 1,
          ),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.blueGrey,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(5.0),
                      topRight: Radius.circular(5.0))),
              child: Column(
                children: <Widget>[
                  ListTile(
                    onTap: () => print("Dashboard"),
                    title: Text(
                      "Dashboard",
                      style: TextStyle(color: Colors.white, fontSize: 14),
                    ),
                    leading: Icon(
                      Icons.dashboard,
                      color: Colors.white,
                      size: 22,
                    ),
                  ),
                  ListTile(
                    title: Text(
                      "Nametag",
                      style: TextStyle(fontSize: 14),
                    ),
                    leading: Icon(
                      Icons.rounded_corner,
                      size: 22,
                    ),
                  ),
                  ListTile(
                    title: Text(
                      "Favorite",
                      style: TextStyle(fontSize: 14),
                    ),
                    leading: Icon(
                      Icons.bookmark_border,
                      size: 22,
                    ),
                  ),
                  ListTile(
                    title: Text(
                      "Close Friends",
                      style: TextStyle(fontSize: 14),
                    ),
                    leading: Icon(
                      Icons.list,
                      size: 22,
                    ),
                  ),
                  ElevatedButton(
                    child: Text("test compute"),
                    onPressed: () {
                      testCompute();
                    },
                  ),
                  ElevatedButton(
                    child: Text("test main"),
                    onPressed: () {
                      testMain();
                    },
                  ),
                  Row(
                    children: [
                      ElevatedButton(
                        child: Text("RollTo 0"),
                        onPressed: () {
                          Event.eventBus.fire(InnerDrawerStatus(0));
                          Event.eventBus.fire(ListPositon(0, 0));
                        },
                      ),
                      ElevatedButton(
                        child: Text("RollTo 5"),
                        onPressed: () {
                          Event.eventBus.fire(InnerDrawerStatus(0));
                          Event.eventBus.fire(ListPositon(0, 5));
                        },
                      ),
                    ],
                    // mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    // mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                  ),
                  Row(
                    children: [
                      ElevatedButton(
                        child: Text("RollTo 100"),
                        onPressed: () {
                          Event.eventBus.fire(InnerDrawerStatus(0));
                          Event.eventBus.fire(ListPositon(0, 100));
                        },
                      ),
                      ElevatedButton(
                        child: Text("RollTo 1000"),
                        onPressed: () {
                          Event.eventBus.fire(InnerDrawerStatus(0));
                          Event.eventBus.fire(ListPositon(0, 1000));
                        },
                      ),
                    ],
                    // mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    // mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                  ),
                  Row(
                    children: [
                      ElevatedButton(
                        child: Text("RollTo 100"),
                        onPressed: () {
                          Event.eventBus.fire(InnerDrawerStatus(0));
                          Event.eventBus.fire(ListPositon(0, 100));
                        },
                      ),
                      ElevatedButton(
                        child: Text("RollTo 1000"),
                        onPressed: () {
                          Event.eventBus.fire(InnerDrawerStatus(0));
                          Event.eventBus.fire(ListPositon(0, 1000));
                        },
                      ),
                    ],
                    // mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    // mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                  ),
                  Row(
                    children: [
                      ElevatedButton(
                        child: Text("JumpTo 0"),
                        onPressed: () {
                          Event.eventBus.fire(InnerDrawerStatus(0));
                          Event.eventBus.fire(ListPositon(1, 0));
                        },
                      ),
                      ElevatedButton(
                        child: Text("JumpTo 5"),
                        onPressed: () {
                          Event.eventBus.fire(InnerDrawerStatus(0));
                          Event.eventBus.fire(ListPositon(1, 5));
                        },
                      ),
                    ],
                    // mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    // mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                  ),
                  Row(
                    children: [
                      ElevatedButton(
                        child: Text("JumpTo 100"),
                        onPressed: () {
                          Event.eventBus.fire(InnerDrawerStatus(0));
                          Event.eventBus.fire(ListPositon(1, 100));
                        },
                      ),
                      ElevatedButton(
                        child: Text("JumpTo 5000"),
                        onPressed: () {
                          Event.eventBus.fire(InnerDrawerStatus(0));
                          Event.eventBus.fire(ListPositon(1, 5000));
                        },
                      ),
                    ],
                    // mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    // mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                  ),
                  Row(
                    children: [
                      ElevatedButton(
                        child: Text("JumpTo 1000"),
                        onPressed: () {
                          Event.eventBus.fire(InnerDrawerStatus(0));
                          Event.eventBus.fire(ListPositon(1, 1000));
                        },
                      ),
                      ElevatedButton(
                        child: Text("JumpTo 5000"),
                        onPressed: () {
                          Event.eventBus.fire(InnerDrawerStatus(0));
                          Event.eventBus.fire(ListPositon(1, 5000));
                        },
                      ),
                    ],
                    // mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    // mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                  ),
                ],
              ),
            ),
            flex: 4,
          ),
        ],
      ),
    );
  }
}
