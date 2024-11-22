import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sabay_ka/app/text_style.dart';
import 'package:sabay_ka/common/constant/assets.dart';
import 'package:sabay_ka/common/theme.dart';
import 'package:sabay_ka/common/widget/common_container.dart';

class FavouriteWidget extends StatelessWidget {
  const FavouriteWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return CommonContainer(
      appBarTitle: "Favourite",
      body: ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        scrollDirection: Axis.vertical,
        itemCount: 1,
        itemBuilder: (context, index) {
          return Container(
            padding: const EdgeInsets.symmetric(vertical: 8),
            margin: const EdgeInsets.symmetric(vertical: 8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: CustomTheme.appColor.withOpacity(0.5),
              ),
            ),
            child: ListTile(
              leading: SvgPicture.asset(Assets.mapIcon2),
              title: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Home",
                      style: PoppinsTextStyles.subheadLargeRegular.copyWith(
                        fontWeight: FontWeight.w600,
                        color: CustomTheme.darkColor,
                      ),
                    ),
                    Text(
                      "Lorem Ipsum Street, 123",
                      style: PoppinsTextStyles.bodyMediumRegular
                          .copyWith(fontSize: 12),
                    )
                  ]),
              trailing: SvgPicture.asset(
                Assets.deleteIcon,
                color: CustomTheme.googleColor,
              ),
            ),
          );
        },
      ),
    );
  }
}
