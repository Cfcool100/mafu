import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mafuriko/controllers/auth.controllers.dart';
import 'package:mafuriko/views/authentication/register.dart';
import 'package:mafuriko/widgets/button.dart';
import 'package:mafuriko/widgets/form.dart';
import 'package:mafuriko/widgets/linkText.dart';
import 'package:mafuriko/widgets/section_title.dart';
import 'package:provider/provider.dart';

import '../home/home.view.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  static String id = '/login';

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String _email = '';
  String _password = '';

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(width: double.infinity, height: 35.0),
                Center(
                  child: Image.asset(
                    'images/Logo-blue.png',
                    scale: .8,
                  ),
                ),
                const Gap(50),
                const SectionTitle(title: 'Connexion'),
                const Gap(10),
                InputForm(
                  title: 'Email',
                  hint: 'Entrer votre email',
                  type: TextInputType.emailAddress,
                  onChanged: (value) {
                    setState(() {
                      _email = value;
                    });
                  },
                ),
                const Gap(20),
                InputForm(
                  title: 'Mot de passe',
                  hint: 'Entrer votre mot de passe',
                  type: TextInputType.text,
                  obscure: true,
                  onChanged: (value) {
                    setState(() {
                      _password = value;
                    });
                  },
                ),
                const Gap(50),
                Consumer<Authentication>(
                  builder: (context, auth, child) {
                    return PrimaryButton(
                      onPressed: _email.isEmpty || _password.isEmpty
                          ? null
                          : () {
                              auth.userLogin(
                                email: _email,
                                password: _password,
                                context: context,
                              );
                            },
                      title: 'Connexion',
                      color: const Color(0XFF111D4A),
                      textColor: Colors.white,
                    );
                  },
                ),
                const Gap(30),
                LinkText(
                  text: 'Vous n’avez pas de compte? ',
                  textLink: 'Inscrivez-vous',
                  link: RegisterPage.id,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
