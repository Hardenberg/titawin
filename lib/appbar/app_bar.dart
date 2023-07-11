import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:titawin/application/contraints.dart';
import 'package:titawin/application/helper/color_helper.dart';
import 'package:titawin/application/helper/file_helper.dart';

class TitaAppBar extends AppBar {
  @override
  Widget? get title => FutureBuilder(
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          var data = jsonDecode(snapshot.data.toString());
          return Text(
            '${Constraints.app_title} ${data['title']}',
            style: TextStyle(fontWeight: FontWeight.bold),
          );
        }
        return Text(
          Constraints.app_title,
          style: TextStyle(fontWeight: FontWeight.bold),
        );
      },
      future: FileHelper().loadAsset());

  @override
  Color? get backgroundColor => ColorHelper().getAppBarColor();

  @override
  List<Widget>? get actions => [
        Padding(
          padding: EdgeInsets.only(right: 8),
          child: IconButton(
            icon: const Icon(Icons.cancel),
            onPressed: () async {
              exit(0);
            },
          ),
        )
      ];
}
