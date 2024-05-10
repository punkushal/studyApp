import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:study_app/auth/controller/user_controller.dart';

class StudentHomeScreen extends StatefulWidget {
  const StudentHomeScreen({super.key});

  @override
  State<StudentHomeScreen> createState() => _StudentHomeScreenState();
}

class _StudentHomeScreenState extends State<StudentHomeScreen> {
  UserController userController = Get.put(UserController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () => userController.isLoading.value
            ? const CircularProgressIndicator()
            : Center(
                child: userController.studentUser != null
                    ? Text(userController.studentUser!.name)
                    : const CircularProgressIndicator()),
      ),
    );
  }
}
