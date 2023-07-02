import 'package:flutter/material.dart';
import 'package:titawin/application/helper/color_helper.dart';

class Headline extends StatelessWidget {
  const Headline({Key? key, required this.title, required this.product})
      : super(key: key);

  final String title;
  final String product;

  @override
  Widget build(BuildContext context) => SizedBox(
        height: 66,
        child: Container(
            color: ColorHelper().getHeadLineColor(),
            padding: const EdgeInsets.only(left: 16, right: 16),
            child: Center(
              child: SelectableText(
                "$title $product",
                style: const TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
            )),
      );
}
