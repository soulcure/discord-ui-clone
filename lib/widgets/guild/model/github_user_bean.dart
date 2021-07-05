import 'dart:convert';

class Githubuserbean {
  final String login;
  final int id;
  final String nodeId;
  final String avatarUrl;
  final String gravatarId;
  final String url;
  final String htmlUrl;
  final String followersUrl;
  final String followingUrl;
  final String gistsUrl;
  final String starredUrl;
  final String subscriptionsUrl;
  final String organizationsUrl;
  final String reposUrl;
  final String eventsUrl;
  final String receivedEventsUrl;
  final String type;
  final bool siteAdmin;
  Githubuserbean({
    this.login,
    this.id,
    this.nodeId,
    this.avatarUrl,
    this.gravatarId,
    this.url,
    this.htmlUrl,
    this.followersUrl,
    this.followingUrl,
    this.gistsUrl,
    this.starredUrl,
    this.subscriptionsUrl,
    this.organizationsUrl,
    this.reposUrl,
    this.eventsUrl,
    this.receivedEventsUrl,
    this.type,
    this.siteAdmin,
  });

  Githubuserbean copyWith({
    String login,
    int id,
    String nodeId,
    String avatarUrl,
    String gravatarId,
    String url,
    String htmlUrl,
    String followersUrl,
    String followingUrl,
    String gistsUrl,
    String starredUrl,
    String subscriptionsUrl,
    String organizationsUrl,
    String reposUrl,
    String eventsUrl,
    String receivedEventsUrl,
    String type,
    bool siteAdmin,
  }) {
    return Githubuserbean(
      login: login ?? this.login,
      id: id ?? this.id,
      nodeId: nodeId ?? this.nodeId,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      gravatarId: gravatarId ?? this.gravatarId,
      url: url ?? this.url,
      htmlUrl: htmlUrl ?? this.htmlUrl,
      followersUrl: followersUrl ?? this.followersUrl,
      followingUrl: followingUrl ?? this.followingUrl,
      gistsUrl: gistsUrl ?? this.gistsUrl,
      starredUrl: starredUrl ?? this.starredUrl,
      subscriptionsUrl: subscriptionsUrl ?? this.subscriptionsUrl,
      organizationsUrl: organizationsUrl ?? this.organizationsUrl,
      reposUrl: reposUrl ?? this.reposUrl,
      eventsUrl: eventsUrl ?? this.eventsUrl,
      receivedEventsUrl: receivedEventsUrl ?? this.receivedEventsUrl,
      type: type ?? this.type,
      siteAdmin: siteAdmin ?? this.siteAdmin,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'login': login,
      'id': id,
      'node_id': nodeId,
      'avatar_url': avatarUrl,
      'gravatar_id': gravatarId,
      'url': url,
      'html_url': htmlUrl,
      'followers_url': followersUrl,
      'following_url': followingUrl,
      'gists_url': gistsUrl,
      'starred_url': starredUrl,
      'subscriptions_url': subscriptionsUrl,
      'organizations_url': organizationsUrl,
      'repos_url': reposUrl,
      'events_url': eventsUrl,
      'received_events_url': receivedEventsUrl,
      'type': type,
      'site_admin': siteAdmin,
    };
  }

  factory Githubuserbean.fromMap(Map<String, dynamic> map) {
    return Githubuserbean(
      login: map['login'],
      id: map['id']?.toInt(),
      nodeId: map['node_id'],
      avatarUrl: map['avatar_url'],
      gravatarId: map['gravatar_id'],
      url: map['url'],
      htmlUrl: map['html_url'],
      followersUrl: map['followers_url'],
      followingUrl: map['following_url'],
      gistsUrl: map['gists_url'],
      starredUrl: map['starred_url'],
      subscriptionsUrl: map['subscriptions_url'],
      organizationsUrl: map['organizations_url'],
      reposUrl: map['repos_url'],
      eventsUrl: map['events_url'],
      receivedEventsUrl: map['received_events_url'],
      type: map['type'],
      siteAdmin: map['site_admin'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Githubuserbean.fromJson(String source) =>
      Githubuserbean.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Githubuserbean(login: $login, id: $id, node_id: $nodeId, avatar_url: $avatarUrl, gravatar_id: $gravatarId, url: $url, html_url: $htmlUrl, followers_url: $followersUrl, following_url: $followingUrl, gists_url: $gistsUrl, starred_url: $starredUrl, subscriptions_url: $subscriptionsUrl, organizations_url: $organizationsUrl, repos_url: $reposUrl, events_url: $eventsUrl, received_events_url: $receivedEventsUrl, type: $type, site_admin: $siteAdmin)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Githubuserbean &&
        other.login == login &&
        other.id == id &&
        other.nodeId == nodeId &&
        other.avatarUrl == avatarUrl &&
        other.gravatarId == gravatarId &&
        other.url == url &&
        other.htmlUrl == htmlUrl &&
        other.followersUrl == followersUrl &&
        other.followingUrl == followingUrl &&
        other.gistsUrl == gistsUrl &&
        other.starredUrl == starredUrl &&
        other.subscriptionsUrl == subscriptionsUrl &&
        other.organizationsUrl == organizationsUrl &&
        other.reposUrl == reposUrl &&
        other.eventsUrl == eventsUrl &&
        other.receivedEventsUrl == receivedEventsUrl &&
        other.type == type &&
        other.siteAdmin == siteAdmin;
  }

  @override
  int get hashCode {
    return login.hashCode ^
        id.hashCode ^
        nodeId.hashCode ^
        avatarUrl.hashCode ^
        gravatarId.hashCode ^
        url.hashCode ^
        htmlUrl.hashCode ^
        followersUrl.hashCode ^
        followingUrl.hashCode ^
        gistsUrl.hashCode ^
        starredUrl.hashCode ^
        subscriptionsUrl.hashCode ^
        organizationsUrl.hashCode ^
        reposUrl.hashCode ^
        eventsUrl.hashCode ^
        receivedEventsUrl.hashCode ^
        type.hashCode ^
        siteAdmin.hashCode;
  }
}
