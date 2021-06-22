import 'package:discord_ui_clone/alerts/alerts_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AlertsPage extends GetView<AlertsController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: Text(
            "Alerts Page",
            style: TextStyle(fontSize: 20),
          ),
        ),
      ),
    );
  }
}
