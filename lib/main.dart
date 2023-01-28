import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:nutrial/constants/colors.dart';
import 'package:nutrial/generated/l10n.dart';
import 'package:nutrial/routes/router.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 760),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) => GetMaterialApp(
        useInheritedMediaQuery: true,
        debugShowMaterialGrid: false,
        title: 'Nutrial',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSwatch().copyWith(
            primary: AppColors.primaryColor,
          ),
          textSelectionTheme: const TextSelectionThemeData(
              cursorColor: Colors.white
          ),
        ),
        localizationsDelegates: const [
          S.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: S.delegate.supportedLocales,
        onGenerateRoute: onGenerateRoute,
        opaqueRoute: Get.isOpaqueRouteDefault,
        locale: const Locale('ar'),
      ),
    );
  }
}