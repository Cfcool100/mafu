import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:gap/gap.dart';
import 'package:mafuriko/providers/signin/signin_bloc.dart';
import 'package:mafuriko/utils/pop_up.dart';
import 'package:mafuriko/utils/themes.dart';
import 'package:mafuriko/utils/toasts.dart';
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
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: BlocListener<SignInBloc, SignInState>(
        listener: (context, state) {
          if (state.status.isSuccess) {
            context.read<SignInBloc>().add(StopEvent());
            PopUp.successUpdate(context,
                message:
                    "Mot de passe modifié avec succès. \nRevenir à la page profil");
          } else if (state.status.isFailure) {
            Toasts.failure(
              context,
              message: "Mot de passe incorrect.",
            );
          } else if (state.status.isCanceled) {
            Toasts.failure(
              context,
              message: "Une erreur est survenue. Veuillez réessayer plus tard.",
            );
          }
        },
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.white,
          ),
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18.0),
              child: BlocBuilder<SignInBloc, SignInState>(
                builder: (context, state) {
                  return SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const Gap(30),
                        const SectionTitle(title: 'Modifier mot de passe'),
                        const Gap(50),
                        InputForm(
                          title: 'Mot de passe actuel',
                          hint: 'Entrer votre mot de passe',
                          type: TextInputType.number,
                          obscure: true,
                          errorText: state.currentPassword.isNotValid &&
                                  state.currentPassword.displayError?.name !=
                                      null
                              ? "${state.currentPassword.displayError?.name}: entrer un minimum de 6 chiffres "
                              : null,
                          onChanged: (value) {
                            context
                                .read<SignInBloc>()
                                .add(CurrentPasswordChangedEvent(value));
                          },
                        ),
                        const Gap(17),
                        InputForm(
                          title: 'Nouveau mot de passe',
                          hint: 'Entrer votre mot de passe',
                          type: TextInputType.number,
                          obscure: true,
                          errorText: state.newPassword.isNotValid &&
                                  state.newPassword.displayError?.name != null
                              ? "${state.newPassword.displayError?.name}: entrer un minimum de 6 chiffres"
                              : null,
                          onChanged: (value) {
                            context
                                .read<SignInBloc>()
                                .add(NewPasswordChangedEvent(value));
                          },
                        ),
                        const Gap(17),
                        InputForm(
                          title: 'Confirmation',
                          hint: 'confirmer le mot de passe',
                          type: TextInputType.number,
                          obscure: true,
                          errorText: state.newPassword.value ==
                                  state.newConfirmPassword.value
                              ? null
                              : state.newConfirmPassword.isNotValid &&
                                      state.newConfirmPassword.displayError
                                              ?.name !=
                                          null
                                  ? "* Confirmation de mot de passe requis"
                                  : "* Les mots de passe doivent être identiques",
                          onChanged: (value) {
                            context.read<SignInBloc>().add(
                                NewPasswordConfirmationChangedEvent(value));
                          },
                        ),
                        const Gap(50),
                        BlocBuilder<SignInBloc, SignInState>(
                          builder: (context, state) {
                            return PrimaryButton(
                              status: state.status,
                              onPressed: !state.isValid
                                  ? null
                                  : () {
                                      context
                                          .read<SignInBloc>()
                                          .add(NewPasswordSubmitEvent());
                                      FocusScope.of(context).unfocus();
                                    },
                              title: 'Sauvegarder',
                              color: AppTheme.primaryColor,
                              textColor: Colors.white,
                            );
                          },
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
