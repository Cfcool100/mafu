import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

import 'package:mafuriko/providers/user.providers.dart';
import 'package:mafuriko/routes/constants.dart';
import 'package:mafuriko/utils/themes.dart';
import 'package:mafuriko/widgets/button.dart';
import 'package:mafuriko/widgets/form.dart';
import 'package:mafuriko/widgets/link_text.dart';
import 'package:mafuriko/widgets/section_title.dart';

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
                      InputForm(
                        title: 'Email',
                        hint: 'Entrer votre email',
                        type: TextInputType.emailAddress,
                        onChanged: (value) {
                          context.read<SignupBloc>().add(SignupEmailChangedEvent(value));
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
                            onChanged: (value) {
                              context.read<SignupBloc>().add(SignupLastNameChangedEvent(value));
                            },
                          ),
                          const Spacer(),
                          InputForm(
                            title: 'Prénoms ',
                            hint: 'Entrer vos Prénoms ',
                            type: TextInputType.text,
                            width: 170.w,
                            onChanged: (value) {
                              context.read<SignupBloc>().add(SignupFirstNameChangedEvent(value));
                            },
                          ),
                        ],
                      ),
                      Gap(13.h),
                      InputForm(
                        title: 'Numéro de téléphone ',
                        hint: 'Entrer votre numéro de téléphone ',
                        type: TextInputType.phone,
                        onChanged: (value) {
                          context.read<SignupBloc>().add(SignupPhoneNumberChangedEvent(value));
                        },
                      ),
                      Gap(13.h),
                      InputForm(
                        title: 'Mot de passe',
                        hint: 'Entrer votre mot de passe',
                        type: TextInputType.text,
                        obscure: true,
                        onChanged: (value) {
                          context.read<SignupBloc>().add(SignupPasswordChangedEvent(value));
                        },
                      ),
                      Gap(13.h),
                      InputForm(
                        title: 'Confirmation',
                        hint: 'Confirmer le mot de passe',
                        type: TextInputType.text,
                        obscure: true,
                        onChanged: (value) {
                          context.read<SignupBloc>().add(SignupConfirmPasswordChangedEvent(value));
                        },
                      ),
                      Gap(35.h),
                      BlocBuilder<SignupBloc, SignupState>(
                        builder: (context, state) {
                          return PrimaryButton(
                            onPressed: state.isValid
                                ? () => context.pushNamed(Paths.home)
                                : null,
                            title: 'Créer un compte',
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
    );
  }
}
