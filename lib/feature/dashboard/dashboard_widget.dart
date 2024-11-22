import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sabay_ka/common/constant/assets.dart';
import 'package:sabay_ka/common/theme.dart';
import 'package:sabay_ka/feature/dashboard/book/book_widget.dart';
import 'package:sabay_ka/feature/dashboard/profile/profile_widget.dart';
import 'package:sabay_ka/feature/dashboard/wallet/wallet_widget.dart';
import 'package:sabay_ka/feature/rideFlow/watch_ride.dart';
import 'package:sabay_ka/main.dart';
import 'package:sabay_ka/services/pocketbase_service.dart';

class DashboardWidget extends StatefulWidget {
  const DashboardWidget({super.key});

  @override
  State<DashboardWidget> createState() => _DashboardWidgetState();
}

class _DashboardWidgetState extends State<DashboardWidget> {
  int _selectedIndex = 1;
  _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  List pages = [
    const WalletWidget(),
    const BookWidget(),
    const ProfileWidget(),
  ];

  @override
    void initState() {
      // If user has an ongoing request, navigate to WatchRide
      locator<PocketbaseService>().getOngoingRequest()
        .then((request) {
          if (request != null && context.mounted) {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => WatchRide(
                  requestId: request.id,
                  rideId: request.ride,
                ),
              ),
              (route) => false,
            );
          }
        });
      super.initState();
    }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomTheme.lightColor,
      body: Padding(
        padding: const EdgeInsets.only(bottom: 50.0),
        child: Center(
          child: pages.elementAt(_selectedIndex),
        ),
      ),
      bottomSheet: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18),
          color: CustomTheme.lightColor,
        ),
        padding: const EdgeInsets.all(8),
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          elevation: 0,
          unselectedFontSize: 12,
          unselectedItemColor: CustomTheme.darkColor.withOpacity(0.7),
          showUnselectedLabels: true,
          selectedFontSize: 13,
          selectedLabelStyle: const TextStyle(fontWeight: FontWeight.w500),
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                  _selectedIndex == 0
                      ? Assets.walletFillIcon
                      : Assets.walletIcon,
                  color: _selectedIndex == 0
                      ? CustomTheme.appColor
                      : CustomTheme.darkColor.withOpacity(0.7),
                  width: 30),
              label: 'Transactions',
            ),
            const BottomNavigationBarItem(
              icon: SizedBox(
                width: 30,
                height: 30,
              ),
              label: 'Book',
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                  _selectedIndex == 2 ? Assets.userFillIcon : Assets.userIcon,
                  color: _selectedIndex == 2
                      ? CustomTheme.appColor
                      : CustomTheme.darkColor.withOpacity(0.7),
                  width: 30),
              label: 'Profile',
            ),
          ],
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          selectedItemColor: Colors.green,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Container(
        margin: const EdgeInsets.only(top: 10),
        height: 64,
        width: 64,
        child: FloatingActionButton(
          backgroundColor: CustomTheme.appColor,
          elevation: 0,
          onPressed: () {
            setState(() {
              _selectedIndex = 1;
            });
          },
          child: Icon(
            Icons.book,
            color: CustomTheme.lightColor,
            size: 30,
          ),
        ),
      ),
    );
  }
}
