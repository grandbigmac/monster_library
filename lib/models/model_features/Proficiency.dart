class Proficiency {
  String name;
  int value;

  Proficiency({
    required this.name,
    required this.value
  });

  factory Proficiency.fromJson(var json) {
    return Proficiency(
      name: json['proficiency']['name'],
      value: json['value'],
    );
  }
}

List<Proficiency> proficienciesList(List json) {
  List<Proficiency> list = [];

  for (var i in json) {
    list.add(Proficiency.fromJson(i));
  }

  return list;
}