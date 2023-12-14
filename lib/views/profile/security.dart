import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:mafuriko/utils/themes.dart';
import 'package:mafuriko/widgets/button.dart';
import 'package:mafuriko/widgets/form.dart';
import 'package:mafuriko/widgets/section_title.dart';

class SecurityPage extends StatefulWidget {
  const SecurityPage({super.key});
  static String id = '/profile/security';

  @override
  State<SecurityPage> createState() => _SecurityPageState();
}

class _SecurityPageState extends State<SecurityPage> {
  String _currentPassword = '';
  String _newPassword = '';
  String _confirmPassword = '';

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        appBar: AppBar(),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Gap(30),
                  const SectionTitle(title: 'Modifier mot de passe'),
                  const Gap(50),
                  InputForm(
                    title: 'Mot de passe actuel',
                    hint: 'Entrer votre mot de passe',
                    type: TextInputType.text,
                    onChanged: (value) {
                      setState(() {
                        _currentPassword = value;
                      });
                    },
                  ),
                  const Gap(17),
                  InputForm(
                    title: 'Nouveau mot de passe',
                    hint: 'Entrer votre mot de passe',
                    type: TextInputType.text,
                    obscure: true,
                    onChanged: (value) {
                      setState(() {
                        _newPassword = value;
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
                  PrimaryButton(
                    onPressed: _currentPassword.isEmpty ||
                            _newPassword.isEmpty ||
                            _confirmPassword.isEmpty
                        ? null
                        : () {
                            // PopUp.successAuth(context);
                            Navigator.pushNamed(context, 'HomePage.id');
                          },
                    title: 'Sauvegarder',
                    color: AppTheme.primaryColor,
                    textColor: Colors.white,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
