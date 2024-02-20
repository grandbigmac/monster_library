import 'package:flutter/material.dart';

class OverlayFrame extends StatefulWidget {
  const OverlayFrame({super.key, required this.viewWidget});
  final Widget viewWidget;

  @override
  State<OverlayFrame> createState() => _OverlayFrameState();
}

class _OverlayFrameState extends State<OverlayFrame> {
  late Widget viewWidget;

  @override
  void initState() {
    super.initState();
    viewWidget = widget.viewWidget;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(MediaQuery.sizeOf(context).shortestSide * 0.05),
          child: viewWidget,
        )
      ),
    );
  }
}
