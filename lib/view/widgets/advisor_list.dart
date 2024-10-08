import 'package:flutter/material.dart';
import 'package:money_flow/functions/functions.dart';

class AdvisorList extends StatelessWidget {
  const AdvisorList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: advisorLst(
        budgetListNotifier,
        'Advisor',
      ),
    );
  }

  Widget advisorLst(ValueNotifier<List> budgetListNotifier, String type) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: ValueListenableBuilder(
        valueListenable: budgetListNotifier,
        builder: (context, List<dynamic> budget, child) {
          if (budget.isEmpty) {
            return Center(
              child: Text(
                'No $type added',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
              ),
            );
          }
          return ListView.separated(
            itemBuilder: (context, index) {
              final data = budget[index];
              return Card(
                color: Color.fromARGB(255, 235, 206, 120),
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        data.amount.toString(),
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      Text(
                        data.category ?? 'No Category',
                        style: TextStyle(
                          color: const Color.fromARGB(255, 20, 19, 19),
                          fontSize: 14,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          IconButton(
                            onPressed: () {
                              if (type == 'Expense') {
                                deleteExpense(index);
                              } else {
                                deleteIncome(index);
                              }
                            },
                            icon: Icon(Icons.delete, color: Colors.red),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
            separatorBuilder: (context, index) {
              return Divider(
                color: Colors.grey,
                thickness: 1,
              );
            },
            itemCount: budget.length,
          );
        },
      ),
    );
  }
}
