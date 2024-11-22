import 'package:flutter/material.dart';
import 'package:sabay_ka/app/text_style.dart';
import 'package:sabay_ka/common/widget/common_container.dart';

class AboutUsWidget extends StatelessWidget {
  const AboutUsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return CommonContainer(
        appBarTitle: "About Us",
        body: Column(
          children: [
            Text(
              "Sabay Ka? is a innovative campus-wide car pooling app designed to connect students, faculty, and staff for convenient and sustainable transportation across university campuses. Our mission is to reduce traffic congestion, lower carbon emissions, and foster community among members of higher education institutions.",
              style: PoppinsTextStyles.bodyMediumRegular,
              textAlign: TextAlign.justify,
            )
          ],
        ));
  }
}
