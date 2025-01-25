import 'package:flutter/material.dart';
import 'package:sabay_ka/app/app_drawer.dart';
import 'package:sabay_ka/common/constant/assets.dart';
import 'package:sabay_ka/common/widget/page_wrapper.dart';
import 'package:sabay_ka/feature/dashboard/homeScreen/widget/home_page_topbar.dart';

class HomePageWidget extends StatefulWidget {
  const HomePageWidget({super.key});

  @override
  State<HomePageWidget> createState() => _HomePageWidgetState();
}

class _HomePageWidgetState extends State<HomePageWidget> {
  bool isTransport = true;
  // bool isDrawerOpen = false;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return PageWrapper(
      padding: EdgeInsets.zero,
      body: SafeArea(
        child: Scaffold(
          drawer: CustomDrawer(),
          backgroundColor: Colors.transparent,
          key: _scaffoldKey,
          body: SafeArea(
            child: Container(
              padding: const EdgeInsets.only(top: 18),
              decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(Assets.mapImage), fit: BoxFit.cover),
              ),
              child: Column(children: [
                HomePageTopBar(
                  onTap: () {
                    if (_scaffoldKey.currentState!.isDrawerOpen == false) {
                      _scaffoldKey.currentState!.openDrawer();
                    } else {
                      _scaffoldKey.currentState!.openEndDrawer();
                    }
                  },
                ),
                const Spacer(),
              ]),
            ),
          ),
        ),
      ),
    );
  }
}
