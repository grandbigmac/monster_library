import 'dart:convert';
import 'dart:developer';

import 'package:monster_library/models/model_features/Action.dart';
import 'package:monster_library/models/model_features/ArmorClass.dart';
import 'package:monster_library/models/model_features/Proficiency.dart';
import 'package:monster_library/models/model_features/SpecialAbility.dart';

import 'model_features/Speed.dart';

class Monster {
  String index;
  String name;
  String size;
  String type;
  String alignment;

  //Armour Class
  ArmorClass armor_class;

  int hit_points;
  String hit_dice;
  String hit_points_roll;

  //Speed
  Speed speed;

  int strength;
  int dexterity;
  int constitution;
  int intelligence;
  int wisdom;
  int charisma;

  //Proficiencies
  List<Proficiency> proficiencies;
  //Damage Vulnerabilities
  List<String> damage_vulnerabilities;
  //Damage Resistances
  List<String> damage_resistances;
  //Damage Immunities
  List<String> damage_immunities;
  //Condition Immunities
  List<String> condition_immunities;
  //Senses
  Map<String, dynamic> senses;

  List<String> languages;
  double challenge_rating;
  int proficiency_bonus;
  int xp;

  //Special Abilities
  List<SpecialAbility> special_abilties;
  //Actions
  List<Action> actions;
  //Legendary Actions

  String? image;
  String url;

  Monster({
    required this.index,
    required this.name,
    required this.size,
    required this.type,
    required this.alignment,
    required this.armor_class,
    required this.hit_points,
    required this.hit_dice,
    required this.hit_points_roll,
    required this.speed,
    required this.strength,
    required this.dexterity,
    required this.constitution,
    required this.intelligence,
    required this.wisdom,
    required this.charisma,
    required this.proficiencies,
    required this.damage_vulnerabilities,
    required this.damage_resistances,
    required this.damage_immunities,
    required this.condition_immunities,
    required this.senses,
    required this.languages,
    required this.challenge_rating,
    required this.proficiency_bonus,
    required this.xp,
    required this.special_abilties,
    required this.actions,
    this.image,
    required this.url,
  });

  //From Json Method


  factory Monster.fromJson(var json) {
    log(json['index'].toString());

    return Monster(
      index: json['index'],
      name: json['name'],
      size: json['size'],
      type: json['type'],
      //TODO SUBTYPE
      alignment: json['alignment'],
      armor_class: ArmorClass.fromJson(json),
      hit_points: json['hit_points'],
      hit_dice: json['hit_dice'],
      hit_points_roll: json['hit_points_roll'],
      speed: Speed.fromJson(json),
      strength: json['strength'],
      dexterity: json['dexterity'],
      constitution: json['constitution'],
      intelligence: json['intelligence'],
      wisdom: json['wisdom'],
      charisma: json['charisma'],
      proficiencies: proficienciesList(json['proficiencies']),
      damage_vulnerabilities: List.from(json['damage_vulnerabilities']),
      damage_resistances: List.from(json['damage_resistances']),
      damage_immunities: List.from(json['damage_immunities']),
      condition_immunities: [],
      senses: json['senses'],
      languages: json['languages'].split(', '),
      challenge_rating: json['challenge_rating'].toDouble(),
      proficiency_bonus: json['proficiency_bonus'],
      xp: json['xp'],
      special_abilties: specialAbilitiesList(json['special_abilities']),
      actions: actionList(json['actions']),
      image: json['image'],
      url: json['url'],
    );
  }
}