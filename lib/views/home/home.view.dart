import 'package:flutter/material.dart';
import 'package:flutter_remix/flutter_remix.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mafuriko/views/data/data_form.dart';
import 'package:mafuriko/views/home/components/bottom_nav_bar.dart';
import 'package:mafuriko/views/map/map.view.dart';
import 'package:mafuriko/views/profile/profile.view.dart';
import 'package:mafuriko/views/map/position_details.dart';
import 'home.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: page()),
      bottomNavigationBar: bottomNavBar(
        context: context,
        index: _currentIndex,
        onTap: (value) => setState(() {
          _currentIndex = value;
        }),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        elevation: 0,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(50.r)),
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
      Home(),
      const DataForm(),
      const MapPage(),
      const PredictionPage(),
      const ProfilePage(),
    ][_currentIndex];
  }
}
