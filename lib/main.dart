import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:turnipoff/theme/theme_constant.dart';
import 'package:turnipoff/theme/theme_manager.dart';

import 'app_router.dart';
import 'constants/route_constant.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
final ThemeManager _themeManager = ThemeManager();

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    _themeManager.addListener(themeLister);
    super.initState();
  }

  @override
  void dispose() {
    _themeManager.removeListener(themeLister);
    super.dispose();
  }

  themeLister() {
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(357, 667),
      builder: (context) => MaterialApp(
        title: 'TurnipOff',
        debugShowCheckedModeBanner: false,
        builder: (context, widget) {
          ScreenUtil.setContext(context);
          return MediaQuery(
            data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
            child: widget!,
          );
        },
        theme: lightTheme,
        darkTheme: darkTheme,
        themeMode: _themeManager.themeMode,
        onGenerateRoute: AppRouter.generateRoute,
        navigatorKey: navigatorKey,
        initialRoute: homeRoute,
      ),
    );
  }
}
