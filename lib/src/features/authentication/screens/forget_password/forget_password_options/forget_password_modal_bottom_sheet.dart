import 'package:collegemitra/src/constants/sizes.dart';
import 'package:collegemitra/src/constants/text_strings.dart';
import 'package:collegemitra/src/features/authentication/screens/forget_password/forget_password_mail/forget_password_mail.dart';
import 'package:collegemitra/src/features/authentication/screens/forget_password/forget_password_options/forget_password_btn_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Future<dynamic> buildShowModalBottomSheet(BuildContext context) {
  return showModalBottomSheet(
    context: context,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
    builder: (context) => Container(
      padding: const EdgeInsets.all(tDefaultSize),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            tForgetPasswordTitle,
            style: Theme.of(context).textTheme.titleLarge,
          ),
          Text(
            tForgetPasswordSubTitle,
            style: Theme.of(context).textTheme.titleSmall,
          ),
          const SizedBox(height: 30),
          ForgetPasswordBtnWidget(
            btnIcon: Icons.mail_outline_rounded,
            title: tEmail,
            subTitle: tResetViaEMail,
            onTap: () {
              Navigator.pop(context);
              Get.to(() => const ForgetPasswordMailScreen());
            },
          ),
          const SizedBox(height: 20.0),
          // ForgetPasswordBtnWidget(
          //   btnIcon: Icons.mobile_friendly_rounded,
          //   title: tPhoneNo,
          //   subTitle: tResetViaPhone,
          //   onTap: () {
          //     Navigator.pop(context);
          //     Get.to(() => const ForgetPasswordPhoneScreen());
          //   },
          // ),
        ],
      ),
    ),
  );
}
