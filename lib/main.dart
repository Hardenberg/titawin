import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:window_manager/window_manager.dart';
import 'dart:io';
import 'dart:html' as html;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (!kIsWeb) {
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
  }
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
                  onPressed: () {
                    if (!kIsWeb) exit(0);
                    html.window.open('https://google.de', '_self');
                  },
                ),
              )
            ],
          ),
          body: ColoredBox(
            color: Colors.orange.shade300,
            child: Center(
              child: Text(
                'Hello, world!',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
            ),
          ),
        ));
  }
}
