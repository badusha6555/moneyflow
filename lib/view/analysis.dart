import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:money_flow/view/widgets/buildlist.dart';
import 'package:pie_chart/pie_chart.dart';

class analsys extends StatefulWidget {
  const analsys({super.key});

  @override
  State<analsys> createState() => _analsysState();
}

class _analsysState extends State<analsys> {
  Map<String, double> dataMap = {
    "Fashion": 18.5,
    "Food": 25.9,
    "Medicine": 29.6,
    "Travel": 11.1,
    "Shopping": 14.8
  };

  final colorList = <Color>[
    const Color.fromARGB(255, 235, 206, 120),
    Colors.blue,
    Colors.black,
    Colors.red,
    Colors.green,
  ];
  DateTime selectedDate = DateTime.now();

  void _changeMonth(int increment) {
    setState(() {
      selectedDate =
          DateTime(selectedDate.year, selectedDate.month + increment);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: true,
        foregroundColor: const Color.fromARGB(255, 235, 206, 120),
        title: Text(
          "Analysis",
          style: GoogleFonts.lato(
              color: const Color.fromARGB(255, 235, 206, 120),
              fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.black,
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            decoration: const BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      icon: const Icon(
                        Icons.arrow_left,
                        color: Color.fromARGB(255, 235, 206, 120),
                      ),
                      onPressed: () {
                        _changeMonth(-1);
                      },
                    ),
                    Text(
                      "${_getMonthName(selectedDate.month)}, ${selectedDate.year}",
                      style: GoogleFonts.lato(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: const Color.fromARGB(255, 235, 206, 120),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.arrow_right,
                          color: Color.fromARGB(255, 235, 206, 120)),
                      onPressed: () {
                        _changeMonth(1);
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Expense Analysis",
                      style: GoogleFonts.lato(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                    const Icon(Icons.expand_more),
                  ],
                ),
                const SizedBox(height: 24),
                SizedBox(
                  height: 200,
                  child: PieChart(
                    dataMap: dataMap,
                    animationDuration: const Duration(seconds: 3),
                    chartLegendSpacing: 37,
                    chartRadius: MediaQuery.of(context).size.width / 2.5,
                    colorList: colorList,
                    initialAngleInDegree: 4,
                    chartType: ChartType.disc,
                    centerText: "Expenses",
                    centerTextStyle: GoogleFonts.lato(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                    legendOptions: const LegendOptions(
                      showLegendsInRow: false,
                      legendPosition: LegendPosition.right,
                      showLegends: true,
                      legendTextStyle: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    chartValuesOptions: ChartValuesOptions(
                      showChartValueBackground: true,
                      showChartValues: true,
                      showChartValuesInPercentage: true,
                      showChartValuesOutside: true,
                      decimalPlaces: 1,
                      chartValueStyle: GoogleFonts.lato(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                          color: const Color.fromARGB(255, 44, 16, 16)),
                    ),
                  ),
                ),
                const SizedBox(height: 26),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 4.0, vertical: 8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Recent Expenses",
                          style: GoogleFonts.lato(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.black)),
                      SizedBox(
                        height: 300,
                        child: ExpenseList(),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

String _getMonthName(int month) {
  List<String> monthNames = [
    "January",
    "February",
    "March",
    "April",
    "May",
    "June",
    "July",
    "August",
    "September",
    "October",
    "November",
    "December"
  ];
  return monthNames[month - 1];
}
