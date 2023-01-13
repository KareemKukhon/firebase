import 'dart:developer';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_18_firebase/router/router.dart';
import 'package:flutter_application_18_firebase/screens/main_screen.dart';
import 'package:flutter_application_18_firebase/screens/sign_in.dart';
import 'package:flutter_application_18_firebase/screens/splach_screen.dart';
import 'package:provider/provider.dart';
import 'package:string_validator/string_validator.dart';

import 'Admin/providers/admin_provider.dart';
import 'data/auth_helper.dart';
import 'firebase_options.dart';
import 'provider/auth_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AuthProvider>(
          create: (context) {
            return AuthProvider();
          },
        ),
        ChangeNotifierProvider<AdminProvider>(
          create: (context) {
            return AdminProvider();
          },
        ),
      ],
      child: MaterialApp(
        navigatorKey: AppRouter.appRouter.navkey,
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          // This is the theme of your application.

          primarySwatch: Colors.blue,
        ),
        home: SplachScreen(),
      ),
    );
  }
}




