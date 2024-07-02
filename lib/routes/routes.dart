import 'package:go_router/go_router.dart';
import 'package:mafuriko/routes/constants.dart';
import 'package:mafuriko/views/authentication/login.dart';
import 'package:mafuriko/views/authentication/register.dart';
import 'package:mafuriko/views/data/data_form.dart';
import 'package:mafuriko/views/home/home.view.dart';
import 'package:mafuriko/views/onboarding/onboarding.dart';
import 'package:mafuriko/views/onboarding/splash_screen.dart';
import 'package:mafuriko/views/profile/edit.dart';
import 'package:mafuriko/views/profile/historical.dart';
import 'package:mafuriko/views/profile/preference.dart';
import 'package:mafuriko/views/profile/profile.view.dart';
import 'package:mafuriko/views/profile/security.dart';
import 'package:mafuriko/views/profile/user.dart';

final GoRouter router = GoRouter(routes: [
  GoRoute(
    path: Paths.baseRoute,
    builder: (context, state) => const SplashScreen(),
    name: Paths.baseRoute,
  ),
  GoRoute(
    path: '/${Paths.onboarding}',
    builder: (context, state) => const OnBoarding(),
    name: Paths.onboarding,
  ),
  GoRoute(
    path: '/${Paths.login}',
    builder: (context, state) => const LoginPage(),
    name: Paths.login,
  ),
  GoRoute(
    path: '/${Paths.register}',
    builder: (context, state) => const RegisterPage(),
    name: Paths.register,
  ),
  GoRoute(
    path: '/${Paths.home}',
    builder: (context, state) => const HomePage(),
    name: Paths.home,
  ),
  GoRoute(
    path: '/${Paths.dataForm}',
    builder: (context, state) => const DataForm(),
    name: Paths.dataForm,
  ),
  GoRoute(
    path: '/${Paths.profile}',
    builder: (context, state) => const ProfilePage(),
    name: Paths.profile,
  ),
  GoRoute(
    path: '/${Paths.userProfile}',
    builder: (context, state) => const ProfileUser(),
    name: Paths.userProfile,
  ),
  GoRoute(
    path: '/${Paths.editProfile}',
    builder: (context, state) => const EditProfilePage(),
    name: Paths.editProfile,
  ),
  GoRoute(
    path: '/${Paths.security}',
    builder: (context, state) => const SecurityPage(),
    name: Paths.security,
  ),
  GoRoute(
    path: '/${Paths.preference}',
    builder: (context, state) => const Preference(),
    name: Paths.preference,
  ),
  GoRoute(
    path: '/${Paths.historical}',
    builder: (context, state) => const Historical(),
    name: Paths.historical,
  ),
]);
