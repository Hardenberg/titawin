import 'package:flutter/material.dart';
import 'package:titawin/application/helper.dart';
import 'package:titawin/components/campatible.dart';
import 'package:titawin/components/result_container.dart';
import 'package:window_manager/window_manager.dart';
import 'dart:io';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await windowManager.ensureInitialized();

  WindowOptions windowOptions = WindowOptions(
    size: Size(800, 600),
    center: true,
    backgroundColor: Colors.transparent,
    skipTaskbar: true,
    titleBarStyle: TitleBarStyle.hidden,
    alwaysOnTop: true,
  );

  windowManager.waitUntilReadyToShow(windowOptions, () async {
    await windowManager.show();
    await windowManager.focus();
  });

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: Scaffold(
          appBar: AppBar(
            title: const Text(
              'Titawin - System Requirements Checker - 0.1 Beta',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            backgroundColor: Colors.orange.shade400,
            actions: [
              Padding(
                padding: EdgeInsets.only(right: 8),
                child: IconButton(
                  icon: const Icon(Icons.cancel),
                  onPressed: () async {
                    exit(0);
                  },
                ),
              )
            ],
          ),
          body: ColoredBox(
              color: Colors.orange.shade300,
              child: FutureBuilder<ProcessResult>(
                future: Process.run('Powershell.exe', [
                  '(Get-WmiObject -Class Win32_PhysicalMemory | Measure-Object -Property Capacity -Sum | Select-Object -ExpandProperty Sum) / 1GB'
                ]),
                builder: (BuildContext context,
                    AsyncSnapshot<ProcessResult> snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.waiting:
                      return const Text('Loading....');
                    default:
                      var result = 0;
                      if (snapshot.hasError)
                        return Text('Error: ${snapshot.error}');
                      else
                        result = int.parse(snapshot.data!.stdout.toString());
                      var compare = Helper().loadAsset();

                      return ResultContainer(result: result);

                    // if (result > 4)
                    //   return Column(
                    //     children: [
                    //       SizedBox(
                    //         height: 100,
                    //       ),
                    //       Compatible(),
                    //       SizedBox(
                    //         height: 70,
                    //       ),
                    //       Row(
                    //         mainAxisAlignment: MainAxisAlignment.center,
                    //         children: [
                    //           Center(
                    //               child: Icon(
                    //             Icons.check_circle,
                    //             color: Colors.green,
                    //             size: 100,
                    //           )),
                    //           SizedBox(
                    //             width: 20,
                    //           ),
                    //           Text("RAM: $result GB",
                    //               style: TextStyle(
                    //                   fontSize: 30,
                    //                   fontWeight: FontWeight.bold))
                    //         ],
                    //       )
                    //     ],
                    //   );
                    // else
                    //   return Column(
                    //     children: [
                    //       SizedBox(
                    //         height: 100,
                    //       ),
                    //       Center(
                    //         child: Text(
                    //           "Your PC is not compatible with .....",
                    //           style: TextStyle(
                    //               fontSize: 30, fontWeight: FontWeight.bold),
                    //         ),
                    //       ),
                    //       SizedBox(
                    //         height: 70,
                    //       ),
                    //       Row(
                    //         mainAxisAlignment: MainAxisAlignment.center,
                    //         children: [
                    //           Center(
                    //               child: Icon(
                    //             Icons.check_circle,
                    //             color: Colors.red,
                    //             size: 100,
                    //           )),
                    //           SizedBox(
                    //             width: 20,
                    //           ),
                    //           Text("RAM: $result GB",
                    //               style: TextStyle(
                    //                   fontSize: 30,
                    //                   fontWeight: FontWeight.bold))
                    //         ],
                    //       )
                    //     ],
                    //   );
                  }
                },
              )),
        ));
  }
}
