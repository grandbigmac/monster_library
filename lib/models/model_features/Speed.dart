class Speed {
  int? walk;
  int? fly;
  int? swim;
  int? climb;

  Speed({
    this.walk,
    this.fly,
    this.swim,
    this.climb,
  });


  factory Speed.fromJson(var json) {
    return Speed(
      walk: json['speed']['walk'] != null ? int.parse(json['speed']['walk'].split(' ')[0]) : null,
      fly: json['speed']['fly'] != null ? int.parse(json['speed']['fly'].split(' ')[0]) : null,
      swim: json['speed']['swim'] != null ? int.parse(json['speed']['swim'].split(' ')[0]) : null,
      climb: json['speed']['climb'] != null ? int.parse(json['speed']['climb'].split(' ')[0]) : null,
    );
  }
}