import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:monster_library/frames/overlay_frame.dart';
import 'package:monster_library/layouts/monster_view_layout/monster_view_layout.dart';
import 'package:monster_library/modals/monster_preview.dart';

import '../models/Monster.dart';

goToShowSpecificMonsterView(BuildContext context, Monster monster) {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => OverlayFrame(viewWidget: MonsterViewLayout(monster: monster,)))
  );
}

