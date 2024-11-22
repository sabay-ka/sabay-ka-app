import 'package:flutter/material.dart';
import 'package:sabay_ka/app/text_style.dart';
import 'package:sabay_ka/common/theme.dart';
import 'package:sabay_ka/common/widget/common_container.dart';

class PrivacyPolicyWidget extends StatelessWidget {
  const PrivacyPolicyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return CommonContainer(
        appBarTitle: "Privacy Policy",
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Sabay Ka? is committed to protecting your privacy. This Privacy Notice explains how we collect, use, disclose, and safeguard the personal information you provide when using our campus-wide carpooling service.'),
            SizedBox(height: 20),
            Text('Information We Collect', style: PoppinsTextStyles.subheadLargeRegular.copyWith(color: CustomTheme.darkColor, fontSize: 16, fontWeight: FontWeight.w600), textAlign: TextAlign.center,),
            SizedBox(height: 10),
            Text('Personal Information', style: PoppinsTextStyles.bodySmallRegular.copyWith(color: CustomTheme.darkColor.withOpacity(0.5), fontSize: 13, fontWeight: FontWeight.w600), textAlign: TextAlign.start,),
            SizedBox(height: 10),
            Text('We may collect personal information, such as your name, email, phone number, and any other information you provide when you register for an account.'),
            SizedBox(height: 10),
            Text('Information from Other Sources', style: PoppinsTextStyles.bodySmallRegular.copyWith(color: CustomTheme.darkColor.withOpacity(0.5), fontSize: 13, fontWeight: FontWeight.w600), textAlign: TextAlign.start,),
            SizedBox(height: 10),
            Text('We may obtain information about you from third parties, specifically Google, for authentication and validation purposes.'),
            SizedBox(height: 10),
          ],
        ));
  }
}
