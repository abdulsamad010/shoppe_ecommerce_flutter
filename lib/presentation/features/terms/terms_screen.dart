
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/colors/app_colors.dart';
import '../../core/text_styles/app_text_styles.dart';

class TermsConditionsScreen extends StatelessWidget {
const TermsConditionsScreen({super.key});

@override
Widget build(BuildContext context) {
return Scaffold(
backgroundColor: white,
appBar: AppBar(
backgroundColor: white,
elevation: 0,
iconTheme: IconThemeData(color: black),
title: Text(
'Terms & Conditions',
style: AppTextStyles.h2,
),
),
body: SingleChildScrollView(
padding: EdgeInsets.symmetric(
horizontal: 20.w,
vertical: 16.h,
),
child: Column(
crossAxisAlignment: CrossAxisAlignment.start,
children: [
Text(
'Welcome to Shoppe',
style: AppTextStyles.h3,
),
SizedBox(height: 10.h),
Text(
'These Terms and Conditions govern your use of the Shoppe '
'shopping application. By accessing or using the app, you '
'agree to these terms. If you do not agree, please stop '
'using the application.',
style: AppTextStyles.b2,
),
SizedBox(height: 20.h),
Text(
'1. Acceptance of Terms',
style: AppTextStyles.b1,
),
SizedBox(height: 8.h),
Text(
'By using Shoppe, you confirm that you understand and agree '
'to follow these Terms and Conditions and any applicable '
'laws and regulations.',
style: AppTextStyles.b2,
),
SizedBox(height: 20.h),
Text(
'2. User Accounts',
style: AppTextStyles.b1,
),
SizedBox(height: 8.h),
Text(
'You are responsible for providing accurate information '
'when creating your account and for keeping your login '
'credentials secure. You should notify us if you suspect '
'unauthorized access to your account.',
style: AppTextStyles.b2,
),
SizedBox(height: 20.h),
Text(
'3. Products and Orders',
style: AppTextStyles.b1,
),
SizedBox(height: 8.h),
Text(
'Shoppe allows users to browse products and place orders. '
'Product descriptions, images, availability, and prices '
'should be reviewed before placing an order. Orders may '
'be subject to availability and confirmation.',
style: AppTextStyles.b2,
),
SizedBox(height: 20.h),
Text(
'4. Payments and Delivery',
style: AppTextStyles.b1,
),
SizedBox(height: 8.h),
Text(
'Users must provide accurate delivery details and follow '
'the payment instructions provided in the app. Delivery '
'times may vary depending on availability, location, and '
'other circumstances.',
style: AppTextStyles.b2,
),
SizedBox(height: 20.h),
Text(
'5. User Responsibilities',
style: AppTextStyles.b1,
),
SizedBox(height: 8.h),
Text(
'You agree not to misuse the application, interfere with '
'its operation, attempt unauthorized access, or use the '
'app for unlawful activities.',
style: AppTextStyles.b2,
),
SizedBox(height: 20.h),
Text(
'6. Changes to Terms',
style: AppTextStyles.b1,
),
SizedBox(height: 8.h),
Text(
'We may update these Terms and Conditions from time to '
'time. Any revised terms will be made available through '
'the application. Continued use of Shoppe after changes '
'means you accept the updated terms.',
style: AppTextStyles.b2,
),
SizedBox(height: 20.h),
Text(
'7. Contact Us',
style: AppTextStyles.b1,
),
SizedBox(height: 8.h),
Text(
'If you have questions about these Terms and Conditions, '
'please contact us at:',
style: AppTextStyles.b2,
),
SizedBox(height: 8.h),
Text(
'abdulsamadabbasi010@gmail.com',
style: AppTextStyles.b2.copyWith(
color: blue,
),
),
SizedBox(height: 30.h),
],
),
),
);
}
}
