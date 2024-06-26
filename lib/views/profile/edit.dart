import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:mafuriko/providers/user.providers.dart';
import 'package:mafuriko/utils/themes.dart';
import 'package:mafuriko/widgets/button.dart';
import 'package:mafuriko/widgets/form.dart';
import 'package:mafuriko/widgets/section_title.dart';
import 'package:cached_network_image/cached_network_image.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});
  static String id = '/profile/edit';

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Flexible(
                  child: BlocBuilder<AuthenticationBloc, AuthenticationState>(
                    builder: (context, state) {
                      return ListView(
                        children: [
                          Gap(30.h),
                          const SectionTitle(title: 'Modifier profil'),
                          Gap(100.h),
                          Stack(
                            alignment: Alignment.topCenter,
                            clipBehavior: Clip.none,
                            children: [
                              Container(
                                margin: EdgeInsets.only(
                                  top: .02.sh,
                                  bottom: .01.sh,
                                ),
                              ),
                              Positioned(
                                bottom: 10.h,
                                child: const AvatarProfile(),
                              ),
                            ],
                          ),
                          InputForm(
                            title: 'Nom ',
                            hint: 'Entrer votre nom ',
                            type: TextInputType.text,
                            controller: TextEditingController(
                                text: '${state.user?.lastName}'),
                          ),
                          const Gap(17),
                          InputForm(
                            title: 'Prénoms ',
                            hint: 'Entrer vos Prénoms ',
                            type: TextInputType.text,
                            controller: TextEditingController(
                                text: '${state.user?.firstName}'),
                          ),
                          const Gap(17),
                          InputForm(
                            title: 'Numéro de téléphone ',
                            hint: 'Entrer votre numéro de téléphone ',
                            type: TextInputType.phone,
                            controller: TextEditingController(
                                text:
                                    '${state.user?.userNumber.contains('+225') == true ? '' : '+225'} ${state.user?.userNumber}'),
                          ),
                          const Gap(17),
                          InputForm(
                            title: 'Localisation',
                            hint: 'Entrer votre mot de passe',
                            controller: TextEditingController(
                                text: 'Bonoumin, Cocody, Abidjan'),
                            type: TextInputType.text,
                          ),
                          const Gap(50),
                          PrimaryButton(
                            onPressed: () {
                              // PopUp.successAuth(context);
                              Navigator.pushNamed(context, 'HomePage.id');
                            },
                            title: 'Créer un compte',
                            color: AppTheme.primaryColor,
                            textColor: Colors.white,
                          ),
                        ],
                      );
                    },
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

class AvatarProfile extends StatelessWidget {
  const AvatarProfile({super.key, this.isModifiable = true});

  final bool isModifiable;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          width: 70.w,
          height: 75.h,
        ),
        CircleAvatar(
          radius: 35.r,
          backgroundColor: AppTheme.tertiaryColor,
          child: Container(
            decoration: ShapeDecoration(
              image: DecorationImage(
                image: FileImage(File('state.file!.path')),
                fit: BoxFit.contain,
              ),
              shape: const CircleBorder(),
            ),
          ),
        ),
        isModifiable
            ? Positioned(
                right: 5.w,
                bottom: 3.h,
                child: CircleAvatar(
                  backgroundColor: AppTheme.primaryColor,
                  radius: 10.r,
                  child: Icon(
                    Icons.camera_alt_outlined,
                    color: Colors.white,
                    size: 12.w,
                  ),
                ),
              )
            : Container(),
      ],
    );
  }
}

class CustomImage extends StatelessWidget {
  final String? img, errorWidgetImage;

  final bool isModifiable;
  const CustomImage(
      {super.key,
      this.errorWidgetImage,
      required this.img,
      this.isModifiable = true});

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      width: 70.w,
      height: 75.h,
      imageUrl: img!,
      imageBuilder: (context, imageProvider) {
        return Stack(
          children: [
            SizedBox(
              width: 70.w,
              height: 75.h,
            ),
            CircleAvatar(
              radius: 35.r,
              backgroundColor: AppTheme.tertiaryColor,
              child: Container(
                decoration: ShapeDecoration(
                  image: DecorationImage(
                      image: imageProvider,
                      fit: BoxFit.contain,
                      colorFilter: const ColorFilter.mode(
                          Colors.transparent, BlendMode.colorBurn)),
                  shape: const CircleBorder(),
                ),
              ),
            ),
            isModifiable
                ? Positioned(
                    right: 5.w,
                    bottom: 3.h,
                    child: CircleAvatar(
                      backgroundColor: AppTheme.primaryColor,
                      radius: 10.r,
                      child: Icon(
                        Icons.camera_alt_outlined,
                        color: Colors.white,
                        size: 12.w,
                      ),
                    ),
                  )
                : Container(),
          ],
        );
      },
      progressIndicatorBuilder: (context, url, downloadProgress) => SizedBox(
        height: 15,
        width: 15,
        child: Container(
            decoration: const ShapeDecoration(
              shape: CircleBorder(),
              color: Colors.transparent,
            ),
            child: SizedBox(
              height: 15,
              width: 15,
              child: CircularProgressIndicator(
                  value: downloadProgress.progress,
                  valueColor: AlwaysStoppedAnimation(AppTheme.primaryColor)),
            )),
      ),
      errorWidget: (context, url, error) => Container(
        width: 70.w,
        height: 75.h,
        clipBehavior: Clip.antiAlias,
        decoration: ShapeDecoration(
            shape: const CircleBorder(),
            image: DecorationImage(
                image: AssetImage(errorWidgetImage ?? 'images/profile.png'))),
      ),
    );
  }
}
