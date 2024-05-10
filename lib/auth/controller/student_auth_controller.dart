import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:study_app/auth/controller/auth_controller.dart';
import 'package:study_app/models/hostel_student.dart';

class StduentAuthController extends GetxController {
  AuthController authController = Get.put(AuthController());

  //register student by warden
  registerStudent(HostelStudent student) async {
    //To assign currently logged in warden unique id as hostel code for student
    String hostelCode = authController.auth.currentUser!.uid;

    try {
      UserCredential studentCredential = await authController.auth
          .createUserWithEmailAndPassword(
              email: student.email, password: student.phoneNumber);

      //To access student currently create uid
      String studentId = studentCredential.user!.uid;

      authController.database.collection('students').doc(studentId).set(
          HostelStudent(
                  role: student.role,
                  name: student.name,
                  phoneNumber: student.phoneNumber,
                  roomNumber: student.roomNumber,
                  email: student.email,
                  guardianName: student.guardianName,
                  guardianNumber: student.guardianNumber,
                  hostelCode: hostelCode)
              .toMap());
    } on FirebaseAuthException catch (e) {
      String message = "";
      if (e.code == 'email-already-in-use') {
        message = 'Account already existed';
      } else if (e.code == 'invalid-email') {
        message = "You've entered invalid email";
      } else if (e.code == 'operation-not-allowed') {
        message = "You're email address is not enabled";
      }

      Get.showSnackbar(
        GetSnackBar(
          message: message,
          duration: const Duration(seconds: 4),
          backgroundColor: Colors.red,
        ),
      );
    }
  }
}
