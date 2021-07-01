import 'package:discord_ui_clone/app/modules/contact/bindings/contact_binding.dart';
import 'package:discord_ui_clone/app/modules/contact/views/contact_view.dart';
import 'package:discord_ui_clone/app/modules/root/bindings/root_binding.dart';
import 'package:discord_ui_clone/app/modules/root/views/root_view.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const ROOT = Routes.ROOT;
  static const HOME = Routes.HOME;

  static final routes = [
    GetPage(
      name: _Paths.ROOT,
      page: () => RootView(),
      binding: RootBinding(),
    ),
    GetPage(
      name: _Paths.HOME,
      page: () => HomeView(),
      binding: ContactBinding(),
    ),
  ];
}
