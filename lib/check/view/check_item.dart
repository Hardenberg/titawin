import 'package:flutter/material.dart';
import 'package:titawin/check/model/check_model.dart';
import 'package:titawin/check/service/check_service.dart';

class CheckItem extends StatefulWidget {
  final String type;
  final String execute;
  final String compare;
  final String value;
  final String okText;
  final String notOkText;

  const CheckItem(
      {Key? key,
      required this.type,
      required this.execute,
      required this.compare,
      required this.value,
      required this.okText,
      required this.notOkText})
      : super(key: key);

  @override
  _CheckItemState createState() => _CheckItemState();
}

class _CheckItemState extends State<CheckItem> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Check>(
      future: CheckService().executeCheck(widget.execute, widget.compare,
          widget.value, widget.type, widget.okText, widget.notOkText),
      builder: (BuildContext context, AsyncSnapshot<Check> snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return Column(children: [
              SizedBox(
                height: 32,
              ),
              Center(
                child: CircularProgressIndicator(),
              ),
            ]);
          default:
            Check result = snapshot.data!;

            if (snapshot.hasError) return Text('Error: ${snapshot.error}');
            if (result.isOk) {
              return SizedBox(
                height: 100,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      flex: 1,
                      child: Center(
                        child: Icon(
                          Icons.check_circle,
                          color: Colors.green,
                          size: 100,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Expanded(
                        flex: 2,
                        child: Text(result.message,
                            style: TextStyle(
                                fontSize: 24, fontWeight: FontWeight.bold)))
                  ],
                ),
              );
            } else {
              return SizedBox(
                height: 100,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      flex: 1,
                      child: Center(
                        child: Icon(
                          Icons.cancel,
                          color: Colors.red,
                          size: 100,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Expanded(
                        flex: 2,
                        child: Text(result.message,
                            style: TextStyle(
                                fontSize: 24, fontWeight: FontWeight.bold)))
                  ],
                ),
              );
            }
        }
      },
    );
  }
}
