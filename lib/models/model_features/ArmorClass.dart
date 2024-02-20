import 'dart:developer';

class ArmorClass {
  String type;
  int value;

  ArmorClass({
    required this.type,
    required this.value
  });

  //To JSON

  factory ArmorClass.fromJson(var json) {
    log('RESULT: $json');
    return ArmorClass(
      type: json['armor_class'][0]['type'],
      value: json['armor_class'][0]['value'],
    );
  }
}