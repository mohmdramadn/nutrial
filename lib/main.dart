import 'dart:async';
import 'dart:developer';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:nutrial/firebase_options.dart';
import 'package:nutrial/helper/calories_database.dart';
import 'package:nutrial/helper/shared_prefrence.dart';
import 'package:nutrial/providers.dart';
import 'package:nutrial/routes/routes_names.dart';
import 'package:nutrial/services/app_language.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:nutrial/constants/colors.dart';
import 'package:nutrial/generated/l10n.dart';
import 'package:nutrial/routes/router.dart';

void main() {
  runZonedGuarded<Future<void>>(() async {
    WidgetsFlutterBinding.ensureInitialized();

    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    Preference.instance.initSharedPreference();
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarColor: Colors.black,
      statusBarColor: Colors.transparent,
    ));

    final AppLanguage appLanguage = AppLanguage();
    await appLanguage.fetchLocale();

    final caloriesDatabase = LocalDatabase.instance;
    await caloriesDatabase.getProteinCaloriesData();
    await caloriesDatabase.getCarbsFatsCaloriesData();
    await caloriesDatabase.getActivitiesData();

    runApp(
      ChangeNotifierProvider<AppLanguage>.value(
        value: appLanguage,
        child: MyApp(appLanguage: appLanguage),
      ),
    );
  }, (error, stack) => log('$error'));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key, required this.appLanguage}) : super(key: key);

  final AppLanguage appLanguage;

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 760),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) => MultiProvider(
        providers: provider,
        child: GetMaterialApp(
          useInheritedMediaQuery: true,
          debugShowCheckedModeBanner: false,
          debugShowMaterialGrid: false,
          title: 'Nutrial',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSwatch().copyWith(
              primary: AppColors.primaryColor,
            ),
            textSelectionTheme:
                const TextSelectionThemeData(cursorColor: Colors.white),
          ),
          locale: appLanguage.appLocal,
          localizationsDelegates: const [
            S.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: S.delegate.supportedLocales,
          onGenerateRoute: onGenerateRoute,
          initialRoute: splashRoute,
          opaqueRoute: Get.isOpaqueRouteDefault,
          color: AppColors.backgroundColor,
        ),
      ),
    );
  }
}