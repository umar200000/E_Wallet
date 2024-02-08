import 'dart:convert';

import 'package:hive/hive.dart';

import '../wallet_model/model.dart';

class HiveRepo {
  final Box _box = Hive.box("myWallet");

  saveMoneyList(List<MoneyModel> list) {
    final List<Map<String, dynamic>> result = [];
    for (var element in list) {
      result.add(element.toJson());
    }
    _box.put("walletList", jsonEncode(result));
  }

  List<MoneyModel> getMoneyList() {
    final List<MoneyModel> list = [];
    final String result = _box.get("walletList", defaultValue: "");
    if (result.isNotEmpty) {
      final List<dynamic> json = jsonDecode(result);
      for (var element in json) {
        list.add(MoneyModel.fromJson(element));
      }
    }

    return list;
  }

  saveMap(Map<String, String> map) {
    _box.put("map10", map);
  }

  Map<String, String> getMap() {
    Map<String, String> map = {};
    Map<dynamic, dynamic> map2 =
        _box.get("map10", defaultValue: <String, String>{});
    map2.forEach((key, value) {
      map[key.toString()] = value.toString();
    });

    return map;
  }
}
