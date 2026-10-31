
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../core/colors/app_colors.dart';

class SettingsItem extends StatelessWidget {
final String title;
final String? selectedOption;
final VoidCallback? onTap;

const SettingsItem({
super.key,
required this.title,
this.selectedOption,
this.onTap,
});

@override
Widget build(BuildContext context) {
return GestureDetector(
onTap: onTap,
child: Container(
padding: EdgeInsets.symmetric(vertical: 16.h),
decoration: BoxDecoration(
border: Border(
bottom: BorderSide(
color: Colors.grey.shade200,
),
),
),
child: Row(
children: [
Expanded(
child: Text(
title,
style: GoogleFonts.nunitoSans(
fontSize: 16.sp,
fontWeight: FontWeight.w600,
color: black,
),
),
),
if (selectedOption != null)
Text(
selectedOption!,
style: GoogleFonts.nunitoSans(
fontSize: 16.sp,
fontWeight: FontWeight.w600,
color: black,
),
)
else
Icon(
Icons.chevron_right,
size: 24.w,
color: black,
),
],
),
),
);
}
}