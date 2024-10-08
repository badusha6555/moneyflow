import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:money_flow/model/user/user.dart'; // Image picker for selecting profile image

class EditOrAdd extends StatefulWidget {
  final User? user;

  EditOrAdd({this.user});

  @override
  _EditOrAddState createState() => _EditOrAddState();
}

class _EditOrAddState extends State<EditOrAdd> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _ageController;
  late TextEditingController _phoneController;
  String? _imagePath;

  @override
  void initState() {
    super.initState();

    _nameController = TextEditingController(text: widget.user?.name ?? '');
    _ageController =
        TextEditingController(text: widget.user?.age.toString() ?? '');
    _phoneController = TextEditingController(text: widget.user?.phone ?? '');
    _imagePath = widget.user?.imagePath;
  }

  Future<void> _pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _imagePath = pickedFile.path;
      });
    }
  }

  void _saveProfile() {
    if (_formKey.currentState!.validate()) {
      Navigator.pop(
        context,
        User(
          name: _nameController.text,
          age: _ageController.text,
          phone: _phoneController.text,
          imagePath: _imagePath,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Profile"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                GestureDetector(
                  onTap: _pickImage,
                  child: CircleAvatar(
                    backgroundColor: Color.fromARGB(255, 235, 206, 120),
                    radius: 50,
                    backgroundImage:
                        _imagePath != null && _imagePath!.isNotEmpty
                            ? FileImage(File(_imagePath!))
                            : null,
                    child: _imagePath == null || _imagePath!.isEmpty
                        ? Icon(
                            Icons.person,
                            size: 50,
                            color: Colors.black,
                          )
                        : null,
                  ),
                ),
                SizedBox(height: 16),
                TextFormField(
                  controller: _nameController,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.person),
                    labelText: 'Name',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide:
                          BorderSide(color: Color.fromARGB(255, 235, 206, 120)),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your name';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16),
                TextFormField(
                  controller: _ageController,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.calendar_today),
                    labelText: 'Age',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide:
                          BorderSide(color: Color.fromARGB(255, 235, 206, 120)),
                    ),
                  ),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your age';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16),
                TextFormField(
                  controller: _phoneController,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.phone),
                    labelText: 'Phone',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide:
                          BorderSide(color: Color.fromARGB(255, 235, 206, 120)),
                    ),
                  ),
                  keyboardType: TextInputType.phone,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your phone number';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromARGB(255, 235, 206, 120),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: _saveProfile,
                  child: Text(
                    'Save',
                    style: GoogleFonts.laBelleAurore(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
