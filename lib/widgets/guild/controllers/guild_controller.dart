import 'package:discord_ui_clone/widgets/guild/model/guild_bean.dart';
import 'package:get/get.dart';

class GuildController extends GetxController {
  // List<GuildBean> guildList;
  int index = 1;

  // void reqGuild() {
  //   guildList = [];
  //   update();
  // }

  void reqIndex() {
    index++;
    update();
  }
}
