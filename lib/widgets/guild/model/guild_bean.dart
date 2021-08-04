import 'dart:convert';

class GuildBean {
  GuildBean({
    this.guildId,
    this.url,
    this.guildName,
    this.channels,
  });

  factory GuildBean.fromJson(String source) =>
      GuildBean.fromMap(json.decode(source));

  factory GuildBean.fromMap(Map<String, dynamic> map) {
    return GuildBean(
      guildId: map['guildId'],
      url: map['url'],
      guildName: map['guildName'],
      channels: List<ChannelBean>.from(
          map['channels']?.map((x) => ChannelBean.fromMap(x))),
    );
  }

  List<ChannelBean> channels;
  int guildId;
  String guildName;
  String url;

  @override
  String toString() {
    return 'GuildBean(guildId: $guildId, url: $url, guildName: $guildName, channels: $channels)';
  }

  Map<String, dynamic> toMap() {
    return {
      'guildId': guildId,
      'url': url,
      'guildName': guildName,
      'channels': channels.map((x) => x.toMap()).toList(),
    };
  }

  String toJson() => json.encode(toMap());

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
  ChannelBean({
    this.channelId,
    this.channelName,
    this.channelType,
  });

  factory ChannelBean.fromJson(String source) =>
      ChannelBean.fromMap(json.decode(source));

  factory ChannelBean.fromMap(Map<String, dynamic> map) {
    return ChannelBean(
      channelId: map['channelId'],
      channelName: map['channelName'],
      channelType: map['channelType'],
    );
  }

  String channelId;
  String channelName;
  int channelType;

  @override
  String toString() =>
      'ChannelBean(channelId: $channelId, channelName: $channelName, channelType: $channelType)';

  Map<String, dynamic> toMap() {
    return {
      'channelId': channelId,
      'channelName': channelName,
      'channelType': channelType,
    };
  }

  String toJson() => json.encode(toMap());

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
