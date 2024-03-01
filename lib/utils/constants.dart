import 'package:flutter/material.dart';
import 'package:flutter_remix/flutter_remix.dart';

final List<BottomNavigationBarItem> navBar =  [
  const BottomNavigationBarItem(icon: Icon(FlutterRemix.home_line), label: 'Home'),
  const BottomNavigationBarItem(
      icon: Icon(FlutterRemix.stack_line), label: 'Donnees'),
  const BottomNavigationBarItem(
      backgroundColor: Colors.red, icon: Icon(null), label: 'Carte'),
  const BottomNavigationBarItem(
      icon: Icon(FlutterRemix.line_chart_line), label: 'Prediction'),
  const BottomNavigationBarItem(
      icon: Icon(FlutterRemix.user_3_line), label: 'Profil'),
];
