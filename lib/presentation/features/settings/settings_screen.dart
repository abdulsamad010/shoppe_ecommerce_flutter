
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shoppe_ecommerce_flutter/presentation/core/bloc/app_bloc/app_event.dart';
import 'package:shoppe_ecommerce_flutter/presentation/features/about/about_screen.dart';
import 'package:shoppe_ecommerce_flutter/presentation/features/address/address_screen.dart';
import 'package:shoppe_ecommerce_flutter/presentation/features/hello_card/hello_card_screen.dart';
import 'package:shoppe_ecommerce_flutter/presentation/features/login_password/login_password_screen.dart';
import 'package:shoppe_ecommerce_flutter/presentation/features/profile_settings/profile_settings_screen.dart';
import 'package:shoppe_ecommerce_flutter/presentation/features/start/start_screen.dart';
import 'package:shoppe_ecommerce_flutter/presentation/features/terms/terms_screen.dart';

import '../../core/bloc/app_bloc/app_bloc.dart';
import '../../core/bloc/app_bloc/app_state.dart';
import '../../core/colors/app_colors.dart';
import '../../core/text_styles/app_text_styles.dart';
import '../../core/widgets/settings_card.dart';
import '../login_email/login_email_screen.dart';

class SettingsScreen extends StatelessWidget {
const SettingsScreen({super.key});

@override
Widget build(BuildContext context) {
return BlocConsumer<AppBloc,AppState>(

  listener: (context,state){
    if(state.isAccountDeleted==true && state.isNeedToLogin==false){
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context)=>StartScreen()),
            (route) => false,
      );
    }

    if(state.isNeedToLogin==true){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Please do a fresh login to delete your account",style: AppTextStyles.b1),backgroundColor: Colors.transparent,));
    }


    if(state.isSignout==true){
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context)=>LoginEmailScreen()),
            (route) => false,
      );
    }
  },

  builder: (context,state) {
    return Scaffold(
    backgroundColor: white,
    body: SafeArea(
    child: SingleChildScrollView(
    child: Padding(
    padding: EdgeInsets.all(16.w),
    child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
    Text(
    'Settings',
    style: AppTextStyles.h3,
    ),

    SizedBox(height: 24.h),

    Text(
    'Personal',
    style: GoogleFonts.raleway(
    fontSize: 20.sp,
    fontWeight: FontWeight.w800,
    color: black,
    ),
    ),

    SizedBox(height: 8.h),

    SettingsItem(
    title: 'Profile',
    onTap: () {
    Navigator.push(context, MaterialPageRoute(builder: (context)=>ProfileSettingsScreen()));
    },
    ),

    SettingsItem(
    title: 'Shipping Address',
    onTap: () {
      Navigator.push(context, MaterialPageRoute(builder: (context)=>AddressScreen()));
    },
    ),

    SettingsItem(
    title: 'Payment methods',
    selectedOption: 'COD',
    ),

    SizedBox(height: 24.h),

    Text(
    'Shop',
    style: GoogleFonts.raleway(
    fontSize: 20.sp,
    fontWeight: FontWeight.w800,
    color: black,
    ),
    ),

    SizedBox(height: 8.h),

    SettingsItem(
    title: 'Terms and Conditions',
    onTap: () {
      Navigator.push(context, MaterialPageRoute(builder: (context)=>TermsConditionsScreen()));
    },
    ),

    SizedBox(height: 24.h),

    Text(
    'Account',
    style: GoogleFonts.raleway(
    fontSize: 20.sp,
    fontWeight: FontWeight.w800,
    color: black,
    ),
    ),

    SizedBox(height: 8.h),

    SettingsItem(
    title: 'Language',
    selectedOption: 'English',
    ),

    SettingsItem(
    title: 'About Shopee',
    onTap: () {
      Navigator.push(context, MaterialPageRoute(builder: (context)=>AboutScreen()));
    },
    ),

      SettingsItem(
        title: 'Logout',
        onTap: () {



          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) {
              return Dialog(
                backgroundColor: white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.r),
                ),
                child: SizedBox(
                  width: 314.w,
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(20.w, 0, 20.w, 22.h),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Transform.translate(
                          offset: Offset(0, -24.h),
                          child: Container(
                            width: 72.r,
                            height: 72.r,
                            decoration: BoxDecoration(
                              color: white,
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: black.withValues(alpha: 0.12),
                                  blurRadius: 6.r,
                                  offset: Offset(0, 2.h),
                                ),
                              ],
                            ),
                            child: Center(
                              child: Container(
                                width: 40.r,
                                height: 40.r,
                                decoration: BoxDecoration(
                                  color: const Color(0xFFFFEEEE),
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(
                                  Icons.logout,
                                  color: const Color(0xFFE57373),
                                  size: 24.r,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Transform.translate(
                          offset: Offset(0, -12.h),
                          child: Column(
                            children: [
                              Text(
                                'You are going to Logout\nyour account',
                                textAlign: TextAlign.center,
                                style: GoogleFonts.raleway(
                                  fontSize: 17.sp,
                                  fontWeight: FontWeight.w700,
                                  color: black,
                                  height: 1.4,
                                ),
                              ),



                              SizedBox(height: 24.h),
                              Row(
                                children: [
                                  Expanded(
                                    child: SizedBox(
                                      height: 38.h,
                                      child: ElevatedButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: const Color(0xFF222222),
                                          foregroundColor: white,
                                          elevation: 0,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                            BorderRadius.circular(10.r),
                                          ),
                                        ),
                                        child: Text(
                                          'Cancel',
                                          style: GoogleFonts.nunitoSans(
                                            fontSize: 14.sp,
                                            fontWeight: FontWeight.w300,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 14.w),
                                  Expanded(
                                    child: SizedBox(
                                      height: 38.h,
                                      child: ElevatedButton(
                                        onPressed: () {
                                          context.read<AppBloc>().add(Logout());
                                          Navigator.pop(context);
                                        },
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: const Color(0xFFE57373),
                                          foregroundColor: white,
                                          elevation: 0,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                            BorderRadius.circular(10.r),
                                          ),
                                        ),
                                        child: Text(
                                          'Logout',
                                          style: GoogleFonts.nunitoSans(
                                            fontSize: 14.sp,
                                            fontWeight: FontWeight.w300,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );



  },
      ),

    SizedBox(height: 32.h),

    GestureDetector(
    onTap: () {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return Dialog(
            backgroundColor: white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18.r),
            ),
            child: SizedBox(
              width: 314.w,
              child: Padding(
                padding: EdgeInsets.fromLTRB(20.w, 0, 20.w, 22.h),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Transform.translate(
                      offset: Offset(0, -24.h),
                      child: Container(
                        width: 72.r,
                        height: 72.r,
                        decoration: BoxDecoration(
                          color: white,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: black.withValues(alpha: 0.12),
                              blurRadius: 6.r,
                              offset: Offset(0, 2.h),
                            ),
                          ],
                        ),
                        child: Center(
                          child: Container(
                            width: 40.r,
                            height: 40.r,
                            decoration: BoxDecoration(
                              color: const Color(0xFFFFEEEE),
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              Icons.error,
                              color: const Color(0xFFE57373),
                              size: 24.r,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Transform.translate(
                      offset: Offset(0, -12.h),
                      child: Column(
                        children: [
                          Text(
                            'You are going to delete\nyour account',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.raleway(
                              fontSize: 17.sp,
                              fontWeight: FontWeight.w700,
                              color: black,
                              height: 1.4,
                            ),
                          ),
                          SizedBox(height: 6.h),
                          Text(
                            "You won't be able to restore your data",
                            textAlign: TextAlign.center,
                            style: GoogleFonts.nunitoSans(
                              fontSize: 12.sp,
                              color: black,
                            ),
                          ),
                          SizedBox(height: 24.h),
                          Row(
                            children: [
                              Expanded(
                                child: SizedBox(
                                  height: 38.h,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: const Color(0xFF222222),
                                      foregroundColor: white,
                                      elevation: 0,
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                        BorderRadius.circular(10.r),
                                      ),
                                    ),
                                    child: Text(
                                      'Cancel',
                                      style: GoogleFonts.nunitoSans(
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w300,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(width: 14.w),
                              Expanded(
                                child: SizedBox(
                                  height: 38.h,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      context.read<AppBloc>().add(DeleteAccount());
                                      Navigator.pop(context);
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: const Color(0xFFE57373),
                                      foregroundColor: white,
                                      elevation: 0,
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                        BorderRadius.circular(10.r),
                                      ),
                                    ),
                                    child: Text(
                                      'Delete',
                                      style: GoogleFonts.nunitoSans(
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w300,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      );
    },
    child: Text(
    'Delete My Account',
    style: GoogleFonts.nunitoSans(
    fontSize: 12.sp,
    fontWeight: FontWeight.w600,
    color: Colors.redAccent,
    ),
    ),
    ),

    SizedBox(height: 24.h),

    Text(
    'Shopee',
    style: GoogleFonts.raleway(
    fontSize: 20.sp,
    fontWeight: FontWeight.w800,
    color: black,
    ),
    ),

    SizedBox(height: 4.h),

    Text(
    'Version 1.0.0',
    style: GoogleFonts.nunitoSans(
    fontSize: 11.sp,
    fontWeight: FontWeight.w400,
    color: black,
    ),
    ),
    ],
    ),
    ),
    ),
    ),
    );
  }
);
}
}