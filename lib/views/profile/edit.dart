import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:mafuriko/providers/user.providers.dart';
import 'package:mafuriko/utils/themes.dart';
import 'package:mafuriko/widgets/button.dart';
import 'package:mafuriko/widgets/form.dart';
import 'package:mafuriko/widgets/section_title.dart';

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
                                child: CircleAvatar(
                                  radius: 35.r,
                                  backgroundColor: AppTheme.tertiaryColor,
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
                              Positioned(
                                right: .38.sw,
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
                          InputForm(
                            title: 'Nom ',
                            hint: 'Entrer votre nom ',
                            type: TextInputType.text,
                            controller: TextEditingController(text: '${state.user?.lastName}'),
                          ),
                          const Gap(17),
                          InputForm(
                            title: 'Prénoms ',
                            hint: 'Entrer vos Prénoms ',
                            type: TextInputType.text,
                            controller:
                                TextEditingController(text: '${state.user?.firstName}'),
                          ),
                          const Gap(17),
                          InputForm(
                            title: 'Numéro de téléphone ',
                            hint: 'Entrer votre numéro de téléphone ',
                            type: TextInputType.phone,
                            controller:
                                TextEditingController(text: '${state.user?.userNumber.contains('+225') == true? '' : '+225'} ${state.user?.userNumber}'),
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
