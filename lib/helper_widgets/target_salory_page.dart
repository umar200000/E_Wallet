import 'package:flutter/material.dart';

class SaloryPage extends StatelessWidget {
  final void Function(BuildContext context) showModelSheet10;
  final String money;
  final int sum;
  const SaloryPage(this.showModelSheet10, this.money, this.sum, {super.key});

  String formatMoney() {
    String str = "";
    int b = 0;

    for (int i = money.length - 1; i >= 0; i--) {
      if (b == 3) {
        b = 0;
        str += ',';
      }
      b++;
      str += money[i];
    }

    return str.split("").reversed.join();
  }

  double findOutPercentage() {
    double oneMonthMoneyAmount = double.parse(money);
    double result = sum * 100 / oneMonthMoneyAmount;
    return result;
  }

  @override
  Widget build(BuildContext context) {
    double result = findOutPercentage();
    String str = formatMoney();
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 25,
        vertical: 30,
      ),
      decoration: BoxDecoration(
        color: Color(0xffEDEEFB),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(50),
          topRight: Radius.circular(50),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                "Oylik byudjet:",
                style: TextStyle(fontSize: 14),
              ),
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  elevation: 0,
                  backgroundColor: Color(0xffEDEEFB),
                  padding: EdgeInsets.only(left: 5),
                ),
                onPressed: () {
                  showModelSheet10(context);
                },
                icon: Image.asset(
                  "assets/icons/pen.png",
                  height: 20,
                ),
                label: Text(
                  "$str so'm",
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.blue,
                    decoration: TextDecoration.underline,
                    decorationColor: Colors.blue,
                  ),
                ),
              ),
              Expanded(child: SizedBox()),
              Text("${result.toStringAsFixed(1)}%")
            ],
          ),
          Row(
            children: [
              Container(
                height: 10,
                width: result < 100
                    ? (MediaQuery.of(context).size.width - 50) * result / 100
                    : (MediaQuery.of(context).size.width - 50),
                decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [
                    result < 100 ? Color(0xff674FA3) : Color(0xffF83B31),
                    result < 100 ? Color(0xff674FA3) : Color(0xffF83B31),
                    result < 100 ? Color(0xffD1BEEB) : Color(0xffF8B1AD),
                    result < 100 ? Color(0xff674FA3) : Color(0xffF83B31),
                  ]),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              Expanded(
                child: Container(
                  height: 5,
                  decoration: BoxDecoration(
                    color: Color(0xffC9D5ED),
                    borderRadius:
                        BorderRadius.horizontal(right: Radius.circular(5)),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
