import 'package:flutter/material.dart';
import 'package:mafuriko/views/data/data_form.dart';
import 'package:mafuriko/views/home/components/bottom_nav_bar.dart';
import 'package:mafuriko/views/map/map.view.dart';
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
      body: SafeArea(top: false, child: page()),
      bottomNavigationBar: bottomNavBar(
        context: context,
        index: _currentIndex,
        onTap: (i) => setState(() => _currentIndex = i),
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
      const MapPage(),
      const DataForm(),
    ][_currentIndex];
  }
}
