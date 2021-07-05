import 'package:discord_ui_clone/utils/http.dart';
import 'package:discord_ui_clone/widgets/guild/model/github_user_bean.dart';
import 'package:get/get.dart';

class GuildController extends GetxController {
  List<Githubuserbean> _guildList;

  get guildList => _guildList == null ? [] : _guildList;

  Future<void> reqGithubUserList() async {
    _guildList = await HttpClient().getGitHubUser();
    update();
  }
}
