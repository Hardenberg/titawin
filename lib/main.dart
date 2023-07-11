import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:titawin/appbar/app_bar.dart';
import 'package:titawin/application/helper/color_helper.dart';
import 'package:titawin/application/helper/file_helper.dart';
import 'package:titawin/application/view/gradient_box.dart';
import 'package:titawin/application/view/headline.dart';
import 'package:titawin/check/model/compare_model.dart';
import 'package:titawin/check/view/check_item.dart';
import 'package:window_manager/window_manager.dart';

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
                      ListView list = ListView.builder(
                          itemCount: data['test_array'].length,
                          itemBuilder: (context, index) {
                            Compare compare = Compare(
                                type: data['test_array'][index]['compare']
                                    ['type'],
                                value: data['test_array'][index]['compare']
                                    ['value'],
                                operator: data['test_array'][index]['compare']
                                    ['operator']);
                            return CheckItem(
                              type: data['test_array'][index]['type'],
                              execute: data['test_array'][index]['execute'],
                              compare: compare,
                              okText: data['test_array'][index]['ok_text'],
                              notOkText: data['test_array'][index]
                                  ['not_ok_text'],
                            );
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
