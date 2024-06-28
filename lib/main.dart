import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:mafuriko/providers/alerts/alerts_bloc.dart';
import 'package:mafuriko/providers/profile/profile_bloc.dart';
import 'package:mafuriko/providers/user.providers.dart';
import 'package:mafuriko/routes/routes.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() async {
  await initializeDateFormatting('fr', null);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(390, 844),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => AuthenticationBloc(),
            ),
            BlocProvider(
              create: (context) => SignInBloc(),
            ),
            BlocProvider(
              create: (context) => SignupBloc(),
            ),
            BlocProvider(
              create: (context) => AlertsBloc(),
            ),
            BlocProvider(
              create: (context) => ProfileBloc(),
            ),
          ],
          child: MaterialApp.router(
            debugShowCheckedModeBanner: false,
            title: 'Flutter Demo',
            theme: ThemeData(
              useMaterial3: true,
            ),
            routerConfig: router,
            themeMode: ThemeMode.dark,
          ),
        );
      },
    );
  }
}
