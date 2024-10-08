import 'package:flutter/material.dart';

import 'package:money_flow/view/startscreen.dart';
import 'package:money_flow/view/widgets/terms.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.white,
      width: 300,
      child: Column(
        children: [
          UserAccountsDrawerHeader(
            currentAccountPicture: CircleAvatar(
              backgroundColor: Colors.black,
              child: Icon(Icons.person,
                  color: const Color.fromARGB(255, 235, 206, 120)),
            ),
            accountName: Text("User", style: TextStyle(fontSize: 18)),
            accountEmail: Text("user123"),
            decoration:
                BoxDecoration(color: const Color.fromARGB(255, 235, 206, 120)),
          ),
          Expanded(
            child: ListView(
              children: [
                CustomButton(
                  text: "Settings",
                  iconButton: IconButton(
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => Terms()));
                      },
                      icon: Icon(Icons.settings, color: Colors.black)),
                ),
                CustomButton(
                  iconButton: IconButton(
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => Terms()));
                      },
                      icon: Icon(Icons.delete, color: Colors.black)),
                  text: "Delete & Reset",
                ),
                CustomButton(
                  iconButton: IconButton(
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => Terms()));
                      },
                      icon: Icon(Icons.credit_card, color: Colors.black)),
                  text: "My Cards",
                ),
                CustomButton(
                  iconButton: IconButton(
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => Terms()));
                      },
                      icon: Icon(Icons.tag_sharp, color: Colors.black)),
                  text: "Promotions",
                ),
                CustomButton(
                  iconButton: IconButton(
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => Terms()));
                      },
                      icon: Icon(Icons.exit_to_app, color: Colors.black)),
                  text: "Terms and Conditions",
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.black,
                  backgroundColor: Color.fromARGB(255, 235, 206, 120),
                  minimumSize: Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                    side: BorderSide(color: Colors.black),
                  ),
                ),
                icon: Icon(Icons.exit_to_app, color: Colors.black),
                label: Text("Sign out", style: TextStyle(color: Colors.black)),
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => Startscreen()),
                  );
                }),
          ),
        ],
      ),
    );
  }
}

class CustomButton extends StatelessWidget {
  final IconButton iconButton;
  final String text;

  CustomButton({required this.iconButton, required this.text});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: iconButton,
      title: Text(
        text,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
