import 'package:flutter/material.dart';
import 'package:sabay_ka/common/constant/assets.dart';
import 'package:sabay_ka/feature/auth/welcomeScreen/screen/welcome_page.dart';
import 'package:sabay_ka/feature/dashboard/dashboard_widget.dart';
import 'package:sabay_ka/feature/onboarding/onboarding_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashWidget extends StatefulWidget {
  const SplashWidget({super.key});

  @override
  State<SplashWidget> createState() => _SplashWidgetState();
}

class _SplashWidgetState extends State<SplashWidget> {
  @override
  void initState() {
    getAppStatus();
    super.initState();
  }

  getAppStatus() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final appStatus = prefs.getBool("showOnboarding");
    final pbAuth = prefs.getString("pb_auth");

    if (appStatus == null || appStatus == true) {
      // First time user, navigate to OnBoarding
      Future.delayed(const Duration(seconds: 2), () {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const OnBoardingPage(),
            ));
      });
      return;
    } 

    // If user is already logged in
    if (pbAuth != "" && pbAuth != null) {
      Future.delayed(const Duration(seconds: 2), () {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const DashboardWidget(),
            ));
      });
      return;
    } 
    // Otherwise, navigate to Login and Register page
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const WelcomePage(),
          ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Image.asset(
          Assets.splashImage,
          fit: BoxFit.cover,
          height: double.infinity,
          width: double.infinity,
          alignment: Alignment.center,
        ),
      ),
    );
  }
}
