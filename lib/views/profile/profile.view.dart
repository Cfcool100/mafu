import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_remix/flutter_remix.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:mafuriko/providers/authentication/authentication_bloc.dart';
import 'package:mafuriko/routes/constants.dart';
import 'package:mafuriko/utils/themes.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});
  static String id = '/profile';

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CupertinoColors.white,
      body: SafeArea(
        bottom: false,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Stack(
              alignment: Alignment.topCenter,
              clipBehavior: Clip.none,
              children: [
                SizedBox(height: .12.sh),
                Positioned(
                  bottom: -10.h,
                  child: CircleAvatar(
                    radius: 35.r,
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
            Gap(18.h),
            BlocBuilder<AuthenticationBloc, AuthenticationState>(
              builder: (context, state) {
                return Column(
                  children: [
                    Text(
                      '${state.user?.lastName} ${state.user?.firstName}',
                      style: AppTheme.regularTextH1,
                    ),
                    Gap(10.h),
                    OutlinedButton(
                      onPressed: () {
                        context.pushNamed(Paths.editProfile);
                      },
                      child: Text(
                        'Edit Profile',
                        style: AppTheme.textBlackH6,
                      ),
                    ),
                  ],
                );
              },
            ),
            Gap(25.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 18.w),
              child: const AppFeatures(),
            ),
            Gap(20.h),
            Stack(
              alignment: Alignment.bottomCenter,
              children: [
                Container(
                  height: .3.sh - 90.h,
                ),
                Positioned(
                  top: .1..sh,
                  child: Column(
                    children: [
                      Text(
                        'En cas de de besoin, contactez notre équipe support.',
                        style: AppTheme.textSemiRegularH5.copyWith(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      Text(
                        'support@mafuriko.com',
                        style: AppTheme.textSemiRegularH5.copyWith(
                          color: AppTheme.secondaryColor,
                          fontSize: 12.sp,
                        ),
                      ),
                    ],
                  ),
                ),
                Column(
                  children: [
                    Image.asset(
                      'images/geodaftar-logo.png',
                      height: 52.h,
                    ),
                    Text(
                      'www.geodaftar.com',
                      textAlign: TextAlign.center,
                      style: AppTheme.textSemiBoldH5
                          .copyWith(fontSize: 12.sp, height: .16.sp),
                    ),
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class AppFeatures extends StatelessWidget {
  const AppFeatures({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: ShapeDecoration(
        color: CupertinoColors.white,
        shadows: const [
          BoxShadow(
            color: Color(0x3F000000),
            blurRadius: 3,
            offset: Offset(0, 1),
            spreadRadius: -1,
          )
        ],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      child: Column(
        children: [
          ListTile(
            onTap: () {
              context.pushNamed(Paths.userProfile);
            },
            title: Text(
              'Informations utilisateur',
              style:
                  AppTheme.textSemiBoldH5.copyWith(fontWeight: FontWeight.w400),
            ),
            trailing: const Icon(FlutterRemix.user_3_line),
          ),
          ListTile(
            onTap: () {
              context.pushNamed(Paths.security);
            },
            title: Text(
              'Modifier le mot de passe',
              style:
                  AppTheme.textSemiBoldH5.copyWith(fontWeight: FontWeight.w400),
            ),
            trailing: const Icon(FlutterRemix.eye_off_line),
          ),
          ListTile(
            onTap: () {},
            title: Text(
              'Historique des contributions',
              style:
                  AppTheme.textSemiBoldH5.copyWith(fontWeight: FontWeight.w400),
            ),
            trailing: const Icon(CupertinoIcons.chart_bar_square),
          ),
          ListTile(
            onTap: () {
              context.pushNamed(Paths.preference);
            },
            title: Text(
              'Préférences',
              style:
                  AppTheme.textSemiBoldH5.copyWith(fontWeight: FontWeight.w400),
            ),
            trailing: const Icon(Icons.checklist_outlined),
          ),
        ],
      ),
    );
  }
}
