import 'package:flutter/material.dart';
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
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: Scaffold(
          appBar: AppBar(
            title: const Text(
              'Titawin - System Requirements Checker',
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
                ]), // async work
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
                      if (result > 32)
                        return Center(
                            child: Icon(
                          Icons.check_circle,
                          color: Colors.green,
                          size: 100,
                        ));
                      else
                        return Center(
                            child: Icon(
                          Icons.cancel,
                          color: Colors.red,
                          size: 100,
                        ));
                  }
                },
              )),
        ));
  }
}
