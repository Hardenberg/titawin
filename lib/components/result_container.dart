import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:titawin/components/campatible.dart';

import '../application/helper.dart';

class ResultContainer extends StatefulWidget {
  final int result;
  const ResultContainer({Key? key, required this.result}) : super(key: key);

  @override
  _ResultContainerState createState() => _ResultContainerState();
}

class _ResultContainerState extends State<ResultContainer> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Helper().loadAsset(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          var data = jsonDecode(snapshot.data.toString());
          if (widget.result >= int.parse(data['ram_test_gb'].toString()))
            return Column(
              children: [
                SizedBox(
                  height: 100,
                ),
                Compatible(check: true),
                SizedBox(
                  height: 70,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(
                        child: Icon(
                      Icons.check_circle,
                      color: Colors.green,
                      size: 100,
                    )),
                    SizedBox(
                      width: 20,
                    ),
                    Text("RAM:" + widget.result.toString() + "GB",
                        style: TextStyle(
                            fontSize: 30, fontWeight: FontWeight.bold))
                  ],
                )
              ],
            );
          else
            return Column(
              children: [
                SizedBox(
                  height: 100,
                ),
                Compatible(check: false),
                SizedBox(
                  height: 70,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(
                        child: Icon(
                      Icons.cancel,
                      color: Colors.red,
                      size: 100,
                    )),
                    SizedBox(
                      width: 20,
                    ),
                    Text("RAM:" + widget.result.toString() + "GB",
                        style: TextStyle(
                            fontSize: 30, fontWeight: FontWeight.bold))
                  ],
                )
              ],
            );
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
