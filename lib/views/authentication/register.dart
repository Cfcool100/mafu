import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:formz/formz.dart';
import 'package:gap/gap.dart';

import 'package:mafuriko/providers/user.providers.dart';
import 'package:mafuriko/routes/constants.dart';
import 'package:mafuriko/utils/pop_up.dart';

import 'package:mafuriko/utils/themes.dart';
import 'package:mafuriko/widgets/button.dart';
import 'package:mafuriko/widgets/form.dart';
import 'package:mafuriko/widgets/link_text.dart';
import 'package:mafuriko/widgets/section_title.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: BlocListener<SignupBloc, SignupState>(
        listener: (context, state) async {
          if (state.isValid && state.status.isSuccess && mounted) {
            await Future.delayed(
              const Duration(seconds: 1),
              () {
                PopUp.successAuth(context,
                    message:
                        'Inscription réussie. \nAller à la page d’accueil ');
              },
            );
            await Future.delayed(
              const Duration(seconds: 2),
              () {
                context.read<AuthenticationBloc>().add(
                    AuthenticationStatusChanged(
                        AuthenticationStatus.authenticated));
              },
            );
            final pref = await SharedPreferences.getInstance();
            debugPrint(':::::::::::::${pref.getKeys()}');
          }
        },
        child: Scaffold(
          body: SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 18.0.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Flexible(
                    child: ListView(
                      children: [
                        SizedBox(width: 1.sw, height: 23.h),
                        Center(
                          child: Image.asset(
                            'images/Logo-blue.png',
                            scale: 1,
                          ),
                        ),
                        Gap(25.h),
                        const SectionTitle(title: 'Inscription'),
                        Gap(8.h),
                        BlocBuilder<SignupBloc, SignupState>(
                          builder: (context, state) {
                            return Form(
                              child: Column(
                                children: [
                                  InputForm(
                                    title: 'Email',
                                    hint: 'Entrer votre email',
                                    type: TextInputType.emailAddress,
                                    errorText: state.email.isNotValid &&
                                            state.email.displayError?.name !=
                                                null
                                        ? "* ${state.email.displayError?.name}: entrer un email valide"
                                        : null,
                                    onChanged: (value) {
                                      context
                                          .read<SignupBloc>()
                                          .add(SignupEmailChangedEvent(value));
                                    },
                                  ),
                                  Gap(13.h),
                                  Row(
                                    children: [
                                      InputForm(
                                        title: 'Nom ',
                                        hint: 'Entrer votre nom ',
                                        type: TextInputType.text,
                                        width: 130.w,
                                        errorText: state.lastname.isNotValid &&
                                                state.lastname.displayError
                                                        ?.name !=
                                                    null
                                            ? "* Nom est requis"
                                            : null,
                                        onChanged: (value) {
                                          context.read<SignupBloc>().add(
                                              SignupLastNameChangedEvent(
                                                  value));
                                        },
                                      ),
                                      const Spacer(),
                                      InputForm(
                                        title: 'Prénoms ',
                                        hint: 'Entrer vos Prénoms ',
                                        type: TextInputType.text,
                                        width: 170.w,
                                        errorText: state.firstname.isNotValid &&
                                                state.firstname.displayError
                                                        ?.name !=
                                                    null
                                            ? "* prénom est requis"
                                            : null,
                                        onChanged: (value) {
                                          context.read<SignupBloc>().add(
                                              SignupFirstNameChangedEvent(
                                                  value));
                                        },
                                      ),
                                    ],
                                  ),
                                  Gap(13.h),
                                  InputForm(
                                    title: 'Numéro de téléphone ',
                                    hint: 'Entrer votre numéro de téléphone ',
                                    type: TextInputType.phone,
                                    errorText: state.phoneNumber.isNotValid &&
                                            state.phoneNumber.displayError
                                                    ?.name !=
                                                null
                                        ? "${state.phoneNumber.displayError?.name}: entrer un numéro ivoirien"
                                        : null,
                                    onChanged: (value) {
                                      context.read<SignupBloc>().add(
                                          SignupPhoneNumberChangedEvent(value));
                                    },
                                  ),
                                  Gap(13.h),
                                  InputForm(
                                    title: 'Mot de passe',
                                    hint: 'Entrer votre mot de passe',
                                    type: TextInputType.number,
                                    obscure: true,
                                    errorText: state.password.isNotValid &&
                                            state.password.displayError?.name !=
                                                null
                                        ? "* entrer un minimum de 6 chiffres"
                                        : null,
                                    onChanged: (value) {
                                      context.read<SignupBloc>().add(
                                          SignupPasswordChangedEvent(value));
                                    },
                                  ),
                                  Gap(13.h),
                                  InputForm(
                                    title: 'Confirmation',
                                    hint: 'Confirmer le mot de passe',
                                    type: TextInputType.number,
                                    obscure: true,
                                    errorText: state.password.value ==
                                            state.confirmPassword.value
                                        ? null
                                        : state.confirmPassword.isNotValid &&
                                                state.confirmPassword
                                                        .displayError?.name !=
                                                    null
                                            ? "* Confirmation de mot de passe requis"
                                            : "* Les mots de passe doivent être identiques",
                                    onChanged: (value) {
                                      print(
                                          "is same ${state.confirmPassword == state.password}");
                                      context.read<SignupBloc>().add(
                                          SignupConfirmPasswordChangedEvent(
                                              value));
                                    },
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                        Gap(35.h),
                        BlocBuilder<SignupBloc, SignupState>(
                          builder: (context, state) {
                            debugPrint('${state.email.isValid}');
                            return PrimaryButton(
                              onPressed: state.isValid
                                  ? () {
                                      context
                                          .read<SignupBloc>()
                                          .add(SignupSubmitEvent());
                                      debugPrint(
                                          '::::::::::::::::::*${state.isValid}::::::::::*${state.status}');
                                    }
                                  : null,
                              title: 'Créer un compte',
                              status: state.status,
                              color: AppTheme.primaryColor,
                              textColor: Colors.white,
                            );
                          },
                        ),
                        Gap(15.h),
                        LinkText(
                          text: 'Vous avez déjà un compte?  ',
                          textLink: 'Connectez-vous',
                          link: Paths.login,
                          lineSize: 80.sp,
                        ),
                      ],
                    ),
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
