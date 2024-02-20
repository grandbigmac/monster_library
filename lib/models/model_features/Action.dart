import 'dart:convert';

import 'Damage.dart';

class Action {
  String name;
  String desc;
  int? attack_bonus;
  List<Damage> damage;

  Action({
    required this.name,
    required this.desc,
    this.attack_bonus,
    required this.damage,
  });

  factory Action.fromJson(var json) {
    return Action(
      name: json['name'],
      desc: json['desc'],
      attack_bonus: json['attack_bonus'],
      damage: json['damage'] != null ? damageList(json['damage']) : [],
    );
  }
}

List<Action> actionList(List json) {
  List<Action> list = [];

  for (var i in json) {
    list.add(Action.fromJson(i));
  }

  return list;
}