import 'dart:async';


import 'package:flutter/material.dart';
import 'package:internshipmigi/services/loger.dart';

class CirCleAvatarAround extends StatefulWidget {

  Widget child;
  double turn;
  CirCleAvatarAround({required this.child,required this.turn});

  @override
  State<CirCleAvatarAround> createState() => _CirCleAvatarAroundState();
}

class _CirCleAvatarAroundState extends State<CirCleAvatarAround> {
  Timer? _animatedPlay;
  int _check =0;
  @override
  void initState() {
    super.initState();
    print("RENDER");
  }

 
  @override
  Widget build(BuildContext context) {
    print('-------------turn-------------${widget.turn}');
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle
      ),
      child: AnimatedRotation(
        turns: widget.turn,
        duration: Duration(microseconds: 200),
        child: widget.child,
      ),
    );
  }
}