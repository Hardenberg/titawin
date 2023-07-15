import 'package:titawin/check/model/compare_model.dart';
import 'package:titawin/check/model/testarray_model.dart';

class AdapterService {
  List<TestArray> buildList(data) {
    if (data != null) {
      List<TestArray> list = [];
      for (var item in data) {
        list.add(TestArray(
          item['id'],
          item['type'],
          item['execute'],
          Compare(
              type: item['compare']['type'],
              operator: item['compare']['operator'],
              value: item['compare']['value']),
          item['ok_text'],
          item['not_ok_text'],
          [],
          item['parent'],
        ));
      }
      return list;
    }
    return [];
  }

  List<TestArray> reOrgList(List<TestArray> objList) {
    List<TestArray> list = [];
    for (var i = 0; i < objList.length; i++) {
      if (objList[i].parent == "") {
        objList[i].children = recursiveOrgList(objList[i].id, objList);
        list.add(objList[i]);
      }
    }

    return list;
  }

  List<TestArray> recursiveOrgList(String rootId, List<TestArray> objList) {
    List<TestArray> list = [];
    for (var i = 0; i < objList.length; i++) {
      if (objList[i].parent == rootId) {
        objList[i].children = recursiveOrgList(objList[i].id, objList);
        list.add(objList[i]);
      }
    }
    return list;
  }
}
