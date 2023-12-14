import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_remix/flutter_remix.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mafuriko/utils/themes.dart';
import 'package:mafuriko/views/data/data_form.dart';
import 'package:mafuriko/views/map/map.view.dart';
import 'package:mafuriko/views/profile/profile.view.dart';
import 'package:mafuriko/widgets/section_title.dart';

import '../map/position_details.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  static String id = '/home';

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: page(),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: AppTheme.secondaryColor,
        showUnselectedLabels: true,
        unselectedItemColor: AppTheme.primaryColor,
        onTap: (value) => setState(() {
          _currentIndex = value;
        }),
        currentIndex: _currentIndex,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(FlutterRemix.home_line), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(FlutterRemix.stack_line), label: 'Donnees'),
          BottomNavigationBarItem(
              backgroundColor: Colors.red, icon: Icon(null), label: 'Carte'),
          BottomNavigationBarItem(
              icon: Icon(FlutterRemix.line_chart_line), label: 'Prediction'),
          BottomNavigationBarItem(
              icon: Icon(FlutterRemix.user_3_line), label: 'Profil'),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
        backgroundColor: const Color(0xFFFFCF99),
        onPressed: () {
          setState(() {
            _currentIndex = 2;
          });
        },
        child: const CircleAvatar(
          backgroundColor: Color(0xFFFFCF99),
          child: Icon(FlutterRemix.map_2_line),
        ),
      ),
    );
  }

  setCurrentIndex(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  Widget page() {
    return [
      const Home(),
      const DataForm(),
      const MapPage(),
      const ShowTimePickerApp(),
      const ProfilePage(),
    ][_currentIndex];
  }
}

class Home extends StatelessWidget {
  const Home({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18.0),
        child: Column(
          children: [
            Container(
              width: MediaQuery.sizeOf(context).width,
              height: 90.0,
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              decoration: BoxDecoration(
                border: const Border(),
                borderRadius: BorderRadius.circular(5),
                color: AppTheme.primaryColor,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '20º',
                        style: GoogleFonts.montserrat(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          const Icon(
                            CupertinoIcons.sun_haze,
                            color: Colors.white,
                          ),
                          const Gap(5),
                          Text(
                            'Ensoleillé',
                            textAlign: TextAlign.end,
                            style: GoogleFonts.montserrat(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        'Cocody, Abidjan',
                        style: GoogleFonts.montserrat(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      const Gap(5),
                      Text(
                        'Ensoleillé',
                        textAlign: TextAlign.end,
                        style: GoogleFonts.montserrat(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                      const Gap(10),
                    ],
                  ),
                ],
              ),
            ),
            const Gap(25.0),
            const SectionTitle(title: 'Actualités', width: 15.0),
            Container(
              height: 40.0,
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              decoration: ShapeDecoration(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  color: Colors.grey.shade300.withOpacity(.7)),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Entrer votre localisation'),
                  Icon(Icons.navigate_next),
                ],
              ),
            ),
            const Gap(8.0),
            Container(
              height: 40.0,
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              decoration: ShapeDecoration(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0),
                ),
                color: Colors.green.shade400.withOpacity(.7),
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Zone sans danger'),
                  Icon(Icons.check_box_outlined),
                ],
              ),
            ),
            const Gap(30.0),
            const SectionTitle(title: 'Alertes récentes', width: 15.0),
            const Gap(10.0),
            SizedBox(
              height: 180,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 3,
                itemBuilder: (context, index) => Container(
                  // height: 173,
                  width: 145,
                  margin: index % 2 == 1
                      ? const EdgeInsets.symmetric(
                          horizontal: 18.0, vertical: 5.0)
                      : const EdgeInsets.symmetric(
                          horizontal: 5.0, vertical: 5.0),
                  decoration: BoxDecoration(
                    boxShadow: const [
                      BoxShadow(
                        color: Color(0x3F000000),
                        blurRadius: 4,
                        offset: Offset(0, 1),
                        spreadRadius: -1,
                      )
                    ],
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  // clipBehavior: Clip.antiAlias,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 85.0,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('images/background.jpg'),
                            fit: BoxFit.cover,
                          ),
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(30)),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8.0, vertical: 5.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Marché cocovico',
                              textAlign: TextAlign.start,
                              style: AppTheme.textBlackH6
                                  .copyWith(fontWeight: FontWeight.w400),
                            ),
                            Text(
                              'Cocody, Abidjan',
                              style: AppTheme.textBlackH6.copyWith(
                                  fontSize: 8.0, fontWeight: FontWeight.w300),
                            ),
                            const Gap(20),
                            const Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('4.3 CM'),
                                Text('23 min'),
                              ],
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const Gap(20),
            const SectionTitle(
                title: 'Statistique et rapports récentes', width: 15.0),
          ],
        ),
      ),
    );
  }
}