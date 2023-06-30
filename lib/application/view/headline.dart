import 'package:flutter/material.dart';

class Headline extends StatelessWidget {
  const Headline({Key? key, required this.title, required this.product})
      : super(key: key);

  final String title;
  final String product;

  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.all(16),
        child: Text(
          title + ' ' + product,
          style: const TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
      );
}
