import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sabay_ka/common/constant/assets.dart';
import 'package:sabay_ka/common/widget/common_container.dart';
import 'package:sabay_ka/common/widget/common_list_tile.dart';
//import 'package:sabay_ka/common/widget/custom_button.dart';
//import 'package:sabay_ka/common/widget/common_popup_box.dart';
//import 'package:sabay_ka/feature/auth/welcomeScreen/widget/welcome_widget.dart';
//import 'package:sabay_ka/feature/drawer/settings/change_password_widget.dart';
//import 'package:sabay_ka/feature/drawer/settings/contact_us_widget.dart';
//import 'package:sabay_ka/feature/drawer/settings/delete_account_widget.dart';
import 'package:sabay_ka/feature/drawer/settings/privacy_policy_widget.dart';

class SettingWidget extends StatelessWidget {
  SettingWidget({super.key});
  final List<SettingItem> items = [
    //SettingItem(
    //    title: "Change Password",
    //    onTap: (BuildContext context) {
    //      Navigator.push(
    //          context,
    //          MaterialPageRoute(
    //            builder: (context) => const ChangePasswordWidget(),
    //          ));
    //    }),
    SettingItem(
        title: "Privacy Policy",
        onTap: (BuildContext context) {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const PrivacyPolicyWidget(),
              ));
        }),
    //SettingItem(
    //    title: "Contact Us",
    //    onTap: (BuildContext context) {
    //      Navigator.push(
    //          context,
    //          MaterialPageRoute(
    //            builder: (context) => ContactUsWidget(),
    //          ));
    //    }),
    //SettingItem(
    //    title: "Delete Account",
    //    onTap: (BuildContext context) {
    //      Navigator.push(
    //          context,
    //          MaterialPageRoute(
    //            builder: (context) => const DeleteAccountWidget(),
    //          ));
    //    }),
  ];

  @override
  Widget build(BuildContext context) {
    return CommonContainer(
        appBarTitle: "Settings",
        body: ListView.builder(
          shrinkWrap: true,
          itemCount: items.length,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) => CustomListTile(
              trailing: SvgPicture.asset(Assets.rightArrowIcon),
              onTap: () {
                items[index].onTap(context);
              },
              title: items[index].title),
        ));
  }
}

class SettingItem {
  final String title;
  final Function onTap;

  SettingItem({required this.title, required this.onTap});
}
