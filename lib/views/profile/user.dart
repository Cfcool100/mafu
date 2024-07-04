import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:mafuriko/providers/profile/profile_bloc.dart';
import 'package:mafuriko/utils/themes.dart';
import 'package:mafuriko/views/profile/edit.dart';
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
          padding: const EdgeInsets.symmetric(horizontal: 18.0),
          child: Column(
            children: [
              const Gap(30),
              const SectionTitle(title: 'Utilisateur'),
              const Gap(70),
              Stack(
                alignment: Alignment.topCenter,
                clipBehavior: Clip.none,
                children: [
                  Container(
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
                    child: BlocBuilder<ProfileBloc, ProfileState>(
                      builder: (context, state) {
                        return Column(
                          children: [
                            Gap(35.h),
                            ListTile(
                              title: Text(
                                'Nom',
                                style: AppTheme.textSemiBoldH5
                                    .copyWith(fontWeight: FontWeight.w400),
                              ),
                              trailing: Text(
                                '${state.user?.lastName} ${state.user?.firstName}',
                                style: AppTheme.textSemiRegularH5
                                    .copyWith(fontSize: 12.sp),
                              ),
                            ),
                            Divider(
                              height: 1.h,
                              indent: 15.w,
                              endIndent: 15.w,
                            ),
                            ListTile(
                              title: Text(
                                'Numéro',
                                style: AppTheme.textSemiBoldH5
                                    .copyWith(fontWeight: FontWeight.w400),
                              ),
                              trailing: Text(
                                '${state.user?.userNumber?.contains('+225') == true ? '' : '+225'} ${state.phoneNumber.value}',
                                style: AppTheme.textSemiRegularH5
                                    .copyWith(fontSize: 12.sp),
                              ),
                            ),
                            Divider(
                              height: 1.h,
                              indent: 15.w,
                              endIndent: 15.w,
                            ),
                            ListTile(
                              title: Text(
                                'Email',
                                style: AppTheme.textSemiBoldH5
                                    .copyWith(fontWeight: FontWeight.w400),
                              ),
                              trailing: Text(
                                '${state.user?.userEmail}',
                                style: AppTheme.textSemiRegularH5
                                    .copyWith(fontSize: 12.sp),
                              ),
                            ),
                            Divider(
                              height: 1.h,
                              indent: 15.w,
                              endIndent: 15.w,
                            ),
                            Gap(25.h)
                          ],
                        );
                      },
                    ),
                  ),
                  Positioned(
                    top: -35.h,
                    child: const AvatarProfile(
                      isModifiable: false,
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
