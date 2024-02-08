import 'package:flutter/material.dart';
import 'package:money_counter/wallet_model/model.dart';
import 'package:intl/intl.dart';

class ItemsList extends StatelessWidget {
  final MoneyModel model;
  const ItemsList(this.model, {super.key});

  String formatMoney() {
    String str = "";
    int b = 0;

    for (int i = model.moneyAmount.length - 1; i >= 0; i--) {
      if (b == 3) {
        b = 0;
        str += ',';
      }
      b++;
      str += model.moneyAmount[i];
    }

    return str.split("").reversed.join();
  }

  @override
  Widget build(BuildContext context) {
    String money = formatMoney() + " so'm";
    return ListTile(
      leading: model.icon,
      title: Text(
        model.itemName,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ),
      ),
      subtitle: Text(DateFormat("d-MMMM-yyyy").format(model.dateTime)),
      trailing: Text(
        money,
        style: TextStyle(fontSize: 15),
      ),
    );
  }
}
