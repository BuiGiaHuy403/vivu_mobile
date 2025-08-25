import 'package:flutter/material.dart';
import 'package:vivu_mobile/core/common/widget/nav_bar/bottom_bar_screen.dart';
import 'package:vivu_mobile/feature/auth/presentation/login_screen.dart';
import 'package:vivu_mobile/feature/auth/presentation/signup_screen.dart';
import 'package:vivu_mobile/feature/home/presentation/home_screen.dart';



import '../../feature/explore/presentation/explore.dart';
import '../../feature/my_trip/presentation/my_trip_screen.dart';
import '../../feature/profile/presentation/profile.dart';
import '../common/widget/nav_bar/tab_item.dart';
import 'app_routes.dart';

class AppRoute {
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.login:
        return MaterialPageRoute(
          builder: (_) => const LoginScreen(),
          settings: settings,
        );
      case AppRoutes.signup:
        return MaterialPageRoute(
          builder: (_) => const SignupScreen(),
          settings: settings,
        );

        //<-- Bottom Bar -->
      case AppRoutes.home:
        return MaterialPageRoute(
          builder: (_) => const BottomBarScreen(initialTab: TabItem.home),
          settings: settings,
        );
      case AppRoutes.explore:
        return MaterialPageRoute(
          builder: (_) => const BottomBarScreen(initialTab: TabItem.explore),
          settings: settings,
        );
      case AppRoutes.myTrip:
        return MaterialPageRoute(
          builder: (_) => const BottomBarScreen(initialTab: TabItem.myTrip),
          settings: settings,
        );
      case AppRoutes.profile:
        return MaterialPageRoute(
          builder: (_) => const BottomBarScreen(initialTab: TabItem.profile),
          settings: settings,
        );
   
      default:
        return MaterialPageRoute(
          builder: (_) =>  Container(),
          settings: settings,
        );
    }
  }
}
