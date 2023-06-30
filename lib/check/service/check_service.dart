import 'dart:io';

import 'package:titawin/application/contraints.dart';
import 'package:titawin/check/model/check_model.dart';

abstract class ICheckService {
  Future<Check> executeCheck(String cmd, String compare, String value,
      String type, String okText, String notOkText);
}

class CheckService implements ICheckService {
  @override
  Future<Check> executeCheck(String cmd, String compare, String value,
      String type, String okText, String notOkText) async {
    var result = await Process.run(mapType(type), [cmd]);

    var tmp =
        calc(int.parse(result.stdout.toString()), compare, int.parse(value));
    if (tmp) {
      return Check(isOk: true, message: okText);
    } else {
      return Check(isOk: false, message: notOkText);
    }
  }

  String mapType(type) {
    if (type == "ps") return Constraints.powershell;

    throw Exception("Type not found");
  }

  bool calc(int real, String compare, int value) {
    switch (compare) {
      case "=":
        return real == value;

      case "!=":
        return real != value;
      case "<":
        return real < value;
      case "<=":
        return real <= value;
      case ">":
        return real > value;
      case ">=":
        return real >= value;
      default:
        return false;
    }
  }
}
