import 'dart:convert';

class SpecialAbility {
  String name;
  String desc;
  Map<String, dynamic>? usage;

  //Other non essential fields

  SpecialAbility({
    required this.name,
    required this.desc,
    this.usage,
  });

  factory SpecialAbility.fromJson(var json) {
    return SpecialAbility(
      name: json['name'],
      desc: json['desc'],
      usage: json['usage']
    );
  }
}

List<SpecialAbility> specialAbilitiesList(List json) {
  List<SpecialAbility> list = [];

  for (var i in json) {
    list.add(SpecialAbility.fromJson(i));
  }

  return list;
}