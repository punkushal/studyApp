import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:study_app/models/hostel_student.dart';
import 'package:study_app/models/hostel_warden.dart';

class UserController extends GetxController {
  final auth = FirebaseAuth.instance;
  final database = FirebaseFirestore.instance;
  HostelWarden? currentUser;

  RxBool isLoading = true.obs;

  HostelStudent? studentUser;

  @override
  void onInit() {
    super.onInit();
    fetchCurrentUserData();
    fetchCurrentStudentData();
  }

  void setUser(HostelWarden user) {
    log('am i calling?');
    currentUser = user;
    log(currentUser!.fullName);
    update();
  }

  void setStudent(HostelStudent student) {
    studentUser = student;
    update();
  }

//To fetch warden data
  void fetchCurrentUserData() async {
    String userId = auth.currentUser!.uid;
    await database
        .collection('hostel-wardens')
        .doc(userId)
        .get()
        .then((snapshot) {
      if (snapshot.exists) {
        if (auth.currentUser != null) {
          log(userId);
          log(snapshot.data()!.toString());
          log('this also execute');
          HostelWarden warden = HostelWarden.fromMap(snapshot.data()!);
          setUser(warden);
        }
        log('now this execute');
      }
    }).catchError((error) {
      log('error occurred : $error');
    }).whenComplete(() {
      isLoading.value = false;
    });
  }

//To fetch currently logged in student data
  void fetchCurrentStudentData() async {
    String studentId = auth.currentUser!.uid;
    await database.collection('students').doc(studentId).get().then((snapshot) {
      if (snapshot.exists) {
        if (auth.currentUser != null) {
          log(studentId);
          log(snapshot.data()!.toString());
          log('this also execute');
          HostelStudent student = HostelStudent.fromMap(snapshot.data()!);
          setStudent(student);
        }
        log('now this execute');
      }
    }).catchError((error) {
      log('error occurred : $error');
    }).whenComplete(() {
      isLoading.value = false;
    });
  }
}
