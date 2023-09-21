import 'package:flutter/material.dart';
import 'package:flutter_portal/flutter_portal.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:kheloo/app_configs/app_page_routes.dart';
import 'package:kheloo/pages/splash/splash_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Portal(
      child: GetMaterialApp(
        title: 'Kheloo',
        debugShowCheckedModeBanner: false,
        themeMode: ThemeMode.light,
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        supportedLocales: const [Locale('en'), Locale('hi')],
        initialRoute: SplashPage.routeName,
        getPages: AppPages.pages,
      ),
    );
  }
}
