import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:study_app/models/hostel_warden.dart';

class UserController extends GetxController {
  final auth = FirebaseAuth.instance;
  final database = FirebaseFirestore.instance;
  HostelWarden? currentUser;
  RxBool isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    fetchCurrentUserData();
  }

  void setUser(HostelWarden user) {
    log('am i calling?');
    currentUser = user;
    log(currentUser!.fullName);
    update();
  }

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
}
