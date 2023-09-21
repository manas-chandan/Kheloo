import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:kheloo/app_configs/app_assets.dart';
import 'package:kheloo/pages/homePage/dashboard.dart';

class SplashPage extends StatefulWidget {
  static const routeName = "/";

  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 6)).then((value) {
      Get.offAllNamed(Dashboard.routeName);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Positioned.fill(
            child: Center(
              child: Image.asset(
                AppAssets.mainLogo,
                height: 120,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
