import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:monster_library/API/monsters/getAllIndexes.dart';
import 'package:monster_library/API/monsters/getSpecificMonster.dart';
import 'package:http/http.dart' as http;
import 'package:monster_library/frames/frame_navigation.dart';
import 'package:monster_library/models/MonsterIndex.dart';

import '../../models/Monster.dart';

bool loadingMonster = false;

Future<List<MonsterIndex>> getMonsterListFuture() async {
  http.Response response = await getAllIndexes();
  List<MonsterIndex> list = [];

  if (response.statusCode == 200 || response.statusCode == 201) {
    for (var i in jsonDecode(response.body)['results']) {
      list.add(MonsterIndex.fromJson(i));
    }
    return list;
  }
  else {
    return list;
  }
}

Future<void> goToMonster(BuildContext context, MonsterIndex monsterIndex) async {
  loadingMonster = true;
  http.Response response = await getSpecificMonster(monsterIndex.index);

  if (response.statusCode == 200 || response.statusCode == 201) {
    Monster monster = Monster.fromJson(jsonDecode(response.body));
    goToShowSpecificMonsterView(context, monster);
  }
  loadingMonster = false;
}