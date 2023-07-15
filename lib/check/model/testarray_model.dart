import 'package:titawin/check/model/compare_model.dart';

class TestArray {
  final String id;
  final String? parent;
  final String type;
  final String execute;
  final Compare compare;
  final String okText;
  final String notOkText;
  var children = <TestArray>[];

  TestArray(this.id, this.type, this.execute, this.compare, this.okText,
      this.notOkText, this.children, this.parent);
}
