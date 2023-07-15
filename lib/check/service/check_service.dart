import 'dart:io';

import 'package:titawin/application/static/constraints.dart';
import 'package:titawin/check/model/check_model.dart';
import 'package:titawin/check/model/testarray_model.dart';

abstract class ICheckService {
  Future<Check> executeCheck(TestArray array);
}

class CheckService implements ICheckService {
  @override
  Future<Check> executeCheck(TestArray array) async {
    var tmp = false;

    if (array.children.length > 0) {
      for (var item in array.children) {
        var tmp = await executeCheck(item);
        if (!tmp.isOk) {
          return Check(isOk: false, message: array.notOkText);
        }
      }
    }

    var result = await Process.run(mapType(array.type), [array.execute]);

    if (array.compare.type == Constraints.compare_number) {
      tmp = calcNumber(int.parse(result.stdout.toString()),
          array.compare.operator, int.parse(array.compare.value));
    } else if (array.compare.type == Constraints.compare_regex) {
      tmp = calcRegex(result.stdout.toString(), array.compare.value);
    } else {
      error(null);
    }

    return tmp
        ? Check(isOk: true, message: array.okText)
        : Check(isOk: false, message: array.notOkText);
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

  bool calcRegex(String string, String regEx) {
    return RegExp(regEx).hasMatch(string);
  }

  Check error(String? message) {
    return Check(isOk: false, message: message ?? "Error");
  }
}
