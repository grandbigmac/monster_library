import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:monster_library/API/env.dart';
import 'package:monster_library/models/Monster.dart';
import 'package:monster_library/models/model_features/Action.dart' as action;

class MonsterView extends StatefulWidget {
  const MonsterView({super.key, required this.monster});
  final Monster monster;

  @override
  State<MonsterView> createState() => _MonsterViewState();
}

class _MonsterViewState extends State<MonsterView> {
  late Monster monster;

  @override
  void initState() {
    super.initState();
    monster = widget.monster;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(MediaQuery.sizeOf(context).shortestSide * 0.05),
          width: double.infinity,
          child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    width: MediaQuery.sizeOf(context).shortestSide * 0.25,
                    height: MediaQuery.sizeOf(context).shortestSide * 0.25,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: monster.image != null ?
                          DecorationImage(
                            image: Image.network('$BASE_IMAGE_URL${monster.image}').image,
                            fit: BoxFit.cover,
                          )
                          :
                          null,
                    ),
                  ),
                ),
                SizedBox(height: MediaQuery.sizeOf(context).shortestSide * 0.05),
                Text(monster.name, style: Theme.of(context).textTheme.bodyMedium),
                Row(
                  children: [
                    Icon(Icons.favorite, color: Colors.red, size: MediaQuery.sizeOf(context).shortestSide * 0.05),
                    Text(monster.hit_points.toString(), style: Theme.of(context).textTheme.bodyMedium),
                  ]
                ),
                Row(
                  children: [
                    Icon(Icons.shield, color: Colors.blue, size: MediaQuery.sizeOf(context).shortestSide * 0.05),
                    Text(monster.armor_class.value.toString(), style: Theme.of(context).textTheme.bodyMedium),
                  ]
                ),
                SizedBox(height: MediaQuery.sizeOf(context).shortestSide * 0.05),
                Text('Actions:'),
                Builder(
                  builder: (BuildContext context) {
                    List<Widget> actions = [];

                    Widget actionWidget(action.Action action) {
                      return Container(
                        width: double.infinity,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(action.name, style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.bold)),
                            Text(action.desc, style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontVariations: [FontVariation.italic(1.0)])),
                          ]
                        )
                      );
                    }

                    for (action.Action i in monster.actions) {
                      actions.add(actionWidget(i));
                    }

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: actions,
                    );
                  }
                ),
              ]
          ),
        ),
      ),
    );
  }
}