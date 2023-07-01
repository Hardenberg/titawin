import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:titawin/appbar/app_bar.dart';
import 'package:titawin/application/helper.dart';
import 'package:titawin/application/view/headline.dart';
import 'package:titawin/check/view/check_item.dart';
import 'package:window_manager/window_manager.dart';

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
                  future: Helper().loadAsset(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      var data = jsonDecode(snapshot.data.toString());
                      ListView list = ListView.builder(
                          itemCount: data['test_array'].length,
                          itemBuilder: (context, index) {
                            return CheckItem(
                              type: data['test_array'][index]['type'],
                              execute: data['test_array'][index]['execute'],
                              compare: data['test_array'][index]['compare'],
                              value: data['test_array'][index]['value'],
                              okText: data['test_array'][index]['ok_text'],
                              notOkText: data['test_array'][index]
                                  ['not_ok_text'],
                            );
                          });

                      return Column(
                        children: [
                          Headline(
                              title: data['headline'],
                              product: data['product']),
                          SizedBox(
                            height: 32,
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
