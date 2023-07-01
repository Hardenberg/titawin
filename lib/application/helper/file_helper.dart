import 'package:flutter/services.dart' show rootBundle;

class FileHelper {
  Future<String> loadAsset() async {
    return await rootBundle.loadString('assets/config.json');
  }
}
