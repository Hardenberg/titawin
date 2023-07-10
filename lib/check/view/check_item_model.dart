import 'package:flutter/material.dart';

class CheckItemModel extends StatelessWidget {
  final String message;
  final bool isOk;

  const CheckItemModel({Key? key, required this.message, required this.isOk})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Expanded(
            flex: 1,
            child: Center(
              child: Icon(
                isOk ? Icons.check_circle : Icons.cancel,
                color: isOk ? Colors.green : Colors.red,
                size: 100,
              ),
            ),
          ),
          SizedBox(
            width: 20,
          ),
          Expanded(
              flex: 2,
              child: SelectableText(message,
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)))
        ],
      ),
    );
  }
}
