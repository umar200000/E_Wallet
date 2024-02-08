import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:money_counter/hive_repo/hive_repo.dart';
import 'package:money_counter/main_pages/my_wallet_page.dart';
import "package:hive/hive.dart";
import "package:hive_flutter/hive_flutter.dart";
import 'package:money_counter/wallet_model/model.dart';

main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Hive.openBox("myWallet");

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyWalletPage(),
    );
  }
}
