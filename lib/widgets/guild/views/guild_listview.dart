import 'package:cached_network_image/cached_network_image.dart';
import 'package:discord_ui_clone/widgets/guild/controllers/guild_controller.dart';
import 'package:discord_ui_clone/widgets/guild/model/github_user_bean.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class GuildListView extends StatelessWidget {
  final GuildController guildController = Get.put(GuildController());

  GuildListView({Key key}) : super(key: key) {
    guildController.reqGithubUserList();
  }

  //static const double size = 40;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<GuildController>(
      builder: (_c) => ListView.builder(
          padding: const EdgeInsets.only(top: 5),
          itemCount: _c.guildList.length,
          itemBuilder: (context, index) {
            final Githubuserbean item = _c.guildList[index];
            return GestureDetector(
              onTap: () {
                _c.select(index);
              },
              child: Padding(
                padding: const EdgeInsets.all(2),
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    final double width = constraints.constrainWidth();
                    return Obx(() => AnimatedContainer(
                          duration: const Duration(milliseconds: 20),
                          decoration: _c.selectedIndex.value == index
                              ? BoxDecoration(
                                  border:
                                      Border.all(width: 2, color: Colors.blue),
                                  borderRadius:
                                      BorderRadius.circular(width / 2))
                              : null,
                          child: ClipOval(
                            child: CachedNetworkImage(
                              imageUrl: item.avatarUrl,
                              placeholder: (context, url) {
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              },
                              errorWidget: (context, url, error) =>
                                  const Icon(Icons.error),
                            ),
                          ),
                        ));
                  },
                ),
              ),
            );
          }),
    );
  }
}
