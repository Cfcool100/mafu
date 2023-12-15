import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:mafuriko/controllers/auth.controller.dart';
import 'package:mafuriko/utils/themes.dart';
import 'package:mafuriko/views/authentication/login.dart';
import 'package:mafuriko/widgets/button.dart';
import 'package:mafuriko/widgets/form.dart';
import 'package:mafuriko/widgets/linkText.dart';
import 'package:mafuriko/widgets/section_title.dart';
import 'package:provider/provider.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  static String id = '/register';

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  String _email = '';
  String _number = '';
  String _lastname = '';
  String _firstname = '';
  String _password = '';
  String _confirmPassword = '';

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Flexible(
                  child: ListView(
                    children: [
                      const SizedBox(width: double.infinity, height: 25.0),
                      Center(
                        child: Image.asset(
                          'images/Logo-blue.png',
                          scale: 1,
                        ),
                      ),
                      const Gap(30),
                      const SectionTitle(title: 'Inscription'),
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
                      const Gap(17),
                      Row(
                        children: [
                          InputForm(
                            title: 'Nom ',
                            hint: 'Entrer votre npm ',
                            type: TextInputType.text,
                            width: 148,
                            onChanged: (value) {
                              setState(() {
                                _lastname = value;
                              });
                            },
                          ),
                          const Gap(25),
                          InputForm(
                            title: 'Prénoms ',
                            hint: 'Entrer vos Prénoms ',
                            type: TextInputType.text,
                            width: 180,
                            onChanged: (value) {
                              setState(() {
                                _firstname = value;
                              });
                            },
                          ),
                        ],
                      ),
                      const Gap(17),
                      InputForm(
                        title: 'Numéro de téléphone ',
                        hint: 'Entrer votre numéro de téléphone ',
                        type: TextInputType.phone,
                        onChanged: (value) {
                          setState(() {
                            _number = value;
                          });
                        },
                      ),
                      const Gap(17),
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
                      const Gap(17),
                      InputForm(
                        title: 'Confirmation',
                        hint: 'confirmer le mot de passe',
                        type: TextInputType.text,
                        obscure: true,
                        onChanged: (value) {
                          setState(() {
                            _confirmPassword = value;
                          });
                        },
                      ),
                      const Gap(50),
                      Consumer<Authentication>(
                        builder: (context, auth, child) {
                          return PrimaryButton(
                            onPressed: _email.isEmpty ||
                                    _confirmPassword.isEmpty ||
                                    _lastname.isEmpty ||
                                    _firstname.isEmpty
                                ? null
                                : () {
//
                                    auth.userRegister(
                                      email: _email,
                                      firstname: _firstname,
                                      lastname: _lastname,
                                      number: _number,
                                      password: _password,
                                      confirmPassword: _confirmPassword,
                                      context: context,
                                    );
                                  },
                            title: 'Créer un compte',
                            color: AppTheme.primaryColor,
                            textColor: Colors.white,
                          );
                        },
                      ),
                      const Gap(20),
                      LinkText(
                        text: 'Vous avez déjà un compte?  ',
                        textLink: 'Connectez-vous',
                        link: LoginPage.id,
                        lineSize: 100,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
