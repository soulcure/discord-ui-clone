import 'package:discord_ui_clone/app/modules/contact/bindings/contact_binding.dart';
import 'package:discord_ui_clone/app/modules/contact/views/contact_view.dart';
import 'package:discord_ui_clone/app/modules/root/bindings/home_binding.dart';
import 'package:discord_ui_clone/app/modules/root/views/home_view.dart';
import 'package:get/get.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const HOME = Routes.HOME;
  static const CONTACT = Routes.CONTACT;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.CONTACT,
      page: () => ContactView(),
      binding: ContactBinding(),
    ),
  ];
}
