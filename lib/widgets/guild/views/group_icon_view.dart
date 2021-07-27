import 'package:discord_ui_clone/widgets/group_chat_icon.dart';
import 'package:discord_ui_clone/widgets/guild/controllers/guild_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class GroupIconView extends StatefulWidget {
  GroupIconView({Key key}) : super(key: key);

  @override
  _GroupIconViewState createState() => _GroupIconViewState();
}

class _GroupIconViewState extends State<GroupIconView> {
  final GuildController guildController = Get.put(GuildController());

  @override
  void initState() {
    guildController.reqGithubUserGrid();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<GuildController>(
      builder: (_c) => WeChatGroupChatIcon(avatars: _c.avatars),
    );
  }
}
