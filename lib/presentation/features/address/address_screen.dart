import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart';

import '../../core/bloc/app_bloc/app_bloc.dart';
import '../../core/bloc/app_bloc/app_event.dart';
import '../../core/colors/app_colors.dart';
import '../../core/text_styles/app_text_styles.dart';
import '../../core/widgets/input_field.dart';

class AddressScreen extends StatefulWidget {
  const AddressScreen({super.key});

  @override
  State<AddressScreen> createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
  final aC = TextEditingController();
  final tC = TextEditingController();
  final pC = TextEditingController();

  final fK = GlobalKey<FormState>();

  String? aV(String? v) {
    if (v != null && v.trim().length >= 6) {
      return null;
    }
    return "Address must be at least 6 characters";
  }

  String? tV(String? v) {
    if (v != null && v.trim().length >= 2) {
      return null;
    }
    return "Enter a valid town or city";
  }

  String? pV(String? v) {
    if (v != null && RegExp(r'^\d{5}$').hasMatch(v.trim())) {
      return null;
    }
    return "Enter a valid 5-digit postcode";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      body: SafeArea(
        child: Form(
          key: fK,
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(16.w),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Settings",
                    style: AppTextStyles.h3,
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    "Shipping Address",
                    style: AppTextStyles.b2,
                  ),
                  SizedBox(height: 28.h),
                  Text(
                    "Country",
                    style: AppTextStyles.b2,
                  ),
                  SizedBox(height: 4.h),

                      Text(
                        "Pakistan",
                        style: GoogleFonts.nunitoSans(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w800,
                          color: blue,
                        ),),

                  SizedBox(height: 24.h),
                  Text(
                    "Address",
                    style: AppTextStyles.b2,
                  ),
                  SizedBox(height: 6.h),
                  InputField(
                    bColor: lightGrey,
                    con: aC,
                    hint: const Text(""),
                    isAbscure: false,
                    isPrefix: false,
                    isSuffix: false,
                    label: const Text("Required",style: TextStyle(
                      color: Color(0xff9EB4E8)
                    ),),
                    preIcon: const SizedBox(),
                    suffIcon: const SizedBox(),
                    val: aV,
                  ),
                  SizedBox(height: 16.h),
                  Text(
                    "Town / City",
                    style: AppTextStyles.b2,
                  ),
                  SizedBox(height: 6.h),
                  InputField(
                    bColor: lightGrey,
                    con: tC,
                    hint: const Text(""),
                    isAbscure: false,
                    isPrefix: false,
                    isSuffix: false,
                    label: const Text("Required",style: TextStyle(
                        color: Color(0xff9EB4E8)
                    ),),
                    preIcon: const SizedBox(),
                    suffIcon: const SizedBox(),
                    val: tV,
                  ),
                  SizedBox(height: 16.h),
                  Text(
                    "Postcode",
                    style: AppTextStyles.b2,
                  ),
                  SizedBox(height: 6.h),
                  InputField(
                    bColor: lightGrey,
                    con: pC,
                    hint: const Text(""),
                    isAbscure: false,
                    isPrefix: false,
                    isSuffix: false,
                    label: const Text("Required",style: TextStyle(
                        color: Color(0xff9EB4E8)
                    ),),
                    preIcon: const SizedBox(),
                    suffIcon: const SizedBox(),
                    val: pV,
                  ),
                  SizedBox(height: 228.h),
                  SizedBox(
                    width: double.infinity,
                    height: 48.h,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: blue,
                        foregroundColor: Colors.white,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                      ),
                      onPressed: () {
                        if (fK.currentState!.validate()) {
                          String address =
                              "${aC.text.trim()}, "
                              "${tC.text.trim()}, "
                              "${pC.text.trim()}, Pakistan";

                          context.read<AppBloc>().add(
                            EditAddress(
                              value: address,
                              purpose: "address",
                            ),
                          );

                          Navigator.pop(context);
                        }
                      },
                      child: Text(
                        "Save Changes",
                        style: GoogleFonts.nunitoSans(
                          fontSize: 16.sp,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 16.h),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}