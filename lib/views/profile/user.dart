import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_remix/flutter_remix.dart';
import 'package:gap/gap.dart';
import 'package:mafuriko/utils/themes.dart';
import 'package:mafuriko/widgets/section_title.dart';

class ProfileUser extends StatelessWidget {
  const ProfileUser({super.key});
  static String id = '/profile/user';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 18.0),
          child: Column(
            children: [
              Gap(30),
              SectionTitle(title: 'Utilisateur'),
              Gap(70),
              Stack(
                alignment: Alignment.topCenter,
                clipBehavior: Clip.none,
                children: [
                  Container(
                    height: MediaQuery.sizeOf(context).height * .25,
                    decoration: ShapeDecoration(
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      shadows: const [
                        BoxShadow(
                          color: Color(0x3F000000),
                          blurRadius: 4,
                          offset: Offset(0, 4),
                          spreadRadius: 0,
                        )
                      ],
                    ),
                    child: Column(
                      children: [
                        Gap(30),
                        ListTile(
                          title: Text(
                            'Nom',
                            style: AppTheme.textSemiBoldH5
                                .copyWith(fontWeight: FontWeight.w400),
                          ),
                          trailing: Text(
                            'N’DA Olivier Trésor',
                            style: AppTheme.textSemiRegularH5
                                .copyWith(fontSize: 12.0),
                          ),
                        ),
                        Divider(
                          height: 1,
                          indent: 15,
                          endIndent: 15,
                        ),
                        ListTile(
                          title: Text(
                            'Numéro',
                            style: AppTheme.textSemiBoldH5
                                .copyWith(fontWeight: FontWeight.w400),
                          ),
                          trailing: Text(
                            '+225 07 88 42 15 38',
                            style: AppTheme.textSemiRegularH5
                                .copyWith(fontSize: 12.0),
                          ),
                        ),
                        Divider(
                          height: 1,
                          indent: 15,
                          endIndent: 15,
                        ),
                        ListTile(
                          title: Text(
                            'Email',
                            style: AppTheme.textSemiBoldH5
                                .copyWith(fontWeight: FontWeight.w400),
                          ),
                          trailing: Text(
                            'oliviernda@gmail.com',
                            style: AppTheme.textSemiRegularH5
                                .copyWith(fontSize: 12.0),
                          ),
                        ),
                        Divider(
                          height: 1,
                          indent: 15,
                          endIndent: 15,
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    top: -35,
                    child: CircleAvatar(
                      radius: 35,
                      backgroundColor: AppTheme.secondaryColor,
                      child: Container(
                        decoration: const ShapeDecoration(
                          image: DecorationImage(
                            image: AssetImage('images/profile.png'),
                            fit: BoxFit.contain,
                          ),
                          shape: CircleBorder(),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
