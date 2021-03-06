import 'package:discord_ui_clone/utils/http.dart';
import 'package:discord_ui_clone/widgets/guild/model/github_user_bean.dart';
import 'package:get/get.dart';

class GuildController extends GetxController {
  Rx<int> selectedIndex = Rx<int>(0);

  List<Githubuserbean> _guildList;
  List<String> _avatars;

  List<Githubuserbean> get guildList => _guildList ?? <Githubuserbean>[];

  List<String> get avatars {
    if (_avatars == null) {
      return <String>[];
    } else if (_avatars.length <= 9) {
      return _avatars;
    } else {
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

  void select(int index) {
    selectedIndex.value = index;
  }
}
