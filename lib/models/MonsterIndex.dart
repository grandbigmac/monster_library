class MonsterIndex {
  String index;
  String name;
  String url;

  MonsterIndex({
    required this.index,
    required this.name,
    required this.url,
  });

  factory MonsterIndex.fromJson(var json) {
    return MonsterIndex(
      index: json['index'],
      name: json['name'],
      url: json['url'],
    );
  }
}