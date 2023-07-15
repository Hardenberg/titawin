import 'package:flutter/material.dart';
import 'package:titawin/check/model/check_model.dart';
import 'package:titawin/check/model/testarray_model.dart';
import 'package:titawin/check/service/check_service.dart';
import 'package:titawin/check/view/check_item_model.dart';

class CheckItem extends StatefulWidget {
  final TestArray testArray;

  const CheckItem({required this.testArray});

  @override
  _CheckItemState createState() => _CheckItemState();
}

class _CheckItemState extends State<CheckItem> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Check>(
      future: CheckService().executeCheck(widget.testArray),
      builder: (BuildContext context, AsyncSnapshot<Check> snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return Column(children: [
              SizedBox(
                height: 55,
              ),
              Center(
                child: CircularProgressIndicator(),
              ),
            ]);
          default:
            if (snapshot.hasError) return Text('Error: ${snapshot.error}');
            Check result = snapshot.data!;

            return CheckItemModel(
              message: result.message,
              isOk: result.isOk,
            );
        }
      },
    );
  }
}
