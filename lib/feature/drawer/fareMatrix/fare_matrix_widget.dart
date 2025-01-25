import 'package:flutter/material.dart';
import 'package:sabay_ka/app/text_style.dart';
import 'package:sabay_ka/common/widget/common_container.dart';


class FareMatrixWidget extends StatefulWidget {
  const FareMatrixWidget({super.key});

  @override
  State<FareMatrixWidget> createState() => _FareMatrixWidgetState();
}

class _FareMatrixWidgetState extends State<FareMatrixWidget> {
  @override
  Widget build(BuildContext context) {
    return CommonContainer(
        appBarTitle: "Fare Matrix",
        body: Column(
          children: [
            Text(
              "PHP 50 base fare (first 2 km) + PHP 8 per km",
              style: PoppinsTextStyles.bodyMediumRegular,
              textAlign: TextAlign.justify,
            )
          ],
        ));
  }
}
