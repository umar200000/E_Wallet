import 'package:flutter/material.dart';

class SpandedMoneyPage extends StatelessWidget {
  final void Function() goBackOneMonth;
  final void Function() goForwardOneMonth;
  final String sum;
  const SpandedMoneyPage(this.goBackOneMonth, this.goForwardOneMonth, this.sum,
      {super.key});

  String formatMoney() {
    String str = "";
    int b = 0;
    for (int i = sum.length - 1; i >= 0; i--) {
      if (b == 3) {
        b = 0;
        str += ',';
      }
      b++;
      str += sum[i];
    }

    return str.split("").reversed.join();
  }

  @override
  Widget build(BuildContext context) {
    String str = formatMoney();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          IconButton(
            onPressed: () {
              goBackOneMonth();
            },
            icon: Image.asset(
              "assets/icons/arrow-left.png",
              height: 40,
            ),
          ),
          Expanded(
            child: Stack(
              alignment: Alignment.topCenter,
              children: [
                Text(
                  str,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 40,
                  ),
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: Padding(
                    padding: EdgeInsets.only(
                      top: 42,
                    ),
                    child: Text(
                      "so'm",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: () {
              goForwardOneMonth();
            },
            icon: Image.asset(
              "assets/icons/right.png",
              height: 40,
            ),
          ),
        ],
      ),
    );
  }
}
