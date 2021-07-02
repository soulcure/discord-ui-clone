import 'dart:ui';
import 'package:discord_ui_clone/utils/event_bus.dart';
import 'package:discord_ui_clone/utils/github_repo.dart';
import 'package:discord_ui_clone/utils/http.dart';
import 'package:flutter/material.dart';

class LeftScreen extends StatelessWidget {
  test() async {
    List<GithubRepo> test = await HttpClient().getGitHub();

    test.forEach((element) => print("yao e=$element"));
    print(test);
  }

  @override
  Widget build(BuildContext context) {
    print("build left");

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(color: Colors.red),
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(50),
            ),
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
              child: Text("test"),
              onPressed: () {
                test();
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
                ElevatedButton(
                  child: Text("RollTo 10"),
                  onPressed: () {
                    Event.eventBus.fire(InnerDrawerStatus(0));
                    Event.eventBus.fire(ListPositon(0, 10));
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
                ElevatedButton(
                  child: Text("RollTo 5000"),
                  onPressed: () {
                    Event.eventBus.fire(InnerDrawerStatus(0));
                    Event.eventBus.fire(ListPositon(0, 5000));
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
                SizedBox(width: 2, height: 10),
                ElevatedButton(
                  child: Text("JumpTo 5"),
                  onPressed: () {
                    Event.eventBus.fire(InnerDrawerStatus(0));
                    Event.eventBus.fire(ListPositon(1, 5));
                  },
                ),
                ElevatedButton(
                  child: Text("JumpTo 10"),
                  onPressed: () {
                    Event.eventBus.fire(InnerDrawerStatus(0));
                    Event.eventBus.fire(ListPositon(1, 10));
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
                  child: Text("JumpTo 1000"),
                  onPressed: () {
                    Event.eventBus.fire(InnerDrawerStatus(0));
                    Event.eventBus.fire(ListPositon(1, 1000));
                  },
                ),
                SizedBox(width: 2, height: 10),
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
    );
  }
}
