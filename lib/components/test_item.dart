import 'dart:io';

import 'package:flutter/material.dart';
import 'package:titawin/components/result_container.dart';

class TestItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<ProcessResult>(
      future: Process.run('Powershell.exe', [
        '(Get-WmiObject -Class Win32_PhysicalMemory | Measure-Object -Property Capacity -Sum | Select-Object -ExpandProperty Sum) / 1GB'
      ]),
      builder: (BuildContext context, AsyncSnapshot<ProcessResult> snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return const Text('Loading....');
          default:
            var result = 0;
            if (snapshot.hasError)
              return Text('Error: ${snapshot.error}');
            else
              result = int.parse(snapshot.data!.stdout.toString());

            return ResultContainer(result: result);
        }
      },
    );
  }
}
