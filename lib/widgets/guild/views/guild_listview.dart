import 'package:cached_network_image/cached_network_image.dart';
import 'package:discord_ui_clone/widgets/guild/controllers/guild_controller.dart';
import 'package:discord_ui_clone/widgets/guild/model/github_user_bean.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class GuildListView extends StatefulWidget {
  const GuildListView({Key key}) : super(key: key);

  @override
  _GuildListViewState createState() => _GuildListViewState();
}

class _GuildListViewState extends State<GuildListView> {
  final GuildController guildController = Get.put(GuildController());

  //static const double size = 40;
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
      builder: (GuildController _c) => ListView.builder(
          padding: const EdgeInsets.only(top: 5.0),
          itemCount: _c.guildList.length,
          itemBuilder: (BuildContext context, int index) {
            final Githubuserbean item = _c.guildList[index];
            return GestureDetector(
              onTap: () {
                setState(() {
                  selectedIndex = index;
                });
              },
              child: Padding(
                padding: const EdgeInsets.all(2.0),
                child: LayoutBuilder(
                  builder: (BuildContext context, BoxConstraints constraints) {
                    final double width = constraints.constrainWidth();
                    return AnimatedContainer(
                      duration: const Duration(milliseconds: 20),
                      decoration: selectedIndex == index
                          ? BoxDecoration(
                              border: Border.all(width: 2, color: Colors.blue),
                              borderRadius: BorderRadius.circular(width / 2))
                          : null,
                      child: ClipOval(
                        child: CachedNetworkImage(
                          imageUrl: item.avatarUrl,
                          placeholder: (BuildContext context, String url) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          },
                          errorWidget: (BuildContext context, String url,
                                  dynamic error) =>
                              const Icon(Icons.error),
                        ),
                      ),
                    );
                  },
                ),
              ),
            );
          }),
    );
  }
}
