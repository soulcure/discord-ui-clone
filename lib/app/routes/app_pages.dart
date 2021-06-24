import 'package:discord_ui_clone/app/modules/root/bindings/root_binding.dart';
import 'package:discord_ui_clone/app/modules/root/views/root_view.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.HOME;

  static final routes = [
    // GetPage(
    //   name: _Paths.HOME,
    //   page: () => HomeView(),
    //   binding: HomeBinding(),
    // ),
    GetPage(
      name: _Paths.ROOT,
      page: () => RootView(),
      binding: RootBinding(),
    ),
  ];
}
