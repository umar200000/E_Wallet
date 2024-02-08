import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_iconpicker/flutter_iconpicker.dart';

class AddItemsPage extends StatefulWidget {
  final void Function(
          String itemName, String moneyAmount, Icon icon, DateTime dateTime)
      addItems;
  const AddItemsPage(this.addItems, {super.key});

  @override
  State<AddItemsPage> createState() => _AddItemsPageState();
}

class _AddItemsPageState extends State<AddItemsPage> {
  TextEditingController itemName10 = TextEditingController();
  TextEditingController moneyAmount10 = TextEditingController();
  DateTime? _dateTime10;
  Icon? _icon;

  _pickIcon() async {
    IconData? icon = await FlutterIconPicker.showIconPicker(context,
        iconPackModes: [IconPack.cupertino]);

    if (icon != null) {
      _icon = Icon(
        icon,
        size: 30,
      );
    }
    setState(() {});

    debugPrint('Picked Icon:  $icon');
  }

  void chooseCalendar(BuildContext context) {
    showDatePicker(
      context: context,
      firstDate: DateTime(2023),
      lastDate: DateTime.now(),
      initialDate: DateTime.now(),
    ).then((value) {
      if (value != null) {
        setState(() {
          _dateTime10 = value;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.only(
          left: 10.0,
          right: 10,
          bottom: MediaQuery.of(context).viewInsets.bottom > 0
              ? MediaQuery.of(context).viewInsets.bottom
              : 50,
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 160,
                  child: TextField(
                    controller: itemName10,
                    decoration: InputDecoration(labelText: "Xarajat nomi"),
                  ),
                ),
                Container(
                  width: 160,
                  child: TextField(
                    keyboardType: TextInputType.number,
                    controller: moneyAmount10,
                    decoration: InputDecoration(
                      labelText: "Xarajat miqdori",
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(_dateTime10 == null
                    ? "Xarajat kuni tanlanmadi!"
                    : "Xarajat kuni: ${DateFormat("MMMM d, yyyy").format(_dateTime10!)}"),
                TextButton(
                  onPressed: () {
                    chooseCalendar(context);
                  },
                  child: Text("KUNNI TANLASH"),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _icon == null ? Text("Icon tanlanmagan!") : _icon!,
                TextButton(
                  onPressed: () {
                    _pickIcon();
                  },
                  child: Text("ICON TANLASH"),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
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
                    if (itemName10.text.isNotEmpty &&
                        moneyAmount10.text.isNotEmpty &&
                        _icon != null &&
                        _dateTime10 != null) {
                      widget.addItems(itemName10.text, moneyAmount10.text,
                          _icon!, _dateTime10!);
                      Navigator.pop(context);
                    }
                  },
                  child: Text(
                    "KIRITISH",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
