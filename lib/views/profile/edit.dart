import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
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
                  child: ListView(
                    children: [
                      // const SizedBox(width: double.infinity, height: 25.0),
                      const Gap(30),
                      const SectionTitle(title: 'Modifier profil'),
                      const Gap(100),
                      Stack(
                        alignment: Alignment.topCenter,
                        clipBehavior: Clip.none,
                        children: [
                          Container(
                            // height: MediaQuery.sizeOf(context).height * .12,
                            // // color: AppTheme.primaryColor,
                            margin: EdgeInsets.only(
                              top: MediaQuery.of(context).size.height * .02,
                              bottom: MediaQuery.of(context).size.height * .01,
                            ),
                            child: null,
                          ),
                          Positioned(
                            bottom: 10,
                            child: CircleAvatar(
                              radius: 35,
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
                            right: MediaQuery.sizeOf(context).width * .38,
                            bottom: 2,
                            child: CircleAvatar(
                              backgroundColor: AppTheme.primaryColor,
                              radius: 12,
                              child: const Icon(
                                Icons.camera_alt_outlined,
                                color: Colors.white,
                                size: 15,
                              ),
                            ),
                          ),
                        ],
                      ),
                      InputForm(
                        title: 'Nom ',
                        hint: 'Entrer votre npm ',
                        type: TextInputType.text,
                        onChanged: (value) {
                          setState(() {
                            // _lastname = value;
                          });
                        },
                      ),
                      const Gap(17),
                      InputForm(
                        title: 'Prénoms ',
                        hint: 'Entrer vos Prénoms ',
                        type: TextInputType.text,
                        onChanged: (value) {
                          setState(() {
                            // _firstname = value;
                          });
                        },
                      ),
                      const Gap(17),
                      InputForm(
                        title: 'Numéro de téléphone ',
                        hint: 'Entrer votre numéro de téléphone ',
                        type: TextInputType.phone,
                        onChanged: (value) {
                          setState(() {
                            // _number = value;
                          });
                        },
                      ),
                      const Gap(17),
                      InputForm(
                        title: 'Localisation',
                        hint: 'Entrer votre mot de passe',
                        type: TextInputType.text,
                        onChanged: (value) {
                          setState(() {
                            // _password = value;
                          });
                        },
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
