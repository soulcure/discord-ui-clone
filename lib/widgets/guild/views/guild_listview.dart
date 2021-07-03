import 'package:discord_ui_clone/widgets/guild/controllers/guild_controller.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class GuildListView extends StatelessWidget {
  GuildListView({Key key}) : super(key: key);

  final GuildController controller = Get.put(GuildController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<GuildController>(
      builder: (controller) {
        return ListView.builder(
            itemCount: controller.index,
            itemBuilder: (BuildContext context, int index) {
              return Text("index $index");
            });
      },
    );
  }
}
