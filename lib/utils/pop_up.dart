import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:mafuriko/providers/authentication/authentication_bloc.dart';
import 'package:mafuriko/routes/constants.dart';
import 'package:mafuriko/widgets/button.dart';

class PopUp {
  final String message;

  PopUp({required this.message});

  static Future<void> successAuth(BuildContext context,
      {required String message}) async {
    return await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          content: SizedBox(
            width: 332,
            height: 220,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 50.0,
                ),
                const CircleAvatar(
                  backgroundColor: Color(0XFF0B610F),
                  radius: 20.0,
                  child: Icon(
                    Icons.check,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(
                  height: 24,
                ),
                Text(
                  message,
                  textAlign: TextAlign.center,
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium
                      ?.copyWith(color: const Color(0xFF9FA0A0)),
                ),
                const SizedBox(
                  height: 15,
                ),
                PrimaryButton(
                  onPressed: () {
                    //
                  },
                  title: 'Page D\'acceuill',
                  width: 196,
                  color: const Color(0XFF111D4A),
                  textColor: Colors.white,
                )
              ],
            ),
          ),
        );
      },
    );
  }
  static Future<void> sendAlertSuccess(BuildContext context,
      {required String message}) async {
    return await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          content: SizedBox(
            width: 332,
            height: 220,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 50.0,
                ),
                const CircleAvatar(
                  backgroundColor: Color(0XFF0B610F),
                  radius: 20.0,
                  child: Icon(
                    Icons.check,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(
                  height: 24,
                ),
                Text(
                  message,
                  textAlign: TextAlign.center,
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium
                      ?.copyWith(color: const Color(0xFF9FA0A0)),
                ),
                const SizedBox(
                  height: 15,
                ),
                PrimaryButton(
                  onPressed: () {
                    context.pop();
                  },
                  title: 'Page de données',
                  width: 196,
                  color: const Color(0XFF111D4A),
                  textColor: Colors.white,
                )
              ],
            ),
          ),
        );
      },
    );
  }

  static Future<void> disconnetRequest(BuildContext context) async {
    return await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          content: SizedBox(
            width: 332,
            height: 220,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 50.0,
                ),
                const CircleAvatar(
                  backgroundColor: Color(0XFF0B610F),
                  radius: 20.0,
                  child: Icon(
                    Icons.check,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(
                  height: 24,
                ),
                Text(
                  'Etes vous sûr de vouloir vous deconnecter',
                  textAlign: TextAlign.center,
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium
                      ?.copyWith(color: const Color(0xFF9FA0A0)),
                ),
                const SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    PrimaryButton(
                      onPressed: () {
                        context.read<AuthenticationBloc>().add(AuthenticationLogoutRequested());
                            context.pushNamed(Paths.onboarding);
                      },
                      title: 'Oui',
                      width: 70.w,
                      color: const Color(0XFF111D4A) ,
                      textColor: Colors.white,
                    ),
                    PrimaryButton(
                      onPressed: () {
                        context.pop();
                      },
                      title: 'Non',
                      width: 70.w,
                      color: Colors.red,
                      textColor: Colors.white,
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
