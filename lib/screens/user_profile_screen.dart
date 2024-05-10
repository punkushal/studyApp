import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:study_app/auth/controller/user_controller.dart';

class UserProfileScreen extends StatelessWidget {
  const UserProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    UserController userController = Get.put(UserController());
    return Scaffold(
      appBar: AppBar(
        title: const Text('Details'),
        automaticallyImplyLeading: true,
      ),
      body: Column(
        children: [
          Center(
              child: Obx(
            () => userController.isLoading.value
                ? const CupertinoActivityIndicator(
                    color: Colors.blue,
                    radius: 90,
                  )
                : CircleAvatar(
                    radius: 90,
                    backgroundColor: Colors.grey,
                    backgroundImage:
                        NetworkImage(userController.currentUser!.profileImage),
                  ),
          )),
          const SizedBox(
            height: 8,
          ),
          Obx(
            () => userController.isLoading.value
                ? const CircularProgressIndicator()
                : Text(userController.currentUser!.fullName),
          ),
          const SizedBox(
            height: 18,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.only(left: 9),
                  child: Text(
                    'Email',
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.normal),
                  ),
                ),
                ListTile(
                    leading: const Icon(CupertinoIcons.mail),
                    title: Obx(
                      () => userController.isLoading.value
                          ? const CircularProgressIndicator()
                          : Text(userController.currentUser!.email),
                    )),
                const Divider(),
                const SizedBox(
                  height: 14,
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 9),
                  child: Text(
                    'Phone number',
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.normal),
                  ),
                ),
                ListTile(
                    leading: const Icon(CupertinoIcons.phone),
                    title: Obx(
                      () => userController.isLoading.value
                          ? const CircularProgressIndicator()
                          : Text(userController.currentUser!.phoneNumber),
                    )),
                const Divider(),
                const SizedBox(
                  height: 12,
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 9),
                  child: Text(
                    'Address ',
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.normal),
                  ),
                ),
                ListTile(
                    leading: const Icon(CupertinoIcons.location_solid),
                    title: Obx(
                      () => userController.isLoading.value
                          ? const CircularProgressIndicator(
                              backgroundColor: Colors.blue,
                            )
                          : Text(userController.currentUser!.hostelLocation),
                    )),
                const Divider(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
