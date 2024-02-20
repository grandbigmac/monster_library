import 'dart:developer';

import 'package:flutter/material.dart';
import 'dart:ui' as ui;
import 'dart:math' as m;

class RollDisplayModal extends StatefulWidget {
  const RollDisplayModal({super.key, required this.rollType, required this.mod, this.multiRollType});
  final String rollType;
  final int mod;
  final String? multiRollType;

  @override
  State<RollDisplayModal> createState() => _RollDisplayModalState();
}

class _RollDisplayModalState extends State<RollDisplayModal> with SingleTickerProviderStateMixin {
  late int result;
  late AnimationController _spinController;
  late double _numberOpacity;
  late String rollType;
  late int mod;
  late String? multiRollType;
  bool done = false;



  @override
  void initState() {
    super.initState();
    rollType = widget.rollType;
    mod = widget.mod;
    multiRollType = widget.multiRollType;
    _numberOpacity = 0.0;

    _spinController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );
    _spinController.forward();

    Future.delayed(const Duration(milliseconds: 750), () {
      setState(() {
        _numberOpacity = 1.0;
        done = true;
      });
    });

    result = calculateResult();
  }

  @override
  void dispose() {
    _spinController.dispose();
    super.dispose();
  }

  int calculateResult() {
    m.Random rand = m.Random();
    int baseResult = rand.nextInt(20) + 1;

    return baseResult + mod;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (!done) return;

        Navigator.pop(context);
      },
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          //border: Border.all(color: Colors.white),
        ),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(rollType, style: Theme.of(context).textTheme.headlineLarge!.copyWith(color: Colors.amber)),
              Stack(
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: AnimatedBuilder(
                      animation: _spinController,
                      builder: (context, child) {
                        return Transform.rotate(
                          //angle: _spinController.value * 2 * 3.1415,
                          angle: Curves.easeInOut.transform(_spinController.value) * 3 * 3.1415,
                          child: child,
                        );
                      },
                      child: ShaderMask(
                        shaderCallback: (Rect bounds) {
                          return ui.Gradient.linear(
                            const Offset(0, 0),
                            Offset(bounds.width, bounds.height),
                            [Colors.white, Colors.white],
                            [0.0, 1.0],
                          );
                        },
                        blendMode: BlendMode.srcATop,
                        child: Image.asset(
                          'assets/images/d20.png',
                          width: MediaQuery.sizeOf(context).shortestSide * 0.4,
                          height: MediaQuery.sizeOf(context).shortestSide * 0.4,
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: AnimatedOpacity(
                      opacity: _numberOpacity,
                      duration: const Duration(milliseconds: 250),
                      child: Container(
                        height: MediaQuery.sizeOf(context).shortestSide * 0.4,
                        decoration: BoxDecoration(
                          gradient: RadialGradient(
                            center: Alignment.center,
                            radius: 0.75,
                            colors: [result - mod == 20? Colors.red : Colors.amber, Colors.transparent],
                          )
                          //border: Border.all(color: Colors.red),
                        ),
                        child: Center(
                          child: Text(result.toString(), style: Theme.of(context).textTheme.headlineLarge),
                          //TODO show a radial gradient behind the roll result
                          //TODO fade in this number after the dice image is done rolling
                          //TODO add text above/below the dice to indicate what the roll is for
                          //TODO on click, close this modal
                        ),
                      ),
                    )
                  )
                ]
              ),
              AnimatedOpacity(
                opacity: _numberOpacity,
                duration: const Duration(milliseconds: 250),
                child: RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    text: result - mod == 20? 'CRITICAL!\n' : 'Result:\n',
                    style: Theme.of(context).textTheme.headlineMedium,
                    children: [
                      TextSpan(
                        text: result.toString(),
                        style: Theme.of(context).textTheme.headlineLarge
                      )
                    ]
                  )
                ),
              )
            ]
          )
        )
      ),
    );
  }
}

void showRollDisplay(BuildContext context, String rollType, int mod) {
  showModalBottomSheet(
    //isScrollControlled: true,
    backgroundColor: Colors.transparent,
    context: context,
    builder: (BuildContext context) {
      return RollDisplayModal(rollType: rollType, mod: mod);
    });
}
