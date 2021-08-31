import 'package:discord_ui_clone/utils/data_worker_lsolate.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'app/routes/app_pages.dart';
import 'themes/app_theme.dart';

void main() {
  DataWorkerIsolate();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: ThemeMode.system,
      //initialRoute: AppPages.HOME,
      initialRoute: AppPages.CONTACT,
      getPages: AppPages.routes,
    );
  }
}
