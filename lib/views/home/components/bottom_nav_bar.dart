import 'package:flutter/material.dart';
import 'package:mafuriko/utils/constants.dart';
import 'package:mafuriko/utils/themes.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

SalomonBottomBar bottomNavBar(
    {required BuildContext context, Function(int)? onTap, required int index}) {
  return SalomonBottomBar(
    unselectedItemColor: AppTheme.primaryColor,
    currentIndex: index,
    onTap: onTap,
    items: navBar(index),
  );
}
