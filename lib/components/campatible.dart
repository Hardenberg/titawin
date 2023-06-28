import 'package:flutter/material.dart';
import 'package:titawin/application/helper.dart';
import 'dart:convert';

class Compatible extends StatefulWidget {
  final bool check;

  const Compatible({Key? key, required bool this.check}) : super(key: key);

  @override
  _CompatibleState createState() => _CompatibleState();
}

class _CompatibleState extends State<Compatible> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Helper().loadAsset(),
      builder: (context, snapshot) {
        var text = "";
        if (widget.check == true)
          text = "compatible";
        else
          text = "not compatible";
        if (snapshot.connectionState == ConnectionState.done) {
          var data = jsonDecode(snapshot.data.toString());
          return Center(
            child: Text(
              "Your PC is " +
                  text +
                  " with " +
                  data['compatible_name'].toString(),
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
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
