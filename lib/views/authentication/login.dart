import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:formz/formz.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:mafuriko/providers/user.providers.dart';
import 'package:mafuriko/routes/constants.dart';
import 'package:mafuriko/widgets/button.dart';
import 'package:mafuriko/widgets/form.dart';
import 'package:mafuriko/widgets/link_text.dart';
import 'package:mafuriko/widgets/section_title.dart';


class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: BlocListener<SignInBloc, SignInState>(
        listener: (context, state) {
          if (state.isValid && state.status.isSuccess) {
            context.read<AuthenticationBloc>().add(AuthenticationStatusChanged(
                AuthenticationStatus.authenticated));
            context.pushNamed(Paths.home);
          } else if (state.status.isFailure) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: const Text("error"),
              backgroundColor: Colors.red.shade200,
            ));
          }
        },
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18.0),
              child: Column(
                children: [
                  Column(
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
                          context
                              .read<SignInBloc>()
                              .add(SignInEmailChangedEvent(value));
                        },
                      ),
                      const Gap(20),
                      InputForm(
                        title: 'Mot de passe',
                        hint: 'Entrer votre mot de passe',
                        type: TextInputType.text,
                        obscure: true,
                        onChanged: (value) {
                          context
                              .read<SignInBloc>()
                              .add(SignInPasswordChangedEvent(value));
                        },
                      ),
                      const Gap(50),
                    ],
                  ),
                  BlocBuilder<SignInBloc, SignInState>(
                    builder: (context, state) {
                      return PrimaryButton(
                        onPressed: state.isValid
                            ? () async {
                                context.read<SignInBloc>().add(SubmitEvent());
                              }
                            : null,
                        title: 'Connexion',
                        color: const Color(0XFF111D4A),
                        textColor: Colors.white,
                        width: .9.sw,
                      );
                    },
                  ),
                  const Gap(30),
                  LinkText(
                    text: 'Vous n’avez pas de compte? ',
                    textLink: 'Inscrivez-vous',
                    link: Paths.register,
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
