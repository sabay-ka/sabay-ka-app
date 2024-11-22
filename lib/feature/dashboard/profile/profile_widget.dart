import 'package:flutter/material.dart';
import 'package:sabay_ka/app/text_style.dart';
import 'package:sabay_ka/common/theme.dart';
import 'package:sabay_ka/common/utils/size_utils.dart';
import 'package:sabay_ka/common/widget/common_container.dart';
import 'package:sabay_ka/common/widget/custom_button.dart';
import 'package:sabay_ka/common/widget/custom_text_field.dart';
import 'package:sabay_ka/feature/auth/welcomeScreen/widget/welcome_widget.dart';
import 'package:sabay_ka/main.dart';
import 'package:sabay_ka/models/users_record.dart';
import 'package:sabay_ka/services/pocketbase_service.dart';

class ProfileWidget extends StatefulWidget {
  const ProfileWidget({super.key});

  @override
  State<ProfileWidget> createState() => _ProfileWidgetState();
}

class _ProfileWidgetState extends State<ProfileWidget> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneNumberController = TextEditingController();
  late UsersRecord _user;

  @override
    void initState() {
      _user = locator<PocketbaseService>().user!;
      super.initState();
    }

  @override
  Widget build(BuildContext context) {
    return CommonContainer(
      appBarTitle: "Profile",
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            margin: const EdgeInsets.only(bottom: 18),
            decoration: const BoxDecoration(
                shape: BoxShape.circle, color: CustomTheme.secondaryColor),
            height: 130.hp,
          ),
          Text(
            "${_user.firstName} ${_user.lastName}",
            style: PoppinsTextStyles.titleMediumRegular
                .copyWith(fontWeight: FontWeight.w500),
          ),
          Text('Email: ${_user.email}'),
          Text('Phone Number: ${_user.phoneNumber}'),
          SizedBox(height: 20),
          CustomRoundedButtom(
            title: "Logout",
            color: Colors.transparent,
            onPressed: () {
              locator<PocketbaseService>().signOut();
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const WelcomeWidget(),
                  ));
            },
            textColor: CustomTheme.appColor,
            borderColor: CustomTheme.appColor,
          ),
        ],
      ),
    );
  }

}
