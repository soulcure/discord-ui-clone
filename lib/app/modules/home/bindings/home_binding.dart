import 'package:discord_ui_clone/account/account_controller.dart';
import 'package:discord_ui_clone/app/modules/contact/controllers/contact_controller.dart';
import 'package:discord_ui_clone/app/modules/home/controllers/home_controller.dart';
import 'package:get/get.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(() => HomeController());
    Get.lazyPut<ContactController>(() => ContactController());
    Get.lazyPut<AccountController>(() => AccountController());
  }
}
