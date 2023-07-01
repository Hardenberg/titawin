import 'dart:io';

import 'package:flutter/material.dart';
import 'package:titawin/application/helper/color_helper.dart';

class TitaAppBar extends AppBar {
  @override
  Widget? get title => const Text(
        'Titawin - System Requirements Checker',
        style: TextStyle(fontWeight: FontWeight.bold),
      );

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
