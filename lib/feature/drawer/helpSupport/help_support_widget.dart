import 'package:flutter/material.dart';
import 'package:sabay_ka/app/text_style.dart';
import 'package:sabay_ka/common/widget/common_container.dart';

class HelpSupportWidget extends StatelessWidget {
  const HelpSupportWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return CommonContainer(
        title: "Help And Support",
        appBarTitle: "Help and Support",
        body: Column(
          children: [
            Text(
              "Get some help",
              style: PoppinsTextStyles.bodyMediumRegular,
              textAlign: TextAlign.justify,
            )
          ],
        ));
  }
}
