import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:shared_preferences/shared_preferences.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  String _errorMesssage = '';
  bool password = false;

  Future _signUp() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('username', _usernameController.text);
    await prefs.setString('password', _passwordController.text);
    await prefs.setBool('isLoggedIn', false);

    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text('Sign Up Successful!'),
    ));

    Navigator.pushReplacementNamed(context, '/bottom');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: 354,
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 235, 206, 120),
                borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(50),
                  bottomLeft: Radius.circular(50),
                ),
              ),
              child: Stack(
                children: [
                  Positioned(
                    top: -65,
                    // left:
                    right: 22,
                    child: ClipRRect(
                      borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(50),
                        bottomLeft: Radius.circular(50),
                      ),
                      child: Container(
                        height: 370,
                        width: 350,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 150,
                    left: 110,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 53.0),
                          child: Icon(
                            Icons.account_balance_wallet,
                            size: 40,
                            color: const Color.fromARGB(255, 235, 206, 120),
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          'Welcome to',
                          style: GoogleFonts.lato(
                            color: Colors.white,
                            fontSize: 29,
                          ),
                        ),
                        Text(
                          'Money Flow',
                          style: TextStyle(
                            color: const Color.fromARGB(255, 235, 206, 120),
                            fontSize: 29,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 40),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Sign up',
                  style: GoogleFonts.lato(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          TextFormField(
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter your username';
                              } else {
                                return null;
                              }
                            },
                            controller: _usernameController,
                            decoration: const InputDecoration(
                                labelText: 'Username',
                                border: OutlineInputBorder()),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          TextFormField(
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter your password';
                              } else {
                                return null;
                              }
                            },
                            controller: _passwordController,
                            obscureText: password,
                            decoration: InputDecoration(
                              labelText: 'Password',
                              border: const OutlineInputBorder(),
                              suffix: IconButton(
                                onPressed: () {
                                  setState(() {
                                    password = !password;
                                  });
                                },
                                icon: password == true
                                    ? const Icon(Icons.visibility)
                                    : const Icon(Icons.visibility_off),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 1.0),
                    Text(
                      _errorMesssage,
                      style: const TextStyle(color: Colors.red),
                    ),
                    const SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState?.validate() == true) {
                          _signUp();
                        }
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          )),
                      child: const Text('Sign up'),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
