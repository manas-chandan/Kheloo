import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kheloo/pages/homePage/dashboard.dart';
import 'package:kheloo/pages/splash/splash_screen.dart';

class AppPages {
  static final pages = [
    GetPage(
        name: SplashPage.routeName,
        page: () => const SplashPage(),
        children: [
          GetPage(
            name: Dashboard.routeName,
            participatesInRootNavigator: true,
            page: () => const Dashboard(),
            // binding: DashboardBinding(),
            // children: [
            //   GetPage(
            //       name: CommunityHubPage.routeName,
            //       binding: CommunityHubBinding(),
            //       page: () => CommunityHubPage()),
            //   GetPage(
            //       name: HomeWidget.routeName, page: () => const HomeWidget()),
            //   GetPage(
            //       name: EventsWidget.routeName,
            //       page: () => const EventsWidget()),
            // ]),
          )
        ])
  ];
}
