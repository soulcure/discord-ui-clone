import 'package:discord_ui_clone/utils/http.dart';
import 'package:discord_ui_clone/widgets/guild/model/github_user_bean.dart';
import 'package:get/get.dart';

class GuildController extends GetxController {
  List<Githubuserbean> _guildList;
  List<String> _avatars;

  get guildList => _guildList == null ? [] : _guildList;
  get avatars {
    if (_avatars == null) {
      return [];
    } else if (_avatars.length <= 9) {
      return _avatars;
    } else {
      //return _avatars.sublist(0, 9);
      return _avatars.sublist(0, 9);
    }
  }

  Future<void> reqGithubUserList() async {
    _guildList = await HttpClient().getGitHubUser();
    update();
  }

  Future<void> reqGithubUserGrid() async {
    _avatars = await HttpClient().getGitHubUserGrid();
    update();
  }
}
