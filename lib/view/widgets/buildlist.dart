import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:money_flow/functions/functions.dart';

class ExpenseList extends StatelessWidget {
  const ExpenseList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: _buildListView(expenseListNotifier, "Expense"),
    );
  }

  Widget _buildListView(ValueNotifier<List> listNotifier, String type) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: ValueListenableBuilder(
        valueListenable: listNotifier,
        builder: (context, List<dynamic> list, child) {
          if (list.isEmpty) {
            return Center(
              child: Text(
                'No $type available',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
              ),
            );
          }
          return ListView.separated(
            itemBuilder: (context, index) {
              final data = list[index];
              String formattedDate =
                  DateFormat('dd MMM yyyy').format(data.date ?? DateTime.now());

              return ListTile(
                title: Text(
                  '₹${data.amount ?? '0.00'}',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Text("${TextItem()}"),
                    Text(data.category ?? 'No Category'),
                    Text(formattedDate),
                  ],
                ),
                trailing: IconButton(
                  onPressed: () {
                    if (type == 'Expense') {
                      deleteExpense(index);
                    } else {
                      deleteIncome(index);
                    }
                  },
                  icon: Icon(Icons.delete, color: Colors.red),
                ),
              );
            },
            separatorBuilder: (context, index) {
              return Divider(
                color: Colors.grey,
                thickness: 1,
              );
            },
            itemCount: list.length,
          );
        },
      ),
    );
  }
}
