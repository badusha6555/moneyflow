import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:money_flow/model/user/user.dart';
import 'dart:io';

import 'package:money_flow/view/widgets/editprofile.dart';

class profile extends StatefulWidget {
  final User user;

  profile({required this.user});

  @override
  _profileState createState() => _profileState();
}

class _profileState extends State<profile> {
  Future<void> _editProfile() async {
    final editedUser = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditOrAdd(
          user: widget.user,
        ),
      ),
    );

    if (editedUser != null) {
      setState(() {
        widget.user.name = editedUser.name;
        widget.user.age = editedUser.age;
        widget.user.phone = editedUser.phone;
        widget.user.imagePath = editedUser.imagePath;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFA89A62),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 235, 206, 120),
        title: Text("Profile"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 80.0, vertical: 5),
          child: Column(
            children: [
              Container(
                width: 300,
                height: 300,
                decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 235, 206, 120),
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(40),
                    bottomLeft: Radius.circular(40),
                  ),
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: 70),
                      CircleAvatar(
                        radius: 80,
                        backgroundImage: widget.user.imagePath != null &&
                                widget.user.imagePath!.isNotEmpty
                            ? FileImage(File(widget.user.imagePath!))
                            : null,
                        child: widget.user.imagePath == null ||
                                widget.user.imagePath!.isEmpty
                            ? Icon(Icons.person, size: 50)
                            : null,
                      ),
                    ],
                  ),
                ),
              ),
              Center(
                child: Card(
                  color: Color.fromARGB(255, 235, 206, 120),
                  elevation: 10,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  margin: EdgeInsets.all(16),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(height: 16),
                        Text(
                          'Name: ${widget.user.name ?? 'N/A'}',
                          style: GoogleFonts.laBelleAurore(fontSize: 22),
                        ),
                        Text(
                          'Age: ${widget.user.age != null ? widget.user.age.toString() : 'N/A'}',
                          style: GoogleFonts.laBelleAurore(fontSize: 18),
                        ),
                        Text(
                          'Phone: ${widget.user.phone ?? 'N/A'}',
                          style: GoogleFonts.laBelleAurore(fontSize: 18),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 16),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromARGB(255, 235, 206, 120),
                    foregroundColor: Colors.black,
                  ),
                  onPressed: _editProfile,
                  child: Text(
                    'Edit Profile',
                    style: GoogleFonts.laBelleAurore(fontSize: 18),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
