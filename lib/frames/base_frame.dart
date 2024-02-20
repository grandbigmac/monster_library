import 'package:flutter/material.dart';
import 'package:monster_library/layouts/list_layout/list_layout.dart';

class BaseFrame extends StatefulWidget {
  const BaseFrame({super.key});

  @override
  State<BaseFrame> createState() => _BaseFrameState();
}

class _BaseFrameState extends State<BaseFrame> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(MediaQuery.sizeOf(context).shortestSide * 0.05),
          child: const ListLayout()
        ),
      )
    );
  }
}
