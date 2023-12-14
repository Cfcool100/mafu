import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mafuriko/views/authentication/login.dart';
import 'package:mafuriko/views/authentication/register.dart';
import 'package:mafuriko/views/home/home.view.dart';
import 'package:mafuriko/widgets/button.dart';

class OnBoarding extends StatelessWidget {
  const OnBoarding({super.key});
  static String id = '/onboarding';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.sizeOf(context).width,
        height: MediaQuery.sizeOf(context).height,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/background.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              flex: 9,
              child: Column(
                children: [
                  Image.asset(
                    'images/Logo-white.png',
                    scale: 1,
                  ),
                  Text(
                    'Mafuriko',
                    style: GoogleFonts.montserrat(
                      color: Color(0xFFFFF8F0),
                      fontSize: 25,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.36,
                    ),
                  ),
                  Text(
                    'Surveillance en temps réel des inondations',
                    strutStyle: StrutStyle(leading: 1),
                    style: GoogleFonts.montserrat(
                      color: Color(0xFFFFF8F0),
                      fontSize: 13.3,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 3,
              child: Column(
                children: [
                  PrimaryButton(
                    onPressed: () {
                      Navigator.pushNamed(context, RegisterPage.id);
                    },
                    color: const Color(0xFF111D4A),
                    textColor: Colors.white,
                    title: 'Inscription',
                  ),
                  const SizedBox(height: 10),
                  PrimaryButton(
                    onPressed: () {
                      Navigator.pushNamed(context, LoginPage.id);
                    },
                    title: 'Connexion',
                  ),
                ],
              ),
            ),
            const Expanded(
              // flex: 1,
              child: Text('by GEODAFTAR, 2023.'),
            )
          ],
        )),
      ),
    );
  }
}
