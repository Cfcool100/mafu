import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_remix/flutter_remix.dart';
import 'package:gap/gap.dart';
import 'package:mafuriko/utils/themes.dart';
import 'package:mafuriko/views/profile/edit.dart';
import 'package:mafuriko/views/profile/preference.dart';
import 'package:mafuriko/views/profile/security.dart';
import 'package:mafuriko/views/profile/user.dart';

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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Stack(
              alignment: Alignment.topCenter,
              clipBehavior: Clip.none,
              children: [
                Container(
                  height: MediaQuery.sizeOf(context).height * .12,
                  child: null,
                ),
                Positioned(
                  bottom: -20,
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
            const Gap(25.0),
            Column(
              children: [
                Text(
                  'Doumbia vamoussa',
                  style: AppTheme.regularTextH1,
                ),
                const Gap(10.0),
                OutlinedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, EditProfilePage.id);
                  },
                  child: Text(
                    'Edit Profile',
                    style: AppTheme.textBlackH6,
                  ),
                ),
                const Gap(10.0),
              ],
            ),
            const Gap(45.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18.0),
              child: Container(
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
                        Navigator.pushNamed(context, ProfileUser.id);
                      },
                      title: Text(
                        'Informations utilisateur',
                        style: AppTheme.textSemiBoldH5
                            .copyWith(fontWeight: FontWeight.w400),
                      ),
                      trailing: const Icon(FlutterRemix.user_3_line),
                    ),
                    ListTile(
                      onTap: () {
                        Navigator.pushNamed(context, SecurityPage.id);
                      },
                      title: Text(
                        'Modifier le mot de passe',
                        style: AppTheme.textSemiBoldH5
                            .copyWith(fontWeight: FontWeight.w400),
                      ),
                      trailing: const Icon(FlutterRemix.eye_off_line),
                    ),
                    ListTile(
                      onTap: () {},
                      title: Text(
                        'Historique des contributions',
                        style: AppTheme.textSemiBoldH5
                            .copyWith(fontWeight: FontWeight.w400),
                      ),
                      trailing: const Icon(CupertinoIcons.chart_bar_square),
                    ),
                    ListTile(
                      onTap: () {
                        Navigator.pushNamed(context, Preference.id);
                      },
                      title: Text(
                        'Préférences',
                        style: AppTheme.textSemiBoldH5
                            .copyWith(fontWeight: FontWeight.w400),
                      ),
                      trailing: const Icon(Icons.checklist_outlined),
                    ),
                  ],
                ),
              ),
            ),
            Gap(50),
            Stack(
              alignment: Alignment.bottomCenter,
              children: [
                Container(
                  height: MediaQuery.sizeOf(context).height * .18,
                ),
                Positioned(
                  bottom: MediaQuery.sizeOf(context).height * .14,
                  child: Column(
                    children: [
                      Text(
                        'En cas de de besoin, contactez notre équipe support.',
                        style: AppTheme.textBlackH6.copyWith(
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      Text(
                        'support@mafuriko.com',
                        style: AppTheme.textSemiRegularH5.copyWith(
                            color: AppTheme.secondaryColor, fontSize: 12),
                      ),
                    ],
                  ),
                  // child: Text(
                  //     'En cas de de besoin, contactez notre équipe support.'),
                ),
                Positioned(
                  bottom: MediaQuery.sizeOf(context).height * .0005,
                  child: Image.network(
                    "https://s3-alpha-sig.figma.com/img/37b6/cde9/f83c2c3e80a02d31e51b0c4708787971?Expires=1703462400&Signature=U5uZwTnRJGuhV50j1IUx~99rQ~vRg8zksWRLqWWvfdiHyBZWPNXfqewLpypSYzYDwwGTY6DrJNOud~slLwIIQlEaRv0XfooALRk-KXdnmk0ccSJCgMZDgxAd0HA9m-A8t55a1dwZtUxjgA~2iXE~0RhavhlRNZzCJl9XBH7O0cCTrScVPWvOBWGEEgTw7h~5VKQXV5A~Gu-8pKWqbAJ3kCtxoyqQSGBmjpVsXu2jzV8xCN2t0EF8CELAzfc-OUpBv72JQjirtUpG11XjMTxRj9RFilJxJakzXfBIKa0umP55yz0cZ0YBYeg5TAMyr1oqIxk0NegFkZTCljxkdVNM-Q__&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4",
                    width: 120,
                    height: 52,
                  ),
                ),
                Text(
                  'www.geodaftar.com',
                  style: AppTheme.textSemiBoldH5.copyWith(fontSize: 10),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
