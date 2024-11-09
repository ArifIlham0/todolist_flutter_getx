import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todolist_get_new/app/widgets/export.dart';
import 'package:todolist_get_new/theme.dart';
import '../controllers/splash_controller.dart';

class SplashView extends GetView<SplashController> {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(SplashController());

    return Scaffold(
      backgroundColor: kBlack,
      body: Center(
        child: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Image.asset("assets/images/logo_bootsplash.png"),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(top: 230.h),
              child: const LoadingIndicator(),
            )
          ],
        ),
      ),
    );
  }
}
