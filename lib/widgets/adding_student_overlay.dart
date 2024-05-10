import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:study_app/auth/controller/student_auth_controller.dart';
import 'package:study_app/models/hostel_student.dart';

class AddingStudentOverlay extends StatefulWidget {
  const AddingStudentOverlay({super.key});

  @override
  State<AddingStudentOverlay> createState() => _AddingStudentOverlayState();
}

class _AddingStudentOverlayState extends State<AddingStudentOverlay> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _roomNumberController = TextEditingController();
  final _emailController = TextEditingController();
  final _guardianNameController = TextEditingController();
  final _guardianNumberController = TextEditingController();
  StduentAuthController stduentAuthController =
      Get.put(StduentAuthController());

  void _onSubmitingStudentInfo(HostelStudent student) async {
    final isValid = _formKey.currentState!.validate();
    if (isValid) {
      await stduentAuthController.registerStudent(student);
      Get.back();
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _roomNumberController.dispose();
    _emailController.dispose();
    _guardianNameController.dispose();
    _guardianNumberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              //Input field for student name
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12),
                child: TextFormField(
                  controller: _nameController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(12),
                      ),
                    ),
                    prefixIcon: Icon(CupertinoIcons.person),
                    labelText: 'Full Name',
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(12),
                      ),
                      borderSide: BorderSide(color: Colors.black),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(12),
                      ),
                      borderSide: BorderSide(color: Colors.red),
                    ),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please provide your name';
                    } else if (value.length > 20) {
                      return 'Characters must be less than 20';
                    }
                    return null;
                  },
                ),
              ),

              //Input field for student's phone number

              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12),
                child: TextFormField(
                  controller: _phoneController,
                  keyboardType: TextInputType.phone,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(12),
                      ),
                    ),
                    prefixIcon: Icon(CupertinoIcons.phone),
                    labelText: 'Phone',
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(12),
                      ),
                      borderSide: BorderSide(color: Colors.black),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(12),
                      ),
                      borderSide: BorderSide(color: Colors.red),
                    ),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please provide your phone number';
                    } else if (value.length > 10) {
                      return 'Number should be 10 digit';
                    }
                    return null;
                  },
                ),
              ),

              //Input field for student's room number

              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12),
                child: TextFormField(
                  controller: _roomNumberController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(12),
                      ),
                    ),
                    prefixIcon: Icon(CupertinoIcons.bed_double),
                    labelText: 'Room Number',
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(12),
                      ),
                      borderSide: BorderSide(color: Colors.black),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(12),
                      ),
                      borderSide: BorderSide(color: Colors.red),
                    ),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please provide your phone number';
                    } else if (value.length > 4) {
                      return 'Number should not be greater than 4 digit';
                    }
                    return null;
                  },
                ),
              ),

              //Input field for student's email

              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12),
                child: TextFormField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(12),
                      ),
                    ),
                    prefixIcon: Icon(CupertinoIcons.mail),
                    labelText: 'Email',
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(12),
                      ),
                      borderSide: BorderSide(color: Colors.black),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(12),
                      ),
                      borderSide: BorderSide(color: Colors.red),
                    ),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please provide your email address';
                    }
                    return null;
                  },
                ),
              ),

              //Input field for student's guardian name

              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12),
                child: TextFormField(
                  controller: _guardianNameController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(12),
                      ),
                    ),
                    prefixIcon: Icon(CupertinoIcons.person),
                    labelText: 'Guardian Name',
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(12),
                      ),
                      borderSide: BorderSide(color: Colors.black),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(12),
                      ),
                      borderSide: BorderSide(color: Colors.red),
                    ),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please provide your guardian's name";
                    } else if (value.length > 20) {
                      return 'Characters must be less than 20';
                    }
                    return null;
                  },
                ),
              ),

              //Input field for student's guardian phone number

              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12),
                child: TextFormField(
                  controller: _guardianNumberController,
                  keyboardType: TextInputType.phone,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(12),
                      ),
                    ),
                    prefixIcon: Icon(CupertinoIcons.phone),
                    labelText: 'Guardian Number',
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(12),
                      ),
                      borderSide: BorderSide(color: Colors.black),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(12),
                      ),
                      borderSide: BorderSide(color: Colors.red),
                    ),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please provide your name';
                    } else if (value.length > 10) {
                      return 'Numbers should not be greater than 10 digits';
                    }
                    return null;
                  },
                ),
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('Cancel'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      HostelStudent student = HostelStudent(
                          role: 'student',
                          name: _nameController.text.trim(),
                          phoneNumber: _phoneController.text.trim(),
                          roomNumber: _roomNumberController.text.trim(),
                          email: _emailController.text.trim(),
                          guardianName: _guardianNameController.text.trim(),
                          guardianNumber: _guardianNumberController.text.trim(),
                          hostelCode: stduentAuthController
                              .authController.auth.currentUser!.uid);
                      _onSubmitingStudentInfo(student);
                    },
                    child: const Text('Submit'),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
