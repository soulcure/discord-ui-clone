import 'package:discord_ui_clone/widgets/guild/controllers/guild_controller.dart';
import 'package:get/get.dart';

class GuildBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<GuildController>(() => GuildController());
  }
}
