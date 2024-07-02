import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:formz/formz.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:mafuriko/providers/profile/profile_bloc.dart';
import 'package:mafuriko/providers/user.providers.dart';
import 'package:mafuriko/routes/constants.dart';
import 'package:mafuriko/utils/toasts.dart';
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
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: BlocListener<SignInBloc, SignInState>(
        listenWhen: (previous, current) =>
            current.authState == AuthState.isLogin,
        listener: (context, state) {
          if (state.isValid && state.status.isSuccess) {
            context.read<SignInBloc>().add(StopEvent());
            context.read<AuthenticationBloc>().add(AuthenticationStatusChanged(
                AuthenticationStatus.authenticated));
            context.read<ProfileBloc>().add(const ProfileUpdateEvent());
            context.pushNamed(Paths.home);
          } else if (state.status == FormzSubmissionStatus.canceled) {
            context.read<SignInBloc>().add(StopEvent());
            Toasts.failure(
              context,
              message: "Une erreur est survenue. Veuillez réessayer plus tard.",
            );
          } else if (state.status.isFailure) {
            context.read<SignInBloc>().add(StopEvent());
            Toasts.failure(
              context,
              message: "Email ou mot de passe incorrect.",
            );
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
                      BlocBuilder<SignInBloc, SignInState>(
                        builder: (context, state) {
                          return Form(
                            key: _formKey,
                            // autovalidateMode: AutovalidateMode.disabled,
                            child: Column(
                              children: [
                                InputForm(
                                  title: 'Email',
                                  hint: 'Entrer votre email',
                                  type: TextInputType.emailAddress,
                                  errorText: state.email.isNotValid &&
                                          state.email.displayError?.name != null
                                      ? "${state.email.displayError?.name}: entrer un email valide"
                                      : null,
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
                                  type: TextInputType.number,
                                  obscure: true,
                                  errorText: state.password.isNotValid &&
                                          state.password.displayError?.name !=
                                              null
                                      ? "${state.password.displayError?.name}: entrer un minimum de 6 chiffres"
                                      : null,
                                  onChanged: (value) {
                                    context
                                        .read<SignInBloc>()
                                        .add(SignInPasswordChangedEvent(value));
                                  },
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                      const Gap(50),
                    ],
                  ),
                  BlocBuilder<SignInBloc, SignInState>(
                    builder: (context, state) {
                      return PrimaryButton(
                        onPressed: state.isValid
                            ? () {
                                context.read<SignInBloc>().add(SubmitEvent());
                                FocusScope.of(context).unfocus();
                              }
                            : null,
                        title: 'Connexion',
                        status: state.status,
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
