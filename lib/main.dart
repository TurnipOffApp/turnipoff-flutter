import 'package:flutter/material.dart';
import 'package:turnipoff/theme/theme_constant.dart';

import 'app_router.dart';
import 'constants/route_constant.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TurnipOff',
      debugShowCheckedModeBanner: false,
      builder: (context, widget) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
          child: widget!,
        );
      },
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: ThemeMode.dark, // Force dark theme
      onGenerateRoute: AppRouter.generateRoute,
      navigatorKey: navigatorKey,
      initialRoute: homeRoute,
    );
  }
}
