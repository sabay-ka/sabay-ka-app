import 'package:flutter/material.dart';
import 'package:sabay_ka/app/text_style.dart';
import 'package:sabay_ka/common/theme.dart';
import 'package:sabay_ka/feature/notification/notification_widget.dart';

class HomePageTopBar extends StatelessWidget {
  final Function() onTap;
  const HomePageTopBar({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            onTap: onTap,
            child: Container(
                padding: const EdgeInsets.all(3),
                decoration: BoxDecoration(
                    color: CustomTheme.appColor.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(4)),
                child: const Icon(
                  Icons.menu,
                  color: CustomTheme.darkColor,
                )),
          ),
          Text('Book a Ride?', style: PoppinsTextStyles.headlineMediumRegular),
          InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const NotificationWidget(),
                  ));
            },
            child: Container(
                padding: const EdgeInsets.all(3),
                decoration: BoxDecoration(
                    color: CustomTheme.lightColor,
                    borderRadius: BorderRadius.circular(4)),
                child: const Icon(
                  Icons.notifications_outlined,
                  color: CustomTheme.darkColor,
                )),
          ),
        ],
      ),
    );
  }
}
