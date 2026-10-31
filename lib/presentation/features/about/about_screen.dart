
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../core/colors/app_colors.dart';

class AboutScreen extends StatelessWidget {
const AboutScreen({super.key});

@override
Widget build(BuildContext context) {
return Scaffold(
backgroundColor: white,
body: SafeArea(
child: SingleChildScrollView(
child: Padding(
padding: EdgeInsets.symmetric(
horizontal: 20.w,
vertical: 16.h,
),
child: Column(
crossAxisAlignment: CrossAxisAlignment.start,
children: [
SizedBox(height: 60.h),
Center(
child: Image.asset(
'assets/logo/Group 1000004649.png',
width: 100.w,
height: 100.h,
fit: BoxFit.contain,
),
),
SizedBox(height: 60.h),
Text(
'About Shoppe',
style: GoogleFonts.raleway(
fontSize: 28.sp,
fontWeight: FontWeight.w700,
color: black,
),
),
SizedBox(height: 16.h),
Text(
'Shoppe is an online shopping app that makes it easy '
'to browse products, explore different categories, '
'and shop for your favorite items in one place. '
'Our goal is to provide a simple, convenient, and '
'enjoyable shopping experience for every user.',
style: GoogleFonts.nunitoSans(
fontSize: 16.sp,
fontWeight: FontWeight.w300,
height: 27 / 16,
letterSpacing: 0,
color: black,
),
),
SizedBox(height: 22.h),
Text(
'If you need help or have any questions, feel free '
'to contact us by email.',
style: GoogleFonts.nunitoSans(
fontSize: 16.sp,
fontWeight: FontWeight.w300,
height: 27 / 16,
letterSpacing: 0,
color: black,
),
),
SizedBox(height: 8.h),
Text(
'abdulsamadabbasi010@gmail.com',
style: GoogleFonts.raleway(
fontSize: 17.sp,
fontWeight: FontWeight.w700,
letterSpacing: -0.17,
color: black,
),
),
SizedBox(height: 24.h),
Text(
'Developed by',
style: GoogleFonts.raleway(
fontSize: 17.sp,
fontWeight: FontWeight.w700,
letterSpacing: -0.17,
color: black,
),
),
SizedBox(height: 8.h),
Text(
'Abdul Samad',
style: GoogleFonts.nunitoSans(
fontSize: 16.sp,
fontWeight: FontWeight.w300,
height: 27 / 16,
color: black,
),
),
SizedBox(height: 4.h),
Text(
'abdulsamadabbasi010@gmail.com',
style: GoogleFonts.nunitoSans(
fontSize: 14.sp,
fontWeight: FontWeight.w300,
color: black,
),
),
SizedBox(height: 4.h),
GestureDetector(
onTap: () {},
child: Text(
'GitHub: abdulsamad010',
style: GoogleFonts.nunitoSans(
fontSize: 14.sp,
fontWeight: FontWeight.w600,
color: blue,
),
),
),
],
),
),
),
),
);
}
}
