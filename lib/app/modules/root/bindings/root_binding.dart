import 'package:discord_ui_clone/account/account_controller.dart';
import 'package:discord_ui_clone/app/modules/home/controllers/home_controller.dart';
import 'package:discord_ui_clone/app/modules/root/controllers/root_controller.dart';
import 'package:get/get.dart';

class RootBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RootController>(() => RootController());
    Get.lazyPut<HomeController>(() => HomeController());
    Get.lazyPut<AccountController>(() => AccountController());
  }
}
