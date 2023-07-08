import 'dart:io';

import 'package:titawin/application/contraints.dart';
import 'package:titawin/check/model/check_model.dart';
import 'package:titawin/check/model/compare_model.dart';

abstract class ICheckService {
  Future<Check> executeCheck(String cmd, Compare compare, String type,
      String okText, String notOkText);
}

class CheckService implements ICheckService {
  @override
  Future<Check> executeCheck(String cmd, Compare compare, String type,
      String okText, String notOkText) async {
    var tmp = false;
    var result = await Process.run(mapType(type), [cmd]);

    if (compare.type == "number") {
      tmp = calcNumber(int.parse(result.stdout.toString()), compare.operator,
          int.parse(compare.value));
    } else if (compare.type == "regex") {
      tmp = calcRegex(result.stdout.toString(), compare.value);
    } else {
      error(null);
    }
    if (tmp) {
      return Check(isOk: true, message: okText);
    } else {
      return Check(isOk: false, message: notOkText);
    }
  }

  String mapType(type) {
    if (type == "ps") return Constraints.powershell;

    throw Exception("type not found");
  }

  bool calcNumber(int real, String compare, int value) {
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

  bool calcRegex(String regex, String patter) {
    return RegExp(patter).hasMatch(regex);
  }

  Check error(String? message) {
    var tmp = message ?? "Error";
    return Check(isOk: false, message: tmp);
  }
}
