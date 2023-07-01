import 'dart:io';

import 'package:flutter/material.dart';

class TitaAppBar extends AppBar {
  @override
  Widget? get title => const Text(
        'Titawin - System Requirements Checker',
        style: TextStyle(fontWeight: FontWeight.bold),
      );

  @override
  Color? get backgroundColor => Colors.blueAccent.shade100;

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
