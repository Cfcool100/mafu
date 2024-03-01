import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
import 'package:mafuriko/providers/user.providers.dart';
import 'package:mafuriko/routes/constants.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  final AuthenticationBloc authBloc = AuthenticationBloc();

  @override
  void initState() {
    super.initState();
    navigate(context);
  }

  void navigate(BuildContext context) {
    Future.delayed(const Duration(milliseconds: 2500), () {
      context.read<AuthenticationBloc>().stream.listen((event) {
        if (event.status.name == "authenticated") {
          debugPrint('${event.user?.firstName}');
          context.pushNamed(Paths.home);
        } else {
          debugPrint('empty');
          context.pushNamed(Paths.onboarding);
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          LottieBuilder.asset('images/splash_screen.json'),
        ],
      ),
    );
  }
}
