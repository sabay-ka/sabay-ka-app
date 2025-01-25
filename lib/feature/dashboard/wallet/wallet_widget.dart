import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sabay_ka/app/text_style.dart';
import 'package:sabay_ka/common/constant/assets.dart';
import 'package:sabay_ka/common/theme.dart';
import 'package:sabay_ka/common/widget/common_container.dart';
import 'package:sabay_ka/main.dart';
import 'package:sabay_ka/services/pocketbase_service.dart';

class WalletWidget extends StatelessWidget {
  const WalletWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return CommonContainer(
      appBarTitle: "Payments",
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Payment History",
            style: PoppinsTextStyles.subheadLargeRegular.copyWith(
              fontWeight: FontWeight.w600,
              color: CustomTheme.darkColor,
            ),
          ),
          FutureBuilder(
              future: locator<PocketbaseService>().getUserPayments(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Center(child: Text(snapshot.error.toString()));
                }
                if (snapshot.hasData) {
                  final payments = snapshot.data;
                  return ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    itemCount: payments!.length,
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
                            leading: Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: index.isEven
                                    ? const Color(0xFFFFCDD2)
                                    : const Color(0xFFC8E6C9),
                              ),
                              child: SvgPicture.asset(
                                payments[index].getStringValue('status') ==
                                        'completed'
                                    ? Assets.upIcon
                                    : Assets.downIcon,
                                color:
                                    payments[index].getStringValue('status') ==
                                            'completed'
                                        ? const Color(0xFFD32F2F)
                                        : const Color(0xFF388E3D),
                              ),
                            ),
                            title: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    payments[index].getStringValue('status') ==
                                            'completed'
                                        ? "Paid"
                                        : "Pending",
                                    style: PoppinsTextStyles.subheadLargeRegular
                                        .copyWith(
                                      fontWeight: FontWeight.w600,
                                      color: CustomTheme.darkColor,
                                    ),
                                  ),
                                  Text(
                                    payments[index].getStringValue('created'),
                                    style: PoppinsTextStyles.bodyMediumRegular
                                        .copyWith(fontSize: 12),
                                  )
                                ]),
                            trailing: Text(
                              "PHP ${payments[index].getDoubleValue('amount')}",
                              style: PoppinsTextStyles.subheadLargeRegular
                                  .copyWith(
                                fontWeight: FontWeight.w600,
                                color: CustomTheme.darkColor,
                              ),
                            )),
                      );
                    },
                  );
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              }),
        ],
      ),
    );
  }
}
