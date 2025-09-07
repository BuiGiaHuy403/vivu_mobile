import 'package:flutter/material.dart';
import 'package:vivu_mobile/core/routes/app_routes.dart';
import 'core/di/service_locator.dart';

import 'core/routes/app_router.dart';

void main() {
  setup();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
    const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      initialRoute: AppRoutes.splashScreen,
      onGenerateRoute: AppRoute.onGenerateRoute,
    );
  }
}


