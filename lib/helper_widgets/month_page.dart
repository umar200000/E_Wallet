import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MonthPage extends StatelessWidget {
  final DateTime dateTime;
  final void Function(BuildContext context) chooseMonth;
  const MonthPage(this.dateTime, this.chooseMonth, {super.key});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        chooseMonth(context);
      },
      child: RichText(
        text: TextSpan(
            style: TextStyle(
              color: Colors.black,
              fontSize: 24,
            ),
            children: [
              TextSpan(
                text: DateFormat("MMMM, ").format(dateTime),
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextSpan(
                text: DateFormat("yyyy").format(dateTime),
              ),
            ]),
      ),
    );
  }
}
