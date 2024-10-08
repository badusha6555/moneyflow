import 'package:flutter/material.dart';
import 'package:money_flow/functions/functions.dart';
import 'package:money_flow/model/advisor/advisor.dart';

class AddBudget extends StatefulWidget {
  @override
  _AddBudgetState createState() => _AddBudgetState();
}

class _AddBudgetState extends State<AddBudget> {
  String selectedCategory = '';
  TextEditingController amountController = TextEditingController();
  TextEditingController newCategoryController = TextEditingController();

  List<String> expenseCategories = ['Groceries', 'Rent', 'Utilities'];

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: const Color.fromARGB(255, 235, 206, 120),
      title: Text('Add Expense'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: DropdownButtonFormField<String>(
                    decoration: InputDecoration(labelText: 'Category'),
                    value: selectedCategory.isEmpty ? null : selectedCategory,
                    onChanged: (newValue) {
                      setState(() {
                        selectedCategory = newValue!;
                      });
                    },
                    items: expenseCategories
                        .map((category) => DropdownMenuItem<String>(
                              value: category,
                              child: Text(category),
                            ))
                        .toList(),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.add),
                  onPressed: () {
                    _showAddCategoryDialog(context);
                  },
                ),
              ],
            ),
            SizedBox(height: 10),
            TextField(
              controller: amountController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Enter Amount',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () {
            onAddBudget();
            Navigator.pop(context);
          },
          child: Text('Add'),
        ),
      ],
    );
  }

  Future<void> _showAddCategoryDialog(BuildContext context) async {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Add New Category'),
          content: TextField(
            controller: newCategoryController,
            decoration: InputDecoration(
              labelText: 'Category Name',
              border: OutlineInputBorder(),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                String newCategory = newCategoryController.text.trim();
                if (newCategory.isNotEmpty) {
                  setState(() {
                    expenseCategories.add(newCategory);
                  });
                  newCategoryController.clear();
                  Navigator.of(context).pop();
                }
              },
              child: Text('Add'),
            ),
          ],
        );
      },
    );
  }

  Future<void> onAddBudget() async {
    String amount = amountController.text;
    String category = selectedCategory;
    if (amount.isEmpty || category.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
        "Please fill all fields",
        style: TextStyle(color: Colors.red),
      )));
    }
    final adv = BudgetSetter(
      category: category,
      amount: amount,
    );
    addBudget(adv);
  }
}
