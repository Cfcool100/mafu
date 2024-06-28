import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_remix/flutter_remix.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:formz/formz.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:mafuriko/providers/profile/profile_bloc.dart';
import 'package:mafuriko/providers/user.providers.dart';
import 'package:mafuriko/utils/pop_up.dart';
import 'package:mafuriko/utils/themes.dart';
import 'package:mafuriko/utils/toasts.dart';
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
  final firstName = TextEditingController();
  final lastName = TextEditingController();
  final phoneNumber = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: BlocProvider(
        create: (context) => ProfileBloc(),
        child: BlocListener<ProfileBloc, ProfileState>(
          listener: (context, state) {
            if (state.status == FormzSubmissionStatus.success) {
              context.read<AuthenticationBloc>().add(AuthenticationGetUser());

              PopUp.successUpdate(context,
                  message:
                      "Profil utilisateur modifié avec succès. \nRevenir à la page profil");
              context.read<ProfileBloc>().add(Initial());
            } else if (state.status == FormzSubmissionStatus.failure) {
              Toasts.failure(
                context,
                message:
                    "Une erreur est survenue. Veuillez réessayer plus tard.",
              );
              context.read<ProfileBloc>().add(Initial());
            }
          },
          child: Scaffold(
            backgroundColor: CupertinoColors.white,
            appBar: AppBar(
                backgroundColor: CupertinoColors.white,
                leading: IconButton(
                    onPressed: () {
                      context.pop(true);
                      context
                          .read<ProfileBloc>()
                          .add(const ProfileUpdateEvent());
                    },
                    icon: const Icon(FlutterRemix.arrow_left_line),
                    color: Colors.black)),
            body: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Flexible(
                      child:
                          BlocBuilder<AuthenticationBloc, AuthenticationState>(
                        builder: (context, state) {
                          return ListView(
                            children: [
                              Gap(30.h),
                              const SectionTitle(title: 'Modifier profil'),
                              // Gap(100.h),
                              Stack(
                                alignment: Alignment.topCenter,
                                // clipBehavior: Clip.none,
                                children: [
                                  Container(
                                    height: 100.h,
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
                              BlocBuilder<ProfileBloc, ProfileState>(
                                builder: (context, state) {
                                  return InputForm(
                                    title: 'Nom ',
                                    hint: 'Entrer votre nom ',
                                    type: TextInputType.text,
                                    controller: lastName
                                      ..text = state.lastName.value
                                      ..selection = TextSelection.collapsed(
                                        offset: lastName.text.length,
                                      ),
                                    onChanged: (lastname) {
                                      context.read<ProfileBloc>().add(
                                          ProfileLastNameChangedEvent(
                                              lastname));
                                    },
                                  );
                                },
                              ),
                              const Gap(17),
                              BlocBuilder<ProfileBloc, ProfileState>(
                                builder: (context, state) {
                                  return InputForm(
                                    title: 'Prénoms ',
                                    hint: 'Entrer vos Prénoms ',
                                    type: TextInputType.text,
                                    controller: firstName
                                      ..text = state.firstName.value
                                      ..selection = TextSelection.collapsed(
                                        offset: firstName.text.length,
                                      ),
                                    onChanged: (firstname) {
                                      context.read<ProfileBloc>().add(
                                          ProfileFirstNameChangedEvent(
                                              firstname));
                                    },
                                  );
                                },
                              ),
                              const Gap(17),
                              BlocBuilder<ProfileBloc, ProfileState>(
                                builder: (context, state) {
                                  return InputForm(
                                    title: 'Numéro de téléphone ',
                                    hint: 'Entrer votre numéro de téléphone ',
                                    type: TextInputType.phone,
                                    controller: phoneNumber
                                      ..text = state.phoneNumber.value
                                      ..selection = TextSelection.collapsed(
                                        offset: phoneNumber.text.length,
                                      ),
                                    onChanged: (value) {
                                      context.read<ProfileBloc>().add(
                                          ProfilePhoneNumberChangedEvent(
                                              value));
                                    },
                                  );
                                },
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
                              BlocBuilder<ProfileBloc, ProfileState>(
                                builder: (context, state) {
                                  return PrimaryButton(
                                    status: state.status,
                                    onPressed: () {
                                      // PopUp.successAuth(context);
                                      context
                                          .read<ProfileBloc>()
                                          .add(SubmitForm());
                                    },
                                    title: 'Sauvegarder',
                                    color: AppTheme.primaryColor,
                                    textColor: Colors.white,
                                  );
                                },
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
    return InkWell(
      onTap: isModifiable
          ? () {
              context.read<ProfileBloc>().add(PickedImageFromGallery());
            }
          : null,
      child: Stack(
        children: [
          SizedBox(
            width: 70.w,
            height: 75.h,
          ),
          BlocBuilder<ProfileBloc, ProfileState>(
            builder: (context, state) {
              return CircleAvatar(
                radius: 35.r,
                backgroundColor: AppTheme.tertiaryColor,
                child: state.file != null
                    ? Container(
                        decoration: ShapeDecoration(
                          image: DecorationImage(
                            image: FileImage(File(state.file!.path)),
                            fit: state.file!.path.isNotEmpty
                                ? BoxFit.cover
                                : BoxFit.contain,
                          ),
                          shape: const CircleBorder(),
                        ),
                      )
                    : CustomImage(
                        isModifiable: isModifiable,
                        img: state.user?.profileImage ?? "",
                      ),
              );
            },
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
      ),
    );
  }
}

class CustomImage extends StatelessWidget {
  final String? img, errorWidgetImage;
  final bool isModifiable;

  const CustomImage({
    super.key,
    this.errorWidgetImage,
    required this.img,
    this.isModifiable = true,
  });

  @override
  Widget build(BuildContext context) {
    final validImg = img != null && img!.isNotEmpty;

    return validImg
        ? CachedNetworkImage(
            width: 70.w,
            height: 75.h,
            imageUrl: img!,
            imageBuilder: (context, imageProvider) {
              return InkWell(
                onTap: isModifiable
                    ? () {
                        // context
                        //     .read<ProfileBloc>()
                        //     .add(PickedImageFromGallery());
                      }
                    : null,
                child: Stack(
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
                            fit: BoxFit.cover,
                          ),
                          shape: const CircleBorder(),
                        ),
                      ),
                    ),
                    if (isModifiable)
                      Positioned(
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
                      ),
                  ],
                ),
              );
            },
            progressIndicatorBuilder: (context, url, downloadProgress) =>
                SizedBox(
              height: 15,
              width: 15,
              child: CircularProgressIndicator(
                value: downloadProgress.progress,
                valueColor: AlwaysStoppedAnimation(AppTheme.primaryColor),
              ),
            ),
            errorWidget: (context, url, error) => _buildErrorWidget(context),
          )
        : _buildErrorWidget(context);
  }

  Widget _buildErrorWidget(BuildContext context) {
    return InkWell(
      onTap: isModifiable
          ? () {
              context.read<ProfileBloc>().add(PickedImageFromGallery());
            }
          : null,
      child: Stack(
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
                  image: AssetImage(errorWidgetImage ?? 'images/profile.png'),
                  fit: BoxFit.contain,
                ),
                shape: const CircleBorder(),
              ),
            ),
          ),
          if (isModifiable)
            Positioned(
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
            ),
        ],
      ),
    );
  }
}
