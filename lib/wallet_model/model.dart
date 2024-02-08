import 'package:flutter/material.dart';
import 'package:money_counter/hive_repo/hive_repo.dart';
import 'package:flutter/cupertino.dart';

class MoneyModel {
  final String id;
  final Icon icon;
  final String itemName;
  final DateTime dateTime;
  final String moneyAmount;

  MoneyModel({
    required this.id,
    required this.icon,
    required this.itemName,
    required this.dateTime,
    required this.moneyAmount,
  });

  Map<String, dynamic> toJson() {
    print(icon.icon?.codePoint);
    return {
      "id": id,
      "iconCode": icon.icon!.codePoint,
      "itemName": itemName,
      "dateTime": dateTime.millisecondsSinceEpoch,
      "moneyAmount": moneyAmount,
    };
  }

  factory MoneyModel.fromJson(Map<String, dynamic> data) {
    print(data["iconCode"]);
    return MoneyModel(
      id: data["id"],
      icon: Icon(
        IconData(
          data["iconCode"],
          fontFamily: CupertinoIcons.iconFont,
          fontPackage: CupertinoIcons.iconFontPackage,
        ),
        size: 30,
      ),
      itemName: data['itemName'],
      dateTime: DateTime.fromMillisecondsSinceEpoch(data["dateTime"]),
      moneyAmount: data['moneyAmount'],
    );
  }
}

class BoughtItemsList {
  List<MoneyModel> itemsList = HiveRepo().getMoneyList();

  void addItem(
      String itemName, String moneyAmount, Icon icon, DateTime dateTime) {
    itemsList.add(MoneyModel(
      id: "id${itemsList.length + 1}",
      icon: icon,
      itemName: itemName,
      dateTime: dateTime,
      moneyAmount: moneyAmount,
    ));
    HiveRepo().saveMoneyList(itemsList);
  }

  List<MoneyModel> getbyTime(DateTime dateTime) {
    return itemsList
        .where((element) => element.dateTime.month == dateTime.month)
        .toList();
  }
}
