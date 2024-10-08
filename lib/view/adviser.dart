import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:money_flow/functions/functions.dart';
import 'package:money_flow/view/widgets/addbudget.dart';
import 'package:money_flow/view/widgets/advisor_list.dart';

class Advisor extends StatefulWidget {
  const Advisor({Key? key}) : super(key: key);

  @override
  _AdvisorState createState() => _AdvisorState();
}

class _AdvisorState extends State<Advisor> {
  DateTime selectedDate = DateTime.now();
  void _changeMonth(int increment) {
    setState(() {
      selectedDate =
          DateTime(selectedDate.year, selectedDate.month + increment);
    });
  }

  @override
  Widget build(BuildContext context) {
    getAllBudgets();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          'Budget Setter',
          style: GoogleFonts.lato(
              color: Color.fromARGB(255, 235, 206, 120),
              fontSize: 20,
              fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.add, color: Colors.white),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddBudget(),
                ),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 150,
              padding: const EdgeInsets.all(20),
              decoration: const BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      const Text(
                        'Total Income',
                        style: TextStyle(
                            color: Color.fromARGB(255, 235, 206, 120)),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        '₹10000',
                        style: const TextStyle(
                          color: Color.fromARGB(255, 235, 206, 120),
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      const Text(
                        'Total Expenses',
                        style: TextStyle(
                            color: Color.fromARGB(255, 235, 206, 120)),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        '₹9867',
                        style: const TextStyle(
                          color: Color.fromARGB(255, 235, 206, 120),
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Added Categories in this Month:',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 500,
                    child: AdvisorList(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
