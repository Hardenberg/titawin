import 'package:flutter/material.dart';

class HeadLine extends StatefulWidget {
  const HeadLine({Key? key, required this.text, required this.name})
      : super(key: key);
  final String text;
  final String name;
  @override
  _HeadLineState createState() => _HeadLineState();
}

class _HeadLineState extends State<HeadLine> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(
        widget.text + " " + widget.name,
        style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
      ),
    );
  }
}
