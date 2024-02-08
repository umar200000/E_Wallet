import 'package:flutter/material.dart';
import 'package:money_counter/helper_widgets/items_list.dart';

import '../wallet_model/model.dart';

class GotItemsList extends StatelessWidget {
  final List<MoneyModel> list;
  final void Function(String id) removeItemFromList;
  const GotItemsList(this.list, this.removeItemFromList, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 100),
      child: Container(
        padding: EdgeInsets.symmetric(
          vertical: 25,
          horizontal: 5,
        ),
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(50)),
        ),
        child: ListView.builder(
          itemBuilder: (context, index) {
            return Dismissible(
              direction: DismissDirection.endToStart,
              key: ValueKey<MoneyModel>(list[index]),
              child: ItemsList(list[index]),
              background: Container(
                padding: EdgeInsets.only(right: 10),
                color: Color(0xffCE282B),
                alignment: Alignment.centerRight,
                child: Icon(
                  Icons.delete,
                  size: 30,
                  color: Colors.white,
                ),
              ),
              onDismissed: (DismissDirection direction) {
                removeItemFromList(list[index].id);
              },
            );
          },
          itemCount: list.length,
        ),
      ),
    );
  }
}
