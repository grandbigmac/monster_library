import 'dart:developer';

class Damage {
  String type;
  String damage_dice;

  Damage({
    required this.type,
    required this.damage_dice
  });

  factory Damage.fromJson(json) {
    return Damage(
     type: json['damage_type']['name'],
     damage_dice: json['damage_dice'],
    );
  }
}

List<Damage> damageList(List json) {
  List<Damage> list = [];

  for (var i in json) {
    try {
      list.add(Damage.fromJson(i));
    }
    catch (e) {
      log('Error processing $i, error message: $e');
    }
  }

  return list;
}