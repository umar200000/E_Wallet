import 'package:flutter/material.dart';
import 'package:money_counter/hive_repo/hive_repo.dart';
import 'package:money_counter/main_pages/add_items_page.dart';
import 'package:money_counter/wallet_model/model.dart';

import '../helper_widgets/got_items_list.dart';
import '../helper_widgets/month_page.dart';
import '../helper_widgets/spended_money_page.dart';
import '../helper_widgets/target_salory_page.dart';
import 'package:month_picker_dialog/month_picker_dialog.dart';

class MyWalletPage extends StatefulWidget {
  const MyWalletPage({super.key});

  @override
  State<MyWalletPage> createState() => _MyWalletPageState();
}

class _MyWalletPageState extends State<MyWalletPage> {
  DateTime _dateTime = DateTime.now();
  BoughtItemsList boughtItemsList = BoughtItemsList();
  TextEditingController textEditingController = TextEditingController();
  Map<String, String> mapList = {};
  HiveRepo hiveRepo = HiveRepo();

  @override
  void initState() {
    mapList = hiveRepo.getMap();
    fixMoneyByDateTime();
    super.initState();
  }

  void chooseMonth(BuildContext context) {
    showMonthPicker(
      context: context,
      initialDate: _dateTime,
      firstDate: DateTime(2023),
      lastDate: DateTime(2025),
    ).then((value) {
      if (value != null) {
        setState(() {
          _dateTime = value;
          fixMoneyByDateTime();
        });
      }
    });
  }

  void fixMoneyByDateTime() {
    if (mapList.containsKey("${_dateTime.year}${_dateTime.month}")) {
      textEditingController.text =
          mapList["${_dateTime.year}${_dateTime.month}"]!;
    } else {
      mapList["${_dateTime.year}${_dateTime.month}"] = "10000000";
      textEditingController.text = "10000000";
      hiveRepo.saveMap(mapList);
    }
  }

  void goBackOneMonth() {
    setState(() {
      _dateTime = DateTime(_dateTime.year, _dateTime.month - 1);
      fixMoneyByDateTime();
    });
  }

  void goForwardOneMonth() {
    setState(() {
      _dateTime = DateTime(_dateTime.year, _dateTime.month + 1);
      fixMoneyByDateTime();
    });
  }

  String calculateMoney() {
    int sum = 0;
    boughtItemsList.getbyTime(_dateTime).forEach((element) {
      sum += int.parse(element.moneyAmount);
    });
    return sum.toString();
  }

  void showModelSheet10(BuildContext context) {
    String str = textEditingController.text;
    showModalBottomSheet(
        isScrollControlled: true,
        isDismissible: false,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
        context: context,
        builder: (ctx) {
          return SingleChildScrollView(
            padding: EdgeInsets.only(
              left: 16,
              right: 16,
              bottom: MediaQuery.of(context).size.height / 2,
              // bottom: MediaQuery.of(context).viewInsets.bottom > 0
              //     ? MediaQuery.of(context).viewInsets.bottom
              //     : 200,
            ),
            child: Column(
              children: [
                TextField(
                  controller: textEditingController,
                  keyboardType: TextInputType.number,
                  decoration:
                      InputDecoration(labelText: "Oylik byudjet miqdori"),
                ),
                SizedBox(
                  height: 5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    TextButton(
                      onPressed: () {
                        setState(() {
                          textEditingController.text = str;
                          Navigator.pop(context);
                        });
                      },
                      child: Text("BEKOR QILISH"),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xff674FA3),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5)),
                      ),
                      onPressed: () {
                        setState(() {
                          mapList["${_dateTime.year}${_dateTime.month}"] =
                              textEditingController.text;
                          hiveRepo.saveMap(mapList);
                          Navigator.pop(context);
                        });
                      },
                      child: Text(
                        "KIRITISH",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        });
  }

  void addItemsFunction(
      String name, String money, Icon icon, DateTime dateTime) {
    setState(() {
      boughtItemsList.addItem(name, money, icon, dateTime);
    });
  }

  void addItemModelSheet(BuildContext context) {
    showModalBottomSheet(
        isDismissible: false,
        isScrollControlled: true,
        context: context,
        builder: (ctx) {
          return AddItemsPage(addItemsFunction);
        });
  }

  void removeItemFromList(String id) {
    setState(() {
      boughtItemsList.itemsList.removeWhere((element) => element.id == id);
      hiveRepo.saveMoneyList(boughtItemsList.itemsList);
    });
  }

  @override
  Widget build(BuildContext context) {
    mapList.forEach((key, value) {
      print("key: $key,      value: $value");
    });
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff674FA3),
        title: const Text(
          "Mening Hamyonim",
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              addItemModelSheet(context);
            },
            icon: const Icon(
              Icons.add,
              color: Colors.white,
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          SizedBox(
            height: 30,
          ),
          MonthPage(_dateTime, chooseMonth),
          SizedBox(
            height: 25,
          ),
          SpandedMoneyPage(goBackOneMonth, goForwardOneMonth, calculateMoney()),
          SizedBox(
            height: 20,
          ),
          Expanded(
            child: Stack(
              children: [
                SaloryPage(showModelSheet10, textEditingController.text,
                    int.parse(calculateMoney())),
                GotItemsList(
                    boughtItemsList.getbyTime(_dateTime), removeItemFromList),
              ],
            ),
          )
        ],
      ),
    );
  }
}
