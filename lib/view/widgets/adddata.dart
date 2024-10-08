import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:money_flow/functions/functions.dart';
import 'package:money_flow/model/expense/expense.dart';
import 'package:money_flow/model/income/income.dart';
import 'package:money_flow/view/home_screen.dart';

class AddData extends StatefulWidget {
  const AddData({super.key});

  @override
  _AddDataState createState() => _AddDataState();
}

class _AddDataState extends State<AddData> {
  Future<void> onAddExpenseOrIncome() async {
    String amount = amountController.text.trim();
    String note = noteController.text.trim();
    String category = selectedCategory;

    if (amount.isEmpty || note.isEmpty || category.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill in all fields')),
      );
      return;
    }

    if (isExpense) {
      final expense = Expense(
        isExpense: true,
        category: category,
        amount: int.tryParse(amount),
        description: note,
        date: DateTime.now(),
      );
      addExpense(expense);
      setState(() {
        totolExpence();
      });
    } else {
      final income = Income(
        isIncome: true,
        category: category,
        description: note,
        date: DateTime.now(),
        amount: int.tryParse(amount),
      );
      addIncome(income);
    }

    amountController.clear();
    noteController.clear();
  }

  Box<Income>? incomeBox;
  Box<Expense>? expenseBox;

  void initState() {
    super.initState();
    _openBoxes();
  }

  Future<void> _openBoxes() async {
    final incomeBox = await Hive.openBox<Income>('incomeBox');
    final expenseBox = await Hive.openBox<Expense>('expenseBox');
  }

  bool isIncome = false;
  bool isExpense = false;
  String selectedCategory = '';
  TextEditingController amountController = TextEditingController();
  TextEditingController noteController = TextEditingController();
  TextEditingController newCategoryController = TextEditingController();

  List<String> incomeCategories = ['Salary', 'Bonus', 'Investment'];
  List<String> expenseCategories = ['Groceries', 'Rent', 'Utilities'];

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: const Color.fromARGB(255, 235, 206, 120),
      title: const Text('Add Transaction'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Checkbox(
                  value: isIncome,
                  onChanged: (value) {
                    setState(() {
                      isIncome = value ?? false;
                      if (isIncome) isExpense = false;
                      selectedCategory = '';
                    });
                  },
                ),
                const Text('Income'),
                Checkbox(
                  value: isExpense,
                  onChanged: (value) {
                    setState(() {
                      isExpense = value ?? false;
                      if (isExpense) isIncome = false;
                      selectedCategory = '';
                    });
                  },
                ),
                const Text('Expense'),
              ],
            ),
            if (isIncome || isExpense)
              Row(
                children: [
                  Expanded(
                    child: DropdownButtonFormField<String>(
                      decoration: const InputDecoration(labelText: 'Category'),
                      value: selectedCategory.isEmpty ? null : selectedCategory,
                      onChanged: (newValue) {
                        setState(() {
                          selectedCategory = newValue!;
                        });
                      },
                      items: (isIncome ? incomeCategories : expenseCategories)
                          .map((category) => DropdownMenuItem<String>(
                                value: category,
                                child: Text(category),
                              ))
                          .toList(),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.add),
                    onPressed: _showAddCategoryDialog,
                  ),
                ],
              ),
            const SizedBox(height: 10),
            TextField(
              controller: amountController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Enter Amount',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: noteController,
              decoration: const InputDecoration(
                labelText: 'Short Note',
                border: OutlineInputBorder(),
              ),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () {
            setState(() {
              onAddExpenseOrIncome();
            });
            Navigator.pop(context);
          },
          child: const Text('Add'),
        ),
      ],
    );
  }

  // Future<void> onAddExpenseOrIncome() async {
  //   String amount = amountController.text.trim();
  //   String note = noteController.text.trim();
  //   String category = selectedCategory;

  //   if (amount.isEmpty || note.isEmpty || category.isEmpty) {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       const SnackBar(content: Text('Please fill in all fields')),
  //     );
  //     return;
  //   }

  //   if (isExpense) {
  //     final expense = Expense(
  //       isExpense: true,
  //       category: category,
  //       amount: int.tryParse(amount.toString()),
  //       description: note,
  //       date: DateTime.now(),
  //     );
  //     addExpense(expense);
  //     totolExpence();
  //   } else {
  //     final income = Income(
  //         isIncome: true,
  //         category: category,
  //         description: note,
  //         date: DateTime.now(),
  //         amount: int.tryParse(amount));
  //     addIncome(income);
  //     totleIncome();
  //   }
  //   amountController.clear();
  //   noteController.clear();
  // }

  Future<void> _showAddCategoryDialog() async {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Add New Category'),
          content: TextField(
            controller: newCategoryController,
            decoration: const InputDecoration(
              labelText: 'Category Name',
              border: OutlineInputBorder(),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                String newCategory = newCategoryController.text.trim();
                if (newCategory.isNotEmpty) {
                  setState(() {
                    if (isIncome) {
                      incomeCategories.add(newCategory);
                    } else {
                      expenseCategories.add(newCategory);
                    }
                  });
                  newCategoryController.clear();
                  Navigator.of(context).pop();
                }
              },
              child: const Text('Add'),
            ),
          ],
        );
      },
    );
  }
}
