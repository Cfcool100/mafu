import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:mafuriko/controllers/alert.controller.dart';
import 'package:mafuriko/models/alert.models.dart';
import 'package:mafuriko/views/home/components/home_component.dart';
import 'package:mafuriko/widgets/section_title.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Home extends StatelessWidget {
  Home({super.key});

  final ScrollController _controller = ScrollController();

  Future<List<FloodAlert>> getFloodAlerts() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    final String? jsonString = pref.getString('FloodAlert');
    if (jsonString != null) {
      final List<dynamic> jsonList = jsonDecode(jsonString);
      List<FloodAlert> alerts =
          jsonList.map((json) => FloodAlert.fromJson(json)).toList();
      return alerts;
    } else {
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 18.w),
        child: CustomScrollView(
          controller: _controller,
          slivers: [
            const SliverToBoxAdapter(child: Dashboard()),
            SliverGap(23.h),
            SliverToBoxAdapter(
              child: SectionTitle(
                title: 'Actualités',
                width: 15.w,
              ),
            ),
            SliverToBoxAdapter(
                child: GestureDetector(
              onTap: () {
                Alert.fetchAlert();
              },
              child: const CustomTiles(
                title: 'Entrer votre localisation',
                icon: Icons.navigate_next,
              ),
            )),
            SliverGap(8.0.h),
            SliverToBoxAdapter(
              child: CustomTiles(
                title: 'Zone sans danger',
                icon: Icons.check_box_outlined,
                color: Colors.green.shade400.withOpacity(.7),
              ),
            ),
            SliverGap(25.h),
            SliverToBoxAdapter(
              child: SectionTitle(
                title: 'Alertes récentes',
                width: 15.w,
              ),
            ),
            SliverGap(10.h),
            SliverToBoxAdapter(
              child: SizedBox(
                height: 175.h,
                child: FutureBuilder<List<FloodAlert>>(
                    future: getFloodAlerts(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const CircularProgressIndicator();
                      } else if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                        return const Text('No Flood Alerts available');
                      } else {
                        List<FloodAlert> floodAlerts = snapshot.data!;
                        return ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: floodAlerts.length,
                          itemBuilder: (context, index) => AlertInfosCard(
                            spaceBetween: index % 2 == 1 ? 15.w : 5.w,
                          ),
                        );
                      }
                    }),
              ),
            ),
            SliverGap(18.h),
            SliverToBoxAdapter(
              child: SectionTitle(
                title: 'Statistique et rapports récentes',
                width: 15.w,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
