import 'dart:developer';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:monster_library/API/env.dart';
import 'package:monster_library/modals/roll_display.dart';
import 'package:monster_library/models/Monster.dart';
import 'package:monster_library/tools.dart';

class MonsterViewLayout extends StatefulWidget {
  const MonsterViewLayout({super.key, required this.monster});
  final Monster monster;

  @override
  State<MonsterViewLayout> createState() => _MonsterViewLayoutState();
}

class _MonsterViewLayoutState extends State<MonsterViewLayout> {
  late Monster monster;

  @override
  void initState() {
    super.initState();
    monster = widget.monster;
  }

  void rollRequested(String rollType, int mod) {
    log('Rolling a $rollType check with +$mod');
    showRollDisplay(context, rollType, mod);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SizedBox(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //Name + CR
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(monster.name, style: Theme.of(context).textTheme.headlineMedium),
                Text('CR ${monster.challenge_rating}', style: Theme.of(context).textTheme.headlineMedium)
              ]
            ),
            //Portrait + Stats
            Container(
              width: double.infinity,
              height: MediaQuery.sizeOf(context).shortestSide * 0.5,
              decoration: BoxDecoration(
                //border: Border.all(color: Colors.white),
              ),
              child: Row(
                children: [
                  Flexible(
                      flex: 1,
                      child: Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('${monster.size} ${monster.type} (${monster.alignment})', style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontStyle: FontStyle.italic),),
                            const Spacer(),
                            Row(
                              children: [
                                Icon(
                                  Icons.favorite, color: Colors.amber, size: MediaQuery.sizeOf(context).shortestSide * 0.05,
                                ),
                                SizedBox(width: MediaQuery.sizeOf(context).shortestSide * 0.0125,),
                                RichText(
                                  text: TextSpan(
                                      text: monster.hit_points.toString(),
                                      style: Theme.of(context).textTheme.bodyLarge,
                                      children: [
                                        TextSpan(
                                          text: '(${monster.hit_points_roll})',
                                          style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: Colors.grey),
                                        )
                                      ]
                                  ),
                                )
                              ]
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons.shield, color: Colors.amber, size: MediaQuery.sizeOf(context).shortestSide * 0.05,
                                ),
                                SizedBox(width: MediaQuery.sizeOf(context).shortestSide * 0.0125,),
                                Text(monster.armor_class.value.toString(), style: Theme.of(context).textTheme.bodyLarge,),
                              ]
                            ),
                            SizedBox(height: MediaQuery.sizeOf(context).shortestSide * 0.025,),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Icon(
                                  Icons.directions_walk_rounded, color: Colors.amber, size: MediaQuery.sizeOf(context).shortestSide * 0.05,
                                ),
                                Builder(
                                  builder: (BuildContext context) {
                                    String speed = '';
      
                                    if (monster.speed.walk != null) {
                                      speed = '${speed}Walk: ${monster.speed.walk}ft\n';
                                    }
                                    if (monster.speed.climb != null) {
                                      speed = '${speed}Climb: ${monster.speed.climb}ft\n';
                                    }
                                    if (monster.speed.fly != null) {
                                      speed = '${speed}Fly: ${monster.speed.fly}ft\n';
                                    }
                                    if (monster.speed.swim != null) {
                                      speed = '${speed}Swim: ${monster.speed.swim}ft';
                                    }
      
                                    return Expanded(
                                      child: Text(speed, style: Theme.of(context).textTheme.bodyLarge),
                                    );
                                  }
                                )
                              ]
                            ),
                            const Spacer(),
                          ]
                      )
                  ),
                  monster.image != null ?
                    Flexible(
                        flex: 1,
                        child: Container(
                          width: double.infinity,
                          height: MediaQuery.sizeOf(context).shortestSide * 0.5,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey, width: 2.0,),
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              image: Image.network('$BASE_IMAGE_URL${monster.image}').image,
                              fit: BoxFit.cover,
                            )
                          ),
                        )
                    )
                  :
                    Container(),
                ]
              )
            ),
            //Abilities
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(color: Colors.amber, width: 2),
                  bottom: BorderSide(color: Colors.amber, width: 2),
                )
              ),
              padding: EdgeInsets.symmetric(vertical: MediaQuery.sizeOf(context).shortestSide * 0.025),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
      
                  //STR COLUMN
                  Flexible(
                    flex: 1,
                    child: InkWell(
                      onTap: () {
                        rollRequested('Strength Check', calculateModifier(monster.strength));
                      },
                      child: Column(
                        children: [
                          Text('STR', style: Theme.of(context).textTheme.headlineSmall),
                          Text(calculateModifier(monster.strength).toString(), style: Theme.of(context).textTheme.headlineMedium),
                          Text(monster.strength.toString(), style: Theme.of(context).textTheme.bodyLarge),
                        ]
                      ),
                    ),
                  ),
      
                  //DEX COLUMN
                  Flexible(
                    flex: 1,
                    child: InkWell(
                      onTap: () {
                        rollRequested('Dexterity Check', calculateModifier(monster.dexterity));
                      },
                      child: Column(
                          children: [
                            Text('DEX', style: Theme.of(context).textTheme.headlineSmall),
                            Text(calculateModifier(monster.dexterity).toString(), style: Theme.of(context).textTheme.headlineMedium),
                            Text(monster.dexterity.toString(), style: Theme.of(context).textTheme.bodyLarge),
                          ]
                      ),
                    ),
                  ),
      
                  //CON COLUMN
                  Flexible(
                    flex: 1,
                    child: InkWell(
                      onTap: () {
                        rollRequested('Constitution Check', calculateModifier(monster.constitution));
                      },
                      child: Column(
                          children: [
                            Text('CON', style: Theme.of(context).textTheme.headlineSmall),
                            Text(calculateModifier(monster.constitution).toString(), style: Theme.of(context).textTheme.headlineMedium),
                            Text(monster.constitution.toString(), style: Theme.of(context).textTheme.bodyLarge),
                          ]
                      ),
                    ),
                  ),
      
                  //INT COLUMN
                  Flexible(
                    flex: 1,
                    child: InkWell(
                      onTap: () {
                        rollRequested('Intelligence Check', calculateModifier(monster.intelligence));
                      },
                      child: Column(
                          children: [
                            Text('INT', style: Theme.of(context).textTheme.headlineSmall),
                            Text(calculateModifier(monster.intelligence).toString(), style: Theme.of(context).textTheme.headlineMedium),
                            Text(monster.intelligence.toString(), style: Theme.of(context).textTheme.bodyLarge),
                          ]
                      ),
                    ),
                  ),
      
                  //WIS COLUMN
                  Flexible(
                    flex: 1,
                    child: InkWell(
                      onTap: () {
                        rollRequested('Wisdom Check', calculateModifier(monster.wisdom));
                      },
                      child: Column(
                          children: [
                            Text('WIS', style: Theme.of(context).textTheme.headlineSmall),
                            Text(calculateModifier(monster.wisdom).toString(), style: Theme.of(context).textTheme.headlineMedium),
                            Text(monster.wisdom.toString(), style: Theme.of(context).textTheme.bodyLarge),
                          ]
                      ),
                    ),
                  ),
      
                  //CHA COLUMN
                  Flexible(
                    flex: 1,
                    child: InkWell(
                      onTap: () {
                        rollRequested('Charisma Check', calculateModifier(monster.charisma));
                      },
                      child: Column(
                          children: [
                            Text('CHA', style: Theme.of(context).textTheme.headlineSmall),
                            Text(calculateModifier(monster.charisma).toString(), style: Theme.of(context).textTheme.headlineMedium),
                            Text(monster.charisma.toString(), style: Theme.of(context).textTheme.bodyLarge),
                          ]
                      ),
                    ),
                  ),
                ]
              )
            ),
            //Saving Throws + Skills + Languages + Damage Type Reaction
            Container(
              width: double.infinity,
              //height: MediaQuery.sizeOf(context).shortestSide * 0.4,
              decoration: BoxDecoration(
                border: Border(bottom: BorderSide(color: Colors.amber, width: 2.0)),
              ),
              padding: EdgeInsets.symmetric(vertical: MediaQuery.sizeOf(context).shortestSide * 0.0125),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  //Saving Throws
                  Builder(
                    builder: (context) {
                      List<InlineSpan> list = [];
      
                      for (var i in monster.proficiencies) {
                        if (i.name.contains('Saving Throw')) {
                          //list.add('${i.name.replaceAll('Saving Throw: ', '')}: ${i.value}');
                          list.add(
                            TextSpan(
                              text: '${i.name.replaceAll('Saving Throw: ', '')}: ',
                              style: Theme.of(context).textTheme.bodyLarge,
                              children: [
                                TextSpan(
                                  text: '${i.value}  ',
                                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: Colors.amber, fontWeight: FontWeight.bold)
                                )
                              ]
                            )
                          );
                        }
                      }
      
                      //If the list is empty, return nothing
                      if (list.isEmpty) return Container();
      
                      //return Text(list.join(', '), style: Theme.of(context).textTheme.bodyLarge,);
                      return Padding(
                        padding: EdgeInsets.only(bottom: MediaQuery.sizeOf(context).shortestSide * 0.0125),
                        child: RichText(
                          text: TextSpan(
                            text: 'Saving Throws\n',
                            style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.bold),
                            children: list
                          )
                        ),
                      );
                    }
                  ),
                  //Skills
                  Builder(
                      builder: (context) {
                        List<InlineSpan> list = [];
      
                        for (var i in monster.proficiencies) {
                          if (i.name.contains('Skill')) {
                            //list.add('${i.name.replaceAll('Saving Throw: ', '')}: ${i.value}');
                            list.add(
                                TextSpan(
                                    text: '${i.name.replaceAll('Skill: ', '')}: ',
                                    style: Theme.of(context).textTheme.bodyLarge,
                                    children: [
                                      TextSpan(
                                          text: '${i.value}  ',
                                          style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: Colors.amber, fontWeight: FontWeight.bold)
                                      )
                                    ]
                                )
                            );
                          }
                        }
      
                        //If the list is empty, return nothing
                        if (list.isEmpty) return Container();
      
                        //return Text(list.join(', '), style: Theme.of(context).textTheme.bodyLarge,);
                        return Padding(
                          padding: EdgeInsets.only(bottom: MediaQuery.sizeOf(context).shortestSide * 0.0125),
                          child: RichText(
                              text: TextSpan(
                                  text: 'Skills\n',
                                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.bold),
                                  children: list
                              )
                          ),
                        );
                      }
                  ),
                  //Damage Vulnerabilities
                  Builder(
                    builder: (context) {
                      List<InlineSpan> list = [];
      
                      for (var i in monster.damage_vulnerabilities) {
                        list.add(
                            TextSpan(
                              text: i,
                              style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontStyle: FontStyle.italic),
                            )
                        );
                      }
      
                      //If the list is empty, return nothing
                      if (list.isEmpty) return Container();
      
                      //return Text(list.join(', '), style: Theme.of(context).textTheme.bodyLarge,);
                      return Padding(
                        padding: EdgeInsets.only(bottom: MediaQuery.sizeOf(context).shortestSide * 0.0125),
                        child: RichText(
                            text: TextSpan(
                                text: 'Damage Vulnerabilties\n',
                                style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.bold),
                                children: list
                            )
                        ),
                      );
                    }
                  ),
                  //Damage Resistances
                  Builder(
                      builder: (context) {
                        List<InlineSpan> list = [];
      
                        for (var i in monster.damage_resistances) {
                          list.add(
                              TextSpan(
                                text: '$i${monster.damage_resistances.last == i ? '' : ', '}',
                                style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontStyle: FontStyle.italic),
                              )
                          );
                        }
      
                        //If the list is empty, return nothing
                        if (list.isEmpty) return Container();
      
                        //return Text(list.join(', '), style: Theme.of(context).textTheme.bodyLarge,);
                        return Padding(
                          padding: EdgeInsets.only(bottom: MediaQuery.sizeOf(context).shortestSide * 0.0125),
                          child: RichText(
                              text: TextSpan(
                                  text: 'Damage Resistances\n',
                                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.bold),
                                  children: list
                              )
                          ),
                        );
                      }
                  ),
                  //Damage Immunities
                  Builder(
                      builder: (context) {
                        List<InlineSpan> list = [];
      
                        for (var i in monster.damage_immunities) {
                          list.add(
                              TextSpan(
                                text: i,
                                style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontStyle: FontStyle.italic),
                              )
                          );
                        }
      
                        //If the list is empty, return nothing
                        if (list.isEmpty) return Container();
      
                        //return Text(list.join(', '), style: Theme.of(context).textTheme.bodyLarge,);
                        return Padding(
                          padding: EdgeInsets.only(bottom: MediaQuery.sizeOf(context).shortestSide * 0.0125),
                          child: RichText(
                              text: TextSpan(
                                  text: 'Damage Immunities\n',
                                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.bold),
                                  children: list
                              )
                          ),
                        );
                      }
                  ),
                  //Condition Immunities
                  Builder(
                      builder: (context) {
                        List<InlineSpan> list = [];
      
                        for (var i in monster.condition_immunities) {
                          list.add(
                              TextSpan(
                                text: i,
                                style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontStyle: FontStyle.italic),
                              )
                          );
                        }
      
                        //If the list is empty, return nothing
                        if (list.isEmpty) return Container();
      
                        //return Text(list.join(', '), style: Theme.of(context).textTheme.bodyLarge,);
                        return Padding(
                          padding: EdgeInsets.only(bottom: MediaQuery.sizeOf(context).shortestSide * 0.0125),
                          child: RichText(
                              text: TextSpan(
                                  text: 'Condition Immunities\n',
                                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.bold),
                                  children: list
                              )
                          ),
                        );
                      }
                  ),
                  //Senses
                  Builder(
                      builder: (context) {
                        List<InlineSpan> list = [];
      
                        for (int i = 0; i < monster.senses.values.length; i++) {
                          list.add(
                              TextSpan(
                                text: '${monster.senses.keys.elementAt(i).replaceAll('_', ' ')} ${monster.senses.values.elementAt(i)}${monster.senses.values.last != monster.senses.values.elementAt(i) ? '\n' : ''}',
                                style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontStyle: FontStyle.italic),
                              )
                          );
                        }
      
                        //If the list is empty, return nothing
                        if (list.isEmpty) return Container();
      
                        //return Text(list.join(', '), style: Theme.of(context).textTheme.bodyLarge,);
                        return Padding(
                          padding: EdgeInsets.only(bottom: MediaQuery.sizeOf(context).shortestSide * 0.0125),
                          child: RichText(
                              text: TextSpan(
                                  text: 'Senses\n',
                                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.bold),
                                  children: list
                              )
                          ),
                        );
                      }
                  ),
                  //Languages
                  Builder(
                      builder: (context) {
                        List<InlineSpan> list = [];
      
                        for (var i in monster.languages) {
                          list.add(
                              TextSpan(
                                text: '$i${monster.languages.last != i ? ', ' : ''}',
                                style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontStyle: FontStyle.italic),
                              )
                          );
                        }
      
                        //If the list is empty, return nothing
                        if (list.isEmpty) return Container();
      
                        //return Text(list.join(', '), style: Theme.of(context).textTheme.bodyLarge,);
                        return Padding(
                          padding: EdgeInsets.only(bottom: MediaQuery.sizeOf(context).shortestSide * 0.0125),
                          child: RichText(
                              text: TextSpan(
                                  text: 'Languages\n',
                                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.bold),
                                  children: list
                              )
                          ),
                        );
                      }
                  ),
                ]
              )
            ),
            //Special Abilities
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                border: Border(bottom: BorderSide(color: monster.special_abilties.isNotEmpty ? Colors.amber : Colors.transparent, width: 2.0)),
              ),
              padding: EdgeInsets.symmetric(vertical: MediaQuery.sizeOf(context).shortestSide * 0.0125),
              child: Builder(
                builder: (context) {
                  List<InlineSpan> list = [];
      
                  for (var i in monster.special_abilties) {
                    list.add(
                        TextSpan(
                            text: '${i.name} '
                                '${i.usage != null ?
                                  (i.usage!['type'] == 'per day' ? '(${i.usage!['times']} ${i.usage!['type']})' : '') : ''}\n',
                            style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: Colors.amber, fontWeight: FontWeight.bold),
                            children: [
                              TextSpan(
                                  text: '${i.desc}${i != monster.special_abilties.last ? '\n' : ''}',
                                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: Colors.white, fontStyle: FontStyle.italic)
                              ),
                            ]
                        )
                    );
                  }
      
                  //If the list is empty, return nothing
                  if (list.isEmpty) return Container();
      
                  //return Text(list.join(', '), style: Theme.of(context).textTheme.bodyLarge,);
                  return Padding(
                    padding: EdgeInsets.only(bottom: MediaQuery.sizeOf(context).shortestSide * 0.0125),
                    child: RichText(
                        text: TextSpan(
                            text: '',
                            style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.bold),
                            children: list
                        )
                    ),
                  );
                }
              )
            ),
            //Actions
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                border: Border(bottom: BorderSide(color: Colors.amber, width: 2.0)),
              ),
              padding: EdgeInsets.symmetric(vertical: MediaQuery.sizeOf(context).shortestSide * 0.0125),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Builder(
                      builder: (context) {
                        List<InlineSpan> list = [];

                        for (var i in monster.actions) {
                          list.add(
                              TextSpan(
                                  text: '${i.name}\n',
                                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: Colors.amber, fontWeight: FontWeight.bold),
                                  children: [
                                    TextSpan(
                                        text: '${i.desc}${i != monster.actions.last ? '\n' : ''}',
                                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: Colors.white, fontStyle: FontStyle.italic)
                                    ),
                                  ]
                              )
                          );
                        }

                        //If the list is empty, return nothing
                        if (list.isEmpty) return Container();

                        //return Text(list.join(', '), style: Theme.of(context).textTheme.bodyLarge,);
                        return Padding(
                          padding: EdgeInsets.only(bottom: MediaQuery.sizeOf(context).shortestSide * 0.0125),
                          child: RichText(
                              text: TextSpan(
                                  text: '',
                                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.bold),
                                  children: list
                              )
                          ),
                        );
                      }
                  )
                ]
              )
            ),
            //TODO Legendary Actions
            Container(
              //Add legendary actions to the model
              //Display legendary actions here conditionally if needed
            ),
          ]
        )
      ),
    );
  }
}
