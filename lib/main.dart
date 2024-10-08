import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:money_flow/model/advisor/advisor.dart';
import 'package:money_flow/model/expense/expense.dart';
import 'package:money_flow/model/income/income.dart';
import 'package:money_flow/model/user/user.dart';
import 'package:money_flow/view/analysis.dart';
import 'package:money_flow/view/home_screen.dart';
import 'package:money_flow/view/login.dart';
// import 'package:money_flow/view/profile.dart';
import 'package:money_flow/view/splash.dart';
import 'package:money_flow/view/startscreen.dart';
import 'package:money_flow/view/widgets/addbudget.dart';
import 'package:money_flow/view/widgets/adddata.dart';
import 'package:money_flow/view/widgets/bottom.dart';
// import 'package:money_flow/view/widgets/form.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(UserAdapter());
  Hive.registerAdapter(ExpenseAdapter());
  Hive.registerAdapter(IncomeAdapter());
  Hive.registerAdapter(BudgetSetterAdapter());
  runApp(MyApp());
}

bool isLoggedIn = false;

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Money Flow',
      theme: ThemeData(primarySwatch: Colors.brown),
      home: SplashScreen(),
      routes: {
        '/login': (context) => LoginScreen(),
        '/home': (context) => Homescreen(),
        '/analysis': (context) => analsys(),
        '/bottom': (context) => Bottombar(),
        '/start': (context) => Startscreen(),
        '/adddata': (context) => AddData(),
        'addbudget': (context) => AddBudget(),
      },
    );
  }
}
