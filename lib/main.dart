import 'package:flutter/material.dart';
import 'package:mafuriko/controllers/alert.controller.dart';
import 'package:mafuriko/views/authentication/login.dart';
import 'package:mafuriko/views/authentication/register.dart';
import 'package:mafuriko/views/data/data_form.dart';
import 'package:mafuriko/views/home/home.view.dart';
import 'package:mafuriko/views/onboarding.dart';
import 'package:mafuriko/views/profile/edit.dart';
import 'package:mafuriko/views/profile/preference.dart';
import 'package:mafuriko/views/profile/profile.view.dart';
import 'package:mafuriko/views/profile/security.dart';
import 'package:mafuriko/views/profile/user.dart';
import 'package:provider/provider.dart';
import 'controllers/auth.controller.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => Authentication()),
        ChangeNotifierProvider(create: (_) => Alert()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          useMaterial3: true,
        ),
        initialRoute: OnBoarding.id,
        routes: {
          OnBoarding.id: (context) => const OnBoarding(),
          LoginPage.id: (context) => const LoginPage(),
          RegisterPage.id: (context) => const RegisterPage(),
          HomePage.id: (context) => const HomePage(),
          DataForm.id: (context) => const DataForm(),
          ProfilePage.id: (context) => const ProfilePage(),
          EditProfilePage.id: (context) => const EditProfilePage(),
          ProfileUser.id: (context) => const ProfileUser(),
          SecurityPage.id: (context) => const SecurityPage(),
          Preference.id: (context) => const Preference(),
        },
      ),
    );
  }
}
