import 'package:flutter/services.dart' show rootBundle;

class Helper {
  Future<String> loadAsset() async {
    return await rootBundle.loadString('assets/config.json');
  }
}
