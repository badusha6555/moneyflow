import 'dart:developer';

import 'package:flutter/widgets.dart';
import 'package:hive/hive.dart';
import 'package:money_flow/model/advisor/advisor.dart';
import 'package:money_flow/model/expense/expense.dart';
import 'package:money_flow/model/income/income.dart';
import 'package:money_flow/model/user/user.dart';
// import 'package:money_flow/view/adviser.dart';

ValueNotifier<List<User>> userListNotifier = ValueNotifier([]);
ValueNotifier<List<Expense>> expenseListNotifier = ValueNotifier([]);
ValueNotifier<List<Income>> incomeListNotifier = ValueNotifier([]);
ValueNotifier<List<BudgetSetter>> budgetListNotifier = ValueNotifier([]);

Future<void> addProfile(User profile) async {
  final userDb = await Hive.openBox<User>("user_db");
  userDb.add(profile);
  userListNotifier.value.add(profile);
  userListNotifier.notifyListeners();
  getAllProfiles();
  log("profile adde : ${profile.name}");
}

Future<void> editProfile(int index, User updatedProfile) async {
  final userDb = await Hive.openBox<User>("user_db");
  userListNotifier.value.clear();
  userListNotifier.value.addAll(userDb.values);
  userDb.putAt(index, updatedProfile);
  userListNotifier.notifyListeners();
  getAllProfiles();
}

Future<void> deleteProfile(int index) async {
  final userDb = await Hive.openBox<User>("user_db");
  userDb.deleteAt(index);
  userListNotifier.value = userDb.values.toList();
  userListNotifier.notifyListeners();
  getAllProfiles();
}

Future<void> getAllProfiles() async {
  final userDb = await Hive.openBox<User>("user_db");
  userListNotifier.value.clear();
  userListNotifier.value.addAll(userDb.values);
  userListNotifier.notifyListeners();
}

Future<void> addExpense(Expense expense) async {
  final expenseDb = await Hive.openBox<Expense>("expense_db");
  await expenseDb.add(expense);
  expenseListNotifier.value.add(expense);
  expenseListNotifier.notifyListeners();
  log("expence added : ${expense.amount}");
  getAllExpenses();
}

Future<void> editExpense(int index, Expense updatedExpense) async {
  final expenseDb = await Hive.openBox<Expense>("expense_db");
  expenseListNotifier.value.clear();
  expenseListNotifier.value.addAll(expenseDb.values);
  expenseDb.putAt(index, updatedExpense);
  expenseListNotifier.notifyListeners();
  getAllExpenses();
}

Future<void> deleteExpense(int index) async {
  final expenseDb = await Hive.openBox<Expense>("expense_db");
  expenseDb.deleteAt(index);
  expenseListNotifier.value = expenseDb.values.toList();
  expenseListNotifier.notifyListeners();
  getAllExpenses();
}

Future<void> getAllExpenses() async {
  final expenseDb = await Hive.openBox<Expense>("expense_db");
  expenseListNotifier.value.clear();
  expenseListNotifier.value.addAll(expenseDb.values);
  expenseListNotifier.notifyListeners();
}

Future<void> addIncome(Income income) async {
  final incomeDb = await Hive.openBox<Income>("income_db");
  await incomeDb.add(income);
  incomeListNotifier.value.add(income);
  incomeListNotifier.notifyListeners();
  log("added income: ${income.amount}");
  // log(totolExpence() as String);

  // getAllIncomes();
}

Future<void> editIncome(int index, Income updatedIncome) async {
  final incomeDb = await Hive.openBox<Income>("income_db");
  incomeListNotifier.value.clear();
  incomeListNotifier.value.addAll(incomeDb.values);
}

Future<void> deleteIncome(int index) async {
  final incomeDb = await Hive.openBox<Income>("income_db");
  incomeDb.deleteAt(index);
  incomeListNotifier.value = incomeDb.values.toList();
  incomeListNotifier.notifyListeners();
  getAllIncomes();
}

Future<void> getAllIncomes() async {
  final incomeDb = await Hive.openBox<Income>("income_db");
  incomeListNotifier.value.clear();
  incomeListNotifier.value.addAll(incomeDb.values);
  incomeListNotifier.notifyListeners();
}

Future<void> addBudget(BudgetSetter value) async {
  final budgetDb = await Hive.openBox<BudgetSetter>("budget_db");
  await budgetDb.add(value);
  budgetListNotifier.value.add(value);
  budgetListNotifier.notifyListeners();
  log("budget added : ${value.amount}");
}

Future<void> editBudget(int index, BudgetSetter updatedBudget) async {
  final budgetDb = await Hive.openBox<BudgetSetter>("budget_db");
  budgetListNotifier.value.clear();
  budgetListNotifier.value.addAll(budgetDb.values);
}

Future<void> deleteBudget(int index) async {
  final budgetDb = await Hive.openBox<BudgetSetter>("budget_db");
  budgetDb.deleteAt(index);
  budgetListNotifier.value = budgetDb.values.toList();
  budgetListNotifier.notifyListeners();
  getAllBudgets();
}

Future<void> getAllBudgets() async {
  final budgetDb = await Hive.openBox<BudgetSetter>("budget_db");
  budgetListNotifier.value.clear();
  budgetListNotifier.value.addAll(budgetDb.values);
  budgetListNotifier.notifyListeners();
}

Future<int> totolExpence() async {
  final expenseDb = await Hive.openBox<Expense>("expense_db");
  var exp = 0;
  for (var i = 0; i < expenseDb.length; i++) {
    exp += expenseDb.values.toList()[i].amount!;
  }
  expenseListNotifier.notifyListeners();

  return exp;
}

Future<int> totleIncome() async {
  final incomeDb = await Hive.openBox<Income>("income_db");

  var exp = 0;
  for (var i = 0; i < incomeDb.length; i++) {
    exp += incomeDb.values.toList()[i].amount!;
  }
  incomeListNotifier.notifyListeners();
  return exp;
}

Future<int> calculateBalance() async {
  final incomeDb = await Hive.openBox<Income>("income_db");
  var exp = 0;
  for (var i = 0; i < incomeDb.length; i++) {
    exp += incomeDb.values.toList()[i].amount!;
  }
  final expenseDb = await Hive.openBox<Expense>("expense_db");
  var inc = 0;
  for (var i = 0; i < expenseDb.length; i++) {
    inc += expenseDb.values.toList()[i].amount!;
  }

  return exp - inc;
}
