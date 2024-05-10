import 'dart:developer';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:study_app/auth/controller/auth_controller.dart';
import 'package:study_app/auth/controller/image_controller.dart';
import 'package:study_app/auth/screens/login_screen.dart';

import '../../main.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool showProgressbar = false;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final fullNameController = TextEditingController();
  final phoneController = TextEditingController();
  final hostelNameController = TextEditingController();
  final hostelLocationController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  AuthController controller = Get.put(AuthController());
  ImageController imageController = Get.put(ImageController());

  @override
  void dispose() {
    fullNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    phoneController.dispose();
    hostelLocationController.dispose();
    hostelNameController.dispose();
    super.dispose();
  }

  void _onSubmitingInfo() async {
    final isValid = _formKey.currentState!.validate();
    if (imageController.pickedImage == null) {
      Get.showSnackbar(GetSnackBar(
        message: 'Please select your image profile',
        duration: const Duration(seconds: 4),
        backgroundColor: Colors.red.shade300,
      ));
    }

    if (isValid) {
      controller.registerWarden(
          emailController.text.trim(),
          passwordController.text.trim(),
          fullNameController.text.trim(),
          phoneController.text.trim(),
          hostelNameController.text.trim(),
          hostelLocationController.text.trim(),
          imageController.pickedImageFile.value!);

      setState(() {
        showProgressbar = true;
        imageController.pickedImageFile.value = null;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    log('whole widget is rebuild');
    ImageController imageController = Get.put(ImageController());
    mq = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Obx(
                  () => imageController.pickedImageFile.value == null
                      ? Padding(
                          padding: EdgeInsets.only(top: mq.height * .05),
                          child: const Center(
                            child: CircleAvatar(
                              radius: 80,
                              backgroundColor: Colors.grey,
                            ),
                          ),
                        )
                      : Padding(
                          padding: EdgeInsets.only(top: mq.height * .05),
                          child: Container(
                            width: 180,
                            height: 180,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              // borderRadius: BorderRadius.circular(80),
                              color: Colors.grey,
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: FileImage(
                                  File(imageController.imageFile!.path),
                                ),
                              ),
                            ),
                          ),
                        ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      onPressed: () async {
                        await imageController.pickImageFromCamera();
                        log('iam building also');
                      },
                      icon: const Icon(CupertinoIcons.photo_camera),
                    ),
                    IconButton(
                      onPressed: () async {
                        await imageController.pickImageFromGallery();
                      },
                      icon: const Icon(CupertinoIcons.photo_on_rectangle),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),

                //Input field for full name
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20.0, vertical: 12),
                  child: TextFormField(
                    controller: fullNameController,
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

                //Input fields for email
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20.0, vertical: 12),
                  child: TextFormField(
                    controller: emailController,
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

                //input field for password
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20.0, vertical: 12),
                  child: TextFormField(
                    controller: passwordController,
                    keyboardType: TextInputType.visiblePassword,
                    obscureText: true,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(12),
                        ),
                      ),
                      prefixIcon: Icon(CupertinoIcons.lock_fill),
                      labelText: 'Password',
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
                        return 'Please provide your password';
                      } else if (value.length < 8) {
                        return 'Password must be at least 8 characters long';
                      }
                      return null;
                    },
                  ),
                ),

                //Input field for hostel name
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20.0, vertical: 12),
                  child: TextFormField(
                    controller: hostelNameController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(12),
                        ),
                      ),
                      prefixIcon: Icon(CupertinoIcons.house),
                      labelText: 'Hostel Name',
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
                        return 'Please provide your hostel name';
                      } else if (value.length > 20) {
                        return 'Characters must be less than 20';
                      }
                      return null;
                    },
                  ),
                ),

                //Input field for hoste location
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20.0, vertical: 12),
                  child: TextFormField(
                    controller: hostelLocationController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(12),
                        ),
                      ),
                      prefixIcon: Icon(CupertinoIcons.location_solid),
                      labelText: 'Hostel Location',
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
                        return 'Please provide your hostel location';
                      } else if (value.length > 20) {
                        return 'Characters must be less than 20';
                      }
                      return null;
                    },
                  ),
                ),

                //Input field for phone number
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20.0, vertical: 12),
                  child: TextFormField(
                    controller: phoneController,
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

                const SizedBox(
                  height: 10,
                ),

                //Register button

                ElevatedButton(
                  onPressed: _onSubmitingInfo,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue.shade400,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 56, vertical: 8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: showProgressbar == false
                      ? const Text(
                          'Register',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: Colors.white),
                        )
                      : const CircularProgressIndicator(
                          strokeWidth: 1,
                          backgroundColor: Colors.white,
                        ),
                ),
                const SizedBox(
                  height: 10,
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Already have an account."),
                    GestureDetector(
                      onTap: () {
                        Get.to(const LoginScreen());
                      },
                      child: Text(
                        "Login",
                        style: TextStyle(
                            fontSize: 16, color: Colors.blue.shade400),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 14,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
