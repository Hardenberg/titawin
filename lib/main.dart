import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:titawin/appbar/app_bar.dart';
import 'package:titawin/application/application.dart';
import 'package:window_manager/window_manager.dart';
import 'package:titawin/check/check.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await windowManager.ensureInitialized();
  await windowManager.setIcon('assets/icon.png');
  WindowOptions windowOptions = WindowOptions(
      size: Size(1024, 800),
      minimumSize: Size(800, 600),
      center: true,
      backgroundColor: Colors.transparent,
      skipTaskbar: true,
      titleBarStyle: TitleBarStyle.hidden,
      alwaysOnTop: true,
      title: '');

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
          colorScheme:
              ColorScheme.fromSeed(seedColor: Colors.blueAccent.shade100),
          useMaterial3: true,
        ),
        home: Scaffold(
            appBar: TitaAppBar(),
            body: Container(
                color: Theme.of(context).colorScheme.onSecondary,
                child: Center(
                    child: FutureBuilder(
                  future: FileHelper().loadAsset(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      var data = jsonDecode(snapshot.data.toString());
                      var flatten =
                          AdapterService().buildList(data['test_array']);

                      var tree = AdapterService().reOrgList(flatten);

                      ListView list = ListView.builder(
                          itemCount: tree.length,
                          itemBuilder: (context, index) {
                            return CheckItem(testArray: tree[index]);
                          });

                      return Column(
                        children: [
                          GradientBox(
                              from: ColorHelper().getAppBarColor(),
                              to: ColorHelper().getHeadLineColor()),
                          Headline(
                              title: data['headline'],
                              product: data['product']),
                          GradientBox(
                              from: ColorHelper().getHeadLineColor(),
                              to: ColorHelper().getBodyColor(context)),
                          SizedBox(
                            height: 24,
                          ),
                          Expanded(
                            child: list,
                          ),
                        ],
                      );
                    }
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  },
                )))));
  }
}
