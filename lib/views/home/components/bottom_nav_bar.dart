import 'package:flutter/material.dart';
import 'package:mafuriko/utils/constants.dart';
import 'package:mafuriko/utils/themes.dart';

BottomNavigationBar bottomNavBar({required BuildContext context, Function(int)? onTap, required int index}) {
  return BottomNavigationBar(
    type: BottomNavigationBarType.fixed,
    selectedItemColor: AppTheme.secondaryColor,
    showUnselectedLabels: true,
    unselectedItemColor: AppTheme.primaryColor,
    onTap: onTap,
    currentIndex: index,
    items: navBar,
  );
}
