import 'package:flutter/material.dart';
import 'package:mafuriko/widgets/button.dart';

class PopUp {
  final String message;

  PopUp({required this.message});

  Future<void> successAuth(BuildContext context) async {
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
                  this.message,
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
}
