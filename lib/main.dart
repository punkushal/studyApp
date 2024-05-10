import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:study_app/auth/screens/login_screen.dart';

import 'package:study_app/firebase_options.dart';
import 'package:study_app/screens/student_home_screen.dart';
import 'package:study_app/screens/warden_home_screen.dart';

late Size mq;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Chat App',
      getPages: [
        GetPage(
          name: '/warden_home_screen',
          page: () => const WardenHomeScreen(),
        ),
        GetPage(
          name: '/student_home_screen',
          page: () => const StudentHomeScreen(),
        ),
      ],
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.lightBlue),
        useMaterial3: true,
        appBarTheme: const AppBarTheme(
          color: Colors.white,
          iconTheme: IconThemeData(color: Colors.black),
        ),
      ),
      home: StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            }
            if (snapshot.hasData && snapshot.data != null) {
              if (snapshot.data!.uid ==
                  FirebaseAuth.instance.currentUser!.uid) {
                return const StudentHomeScreen();
              }
              return const WardenHomeScreen();
            } else {
              return const LoginScreen();
            }
          }),
    );
  }
}
