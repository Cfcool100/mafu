import 'package:flutter/material.dart';
import 'package:flutter_remix/flutter_remix.dart';
import 'package:mafuriko/utils/themes.dart';
import 'package:mafuriko/views/data/data_form.dart';
import 'package:mafuriko/views/map/map.view.dart';
import 'package:mafuriko/views/profile/profile.view.dart';

import '../map/position_details.dart';
import 'home.dart';

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
      const PredictionPage(),
      const ProfilePage(),
    ][_currentIndex];
  }
}
