import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:study_app/auth/controller/auth_controller.dart';
import 'package:study_app/auth/controller/user_controller.dart';
import 'package:study_app/auth/screens/login_screen.dart';
import 'package:study_app/screens/user_profile_screen.dart';
import 'package:study_app/widgets/adding_student_overlay.dart';

//Warden Home Screen
class WardenHomeScreen extends StatefulWidget {
  const WardenHomeScreen({super.key});

  @override
  State<WardenHomeScreen> createState() => _WardenHomeScreenState();
}

class _WardenHomeScreenState extends State<WardenHomeScreen> {
  final userController = Get.put(UserController());
  AuthController authController = Get.put(AuthController());
  void signOut() async {
    await authController.auth.signOut();
    Get.offAll(() => const LoginScreen());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Dashboard"),
          actions: [
            IconButton(onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (ctx) => const UserProfileScreen()));
            }, icon: Obx(() {
              if (userController.isLoading.value) {
                return const SizedBox(
                  height: 60,
                  width: 60,
                  child: CircularProgressIndicator(
                    color: Colors.white,
                  ),
                );
              }

              return userController.currentUser != null
                  ? CircleAvatar(
                      radius: 25,
                      backgroundImage: NetworkImage(
                          userController.currentUser!.profileImage),
                    )
                  : const CircularProgressIndicator();
            })),
          ],
        ),
        body: Obx(
          () => userController.isLoading.value
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 24.0, vertical: 12),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: 180,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(width: 1),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(18.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              userController.currentUser != null
                                  ? Text(
                                      'Name : ${userController.currentUser?.fullName}')
                                  : const CircularProgressIndicator(),
                              const SizedBox(
                                height: 8,
                              ),
                              userController.currentUser != null
                                  ? Text(
                                      'Hostel Name : ${userController.currentUser!.hostelName}')
                                  : const CircularProgressIndicator(),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Get.bottomSheet(
                              BottomSheet(
                                  onClosing: () {
                                    Navigator.pop(context);
                                  },
                                  builder: (ctx) =>
                                      const AddingStudentOverlay()),
                            );
                          },
                          child: Container(
                            width: 180,
                            height: 180,
                            decoration: BoxDecoration(
                              color: Colors.green.shade50,
                            ),
                            child: const Center(
                              child: Text(
                                'Add Student',
                                style: TextStyle(fontSize: 16),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    IconButton(
                        onPressed: signOut, icon: const Icon(Icons.exit_to_app))
                  ],
                ),
        ));
  }
}
