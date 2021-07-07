import 'package:cached_network_image/cached_network_image.dart';
import 'package:discord_ui_clone/widgets/guild/controllers/guild_controller.dart';
import 'package:discord_ui_clone/widgets/guild/model/github_user_bean.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class GuildListView extends StatefulWidget {
  GuildListView({Key key}) : super(key: key);

  @override
  _GuildListViewState createState() => _GuildListViewState();
}

class _GuildListViewState extends State<GuildListView> {
  final GuildController guildController = Get.put(GuildController());

  static const double size = 50;
  int selectedIndex;

  @override
  void initState() {
    guildController.reqGithubUserList();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<GuildController>(
      builder: (_c) => ListView.builder(
          padding: EdgeInsets.only(top: 5.0),
          itemCount: _c.guildList.length,
          itemBuilder: (context, index) {
            final Githubuserbean item = _c.guildList[index];
            return GestureDetector(
              onTap: () {
                setState(() {
                  selectedIndex = index;
                });
              },
              child: Container(
                width: size,
                height: size,
                padding: EdgeInsets.only(top: 5.0),
                decoration: selectedIndex == index
                    ? BoxDecoration(
                        border: Border.all(width: 5, color: Colors.blue),
                        borderRadius: BorderRadius.circular(size / 2))
                    : null,
                child: ClipOval(
                  child: CachedNetworkImage(
                    imageUrl: item.avatarUrl,
                    placeholder: (context, url) {
                      return Center(
                        widthFactor: 10,
                        heightFactor: 10,
                        child: CircularProgressIndicator(),
                      );
                    },
                    errorWidget: (context, url, error) => Icon(Icons.error),
                  ),
                ),
              ),
            );
          }),
    );
  }
}
