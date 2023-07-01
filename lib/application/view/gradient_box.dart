import 'package:flutter/material.dart';

class GradientBox extends StatelessWidget {
  final Color from;
  final Color to;

  const GradientBox({
    Key? key,
    required Color this.from,
    required Color this.to,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30,
      decoration: BoxDecoration(
          gradient: LinearGradient(
        colors: [from, to],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      )),
    );
  }
}
