import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:study_app/models/hostel_warden.dart';
import 'package:study_app/screens/warden_home_screen.dart';

class AuthController extends GetxController {
  RxBool isLoading = false.obs;
  //All authenitacation related property is held by auth variable
  final auth = FirebaseAuth.instance;

  //All firestore which database in firebase is held by database variable
  final database = FirebaseFirestore.instance;

  //Register Hostel Warden
  registerWarden(String email, String password, String fullName, String phone,
      String hostelName, String hostellocation, File image) async {
    try {
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
          email: email, password: password);

      //Upload image file to storage
      String urlOfDownloadedImage = await uploadImageFileToStorage(image);

      //To generate unique id
      String userId = userCredential.user!.uid;
      database.collection('hostel-wardens').doc(userId).set(HostelWarden(
            email: email,
            fullName: fullName,
            hostelLocation: hostellocation,
            hostelName: hostelName,
            password: password,
            phoneNumber: phone,
            profileImage: urlOfDownloadedImage,
            userId: userId,
            role: 'warden',
          ).toMap());

      Get.offAll(
        () => const WardenHomeScreen(),
      );
    } on FirebaseAuthException catch (e) {
      String message = 'An error occured. Please try again';
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
    } catch (e) {
      Get.showSnackbar(
        const GetSnackBar(
          message: 'Some problem occured',
          duration: Duration(seconds: 4),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  //Login  warden / students as well
  loginUser(String email, String password) async {
    try {
      await auth.signInWithEmailAndPassword(email: email, password: password);
      User? user = auth.currentUser;
      if (user != null) {
        // Check if user is a warden
        QuerySnapshot wardenSnapshot = await FirebaseFirestore.instance
            .collection('hostel-wardens')
            .where('userId', isEqualTo: user.uid)
            .get();
        if (wardenSnapshot.docs.isNotEmpty) {
          DocumentSnapshot wardenData = wardenSnapshot.docs.first;
          String wardenId = wardenData.id;
          // Navigate to warden home screen and pass wardenId
          Get.offAllNamed('/warden_home_screen',
              arguments: {'userId': wardenId});
          Get.showSnackbar(
            GetSnackBar(
              message: 'Successfully logged in',
              duration: const Duration(seconds: 3),
              backgroundColor: Colors.green.shade400,
            ),
          );
        }
      } else {
        // Check if user is a student
        QuerySnapshot studentSnapshot = await FirebaseFirestore.instance
            .collection('students')
            .where('studentId', isEqualTo: user!.uid)
            .get();

        if (studentSnapshot.docs.isNotEmpty) {
          // User is a student
          // Assuming there is only one student per user, get the first document
          DocumentSnapshot studentData = studentSnapshot.docs.first;
          String studentId = studentData.id;
          // Navigate to student home screen and pass studentId
          Get.offAllNamed('/student_home_screen',
              arguments: {'studentId': studentId});
          Get.showSnackbar(
            GetSnackBar(
              message: 'Successfully logged in',
              duration: const Duration(seconds: 3),
              backgroundColor: Colors.green.shade400,
            ),
          );
        }
      }
    } on FirebaseAuthException catch (e) {
      String message = "";
      log(e.code);
      if (e.code == "invalid-email") {
        message = "You've entered invalid email";
      } else if (e.code == "user-disabled") {
        message = "User is currently disabled";
      } else if (e.code == "user-not-fount") {
        message = "User not found";
      } else if (e.code == "wrong-password") {
        message = "You've entered wrong password";
      } else if (e.code == "invalid-credential") {
        message = "Invalid credential";
      }
      Get.showSnackbar(
        GetSnackBar(
          message: message,
          duration: const Duration(milliseconds: 600),
          backgroundColor: Colors.red.shade400,
        ),
      );
    }
  }

//Uploading image file to the firebase storage
  Future<String> uploadImageFileToStorage(File imageFile) async {
    Reference reference = FirebaseStorage.instance
        .ref()
        .child('Profile Images')
        .child(auth.currentUser!.uid);
    UploadTask uploadTask = reference.putFile(imageFile);
    TaskSnapshot snapshot = await uploadTask;
    String downloadUrlOfImage = await snapshot.ref.getDownloadURL();
    return downloadUrlOfImage;
  }
}
