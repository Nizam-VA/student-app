import 'dart:io';

import 'package:flutter/material.dart';

import '../database/databaseHelper.dart';
import '../model/students.dart';

class ScreenUpdateStudent extends StatefulWidget {
  final Student student;

  ScreenUpdateStudent({required this.student});

  @override
  _ScreenUpdateStudentState createState() => _ScreenUpdateStudentState();
}

class _ScreenUpdateStudentState extends State<ScreenUpdateStudent> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _ageController = TextEditingController();
  final _placeController = TextEditingController();
  final _mobileNumberController = TextEditingController();

  DatabaseHelper datahelp = DatabaseHelper();

  @override
  void initState() {
    super.initState();
    _nameController.text = widget.student.name;
    _ageController.text = widget.student.age.toString();
    _placeController.text = widget.student.place;
    _mobileNumberController.text = widget.student.mobileNumber.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('Update Students'),
      ),
      body: Center(
        child: Container(
          height: 500,
          width: double.infinity,
          margin: EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            border: Border.all(
              width: .5,
            ),
          ),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 16,
                ),
                CircleAvatar(
                  radius: 50.0,
                  backgroundImage:
                      FileImage(File(widget.student.profilePicturePath)),
                ),
                const SizedBox(height: 8),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: TextFormField(
                    controller: _nameController,
                    decoration: const InputDecoration(
                      labelText: 'Name',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(5),
                        ),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Enter the name';
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: TextFormField(
                    controller: _ageController,
                    decoration: const InputDecoration(
                      labelText: 'Age',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(5),
                        ),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Enter the age';
                      }
                      return null;
                    },
                    keyboardType: TextInputType.number,
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: TextFormField(
                    controller: _placeController,
                    decoration: const InputDecoration(
                      labelText: 'Place',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(5),
                        ),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Enter the place';
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: TextFormField(
                    controller: _mobileNumberController,
                    decoration: const InputDecoration(
                      labelText: 'MobileNumber',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(5),
                        ),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Enter the mobile number';
                      }
                      return null;
                    },
                  ),
                ),
                ElevatedButton.icon(
                  icon: const Icon(Icons.save),
                  label: const Text('Save'),
                  onPressed: () {
                    editStudent();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  editStudent() {
    if (_formKey.currentState!.validate()) {
      final name = _nameController.text;
      final age = int.parse(_ageController.text);
      final place = _placeController.text;
      final mobileNumber = int.parse(_mobileNumberController.text);

      final updatedStudent = Student(
        id: widget.student.id,
        name: name,
        age: age,
        place: place,
        mobileNumber: mobileNumber,
        profilePicturePath: widget.student.profilePicturePath,
      );
      datahelp.updateStudent(updatedStudent).then((id) {
        if (id > 0) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Student updated successfully')),
          );
          Navigator.pop(context);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Failed to update student')),
          );
        }
      });
    }
  }
}
