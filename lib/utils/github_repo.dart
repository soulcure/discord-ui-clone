class GithubRepo {
  int id;
  String name;
  String fullName;
  String archiveUrl;

  GithubRepo({
    this.id,
    this.name,
    this.fullName,
    this.archiveUrl,
  });

  GithubRepo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    fullName = json['full_name'];
    archiveUrl = json['archive_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['full_name'] = this.fullName;
    data['archive_url'] = this.archiveUrl;
    return data;
  }

  @override
  String toString() {
    return "name=$name fullName=$fullName archiveUrl=$archiveUrl";
  }
}
