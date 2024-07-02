// import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:formz/formz.dart';
import 'package:gap/gap.dart';
import 'package:location/location.dart';
// import 'package:mafuriko/controllers/alert.controller.dart';
import 'package:mafuriko/models/alert.models.dart';
import 'package:mafuriko/providers/alerts/alerts_bloc.dart';

import 'package:mafuriko/utils/themes.dart';
import 'package:mafuriko/views/home/components/home_component.dart';
import 'package:mafuriko/widgets/section_title.dart';
// import 'package:shared_preferences/shared_preferences.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // late Future<List<FloodAlert>> _futureAlerts;
  late AlertsBloc _alertsBloc;

  @override
  void initState() {
    super.initState();
    _alertsBloc = AlertsBloc()..add(FetchFloodAlerts());
    // _futureAlerts = Alert.fetchAlert();
    getLocate();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  double lat = 0;
  double lng = 0;
  Location location = Location();

  Future<void> getLocate() async {
    bool serviceEnabled;
    PermissionStatus permissionGranted;
    // LocationData _locationData;

    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return;
      }
    }

    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    location.onLocationChanged.listen((currentLocation) {
      if (mounted) {
        // Check if the widget is still mounted
        setState(() {
          if (currentLocation.latitude != null &&
              currentLocation.longitude != null) {
            lat = currentLocation.latitude!;
            lng = currentLocation.longitude!;
            // print(':::::::::::::::::::::::::$currentLocation');
          }
        });
      }
    });
  }

  final ScrollController _controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => _alertsBloc,
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: EdgeInsets.only(left: 18.w, right: 18.w, top: 18.w),
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
              const SliverToBoxAdapter(
                  child: CustomTiles(
                title: 'Entrer votre localisation',
                icon: Icons.navigate_next,
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
                  height: 374.h,
                  child: BlocBuilder<AlertsBloc, AlertsState>(
                    builder: (context, state) {
                      if (state.status == FormzSubmissionStatus.inProgress) {
                        return SpinKitRing(
                          color: Colors.blueAccent.shade100,
                          size: 50.h,
                          lineWidth: 3.5.w,
                        );
                      } else if (state.status ==
                          FormzSubmissionStatus.failure) {
                        return const Center(
                          child: Text('Aucune alerte d\'inondation disponible'),
                        );
                      } else if (state.alerts.isEmpty) {
                        return Center(
                          child: Text(
                            'Aucune alerte d\'inondation disponible',
                            style: AppTheme.textSemiRegularH5,
                          ),
                        );
                      } else {
                        List<FloodAlert> floodAlerts = state.alerts;
                        floodAlerts
                            .sort((a, b) => b.floodDate.compareTo(a.floodDate));
                        return ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: floodAlerts.length,
                          itemBuilder: (context, index) {
                            return AlertInfosCard(
                              data: floodAlerts[index],
                              index: index,
                            );
                          },
                        );
                      }
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
