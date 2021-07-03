import 'dart:convert';

class GuildBean {
  int guildId;
  String url;
  String guildName;
  List<ChannelBean> channels;
  GuildBean({
    this.guildId,
    this.url,
    this.guildName,
    this.channels,
  });

  Map<String, dynamic> toMap() {
    return {
      'guildId': guildId,
      'url': url,
      'guildName': guildName,
      'channels': channels.map((x) => x.toMap()).toList(),
    };
  }

  factory GuildBean.fromMap(Map<String, dynamic> map) {
    return GuildBean(
      guildId: map['guildId'],
      url: map['url'],
      guildName: map['guildName'],
      channels: List<ChannelBean>.from(
          map['channels']?.map((x) => ChannelBean.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory GuildBean.fromJson(String source) =>
      GuildBean.fromMap(json.decode(source));

  @override
  String toString() {
    return 'GuildBean(guildId: $guildId, url: $url, guildName: $guildName, channels: $channels)';
  }

  GuildBean copyWith({
    int guildId,
    String url,
    String guildName,
    List<ChannelBean> channels,
  }) {
    return GuildBean(
      guildId: guildId ?? this.guildId,
      url: url ?? this.url,
      guildName: guildName ?? this.guildName,
      channels: channels ?? this.channels,
    );
  }
}

class ChannelBean {
  String channelId;
  String channelName;
  int channelType;
  ChannelBean({
    this.channelId,
    this.channelName,
    this.channelType,
  });

  Map<String, dynamic> toMap() {
    return {
      'channelId': channelId,
      'channelName': channelName,
      'channelType': channelType,
    };
  }

  factory ChannelBean.fromMap(Map<String, dynamic> map) {
    return ChannelBean(
      channelId: map['channelId'],
      channelName: map['channelName'],
      channelType: map['channelType'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ChannelBean.fromJson(String source) =>
      ChannelBean.fromMap(json.decode(source));

  @override
  String toString() =>
      'ChannelBean(channelId: $channelId, channelName: $channelName, channelType: $channelType)';

  ChannelBean copyWith({
    String channelId,
    String channelName,
    int channelType,
  }) {
    return ChannelBean(
      channelId: channelId ?? this.channelId,
      channelName: channelName ?? this.channelName,
      channelType: channelType ?? this.channelType,
    );
  }
}
