import 'package:flutter/material.dart';

class Headline extends StatelessWidget {
  const Headline({Key? key, required this.title, required this.product})
      : super(key: key);

  final String title;
  final String product;

  @override
  Widget build(BuildContext context) => SizedBox(
        height: 66,
        child: Container(
            color: const Color.fromARGB(78, 130, 178, 255),
            padding: const EdgeInsets.only(left: 16, right: 16),
            child: Center(
              child: Text(
                title + ' ' + product,
                style: const TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
            )),
      );
}
