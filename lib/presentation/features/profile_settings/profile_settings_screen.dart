import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shoppe_ecommerce_flutter/presentation/features/settings/settings_screen.dart';

import '../../core/bloc/app_bloc/app_bloc.dart';
import '../../core/bloc/app_bloc/app_event.dart';
import '../../core/bloc/app_bloc/app_state.dart';
import '../../core/colors/app_colors.dart';
import '../../core/text_styles/app_text_styles.dart';

class ProfileSettingsScreen extends StatefulWidget {
  const ProfileSettingsScreen({super.key});

  @override
  State<ProfileSettingsScreen> createState() =>
      _ProfileSettingsScreenState();
}

class _ProfileSettingsScreenState extends State<ProfileSettingsScreen> {
  final formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  String? validateName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Please enter your name';
    }
    if (value.trim().length < 2) {
      return 'Name must be at least 2 characters';
    }
    return null;
  }

  String? validateEmail(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Please enter your email';
    }
    if (!RegExp(
      r'^[\w.-]+@([\w-]+\.)+[\w-]{2,}$',
    ).hasMatch(value.trim())) {
      return 'Please enter a valid email address';
    }
    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your password';
    }
    if (value.length < 8) {
      return 'Password must be at least 8 characters';
    }
    return null;
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<AppBloc>().add(LoadOrdersAndProfileImage());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppBloc,AppState>(
      builder: (context,state) {
        return Scaffold(
          backgroundColor: white,
          body: SafeArea(
            child: Padding(
              padding: EdgeInsets.all(16.w),
              child: Form(
                key: formKey,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Settings',
                        style: GoogleFonts.nunitoSans(
                          fontSize: 24.sp,
                          fontWeight: FontWeight.w800,
                          color: black,
                        ),
                      ),
                      SizedBox(height: 2.h),
                      Text(
                        'Your Profile',
                        style: GoogleFonts.nunitoSans(
                          fontSize: 14.sp,
                          color: black,
                        ),
                      ),
                      SizedBox(height: 20.h),
                      Stack(
                        alignment: Alignment.topRight,
                        children: [
                          Container(
                            width: 105.w,
                            height: 105.w,
                            clipBehavior: Clip.hardEdge,
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: black.withOpacity(0.16),
                                  blurRadius: 5
                                )
                              ],
                              shape: BoxShape.circle,
                              color: white,
                              border: Border.all(
                                color: white,
                                width: 4.w,
                              ),
                            ),
                            padding: EdgeInsets.all(2.5.w),
                            child: Container(
                              clipBehavior: Clip.hardEdge,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle
                                ),
                                child: state.picker!=null?
                                Image.file(fit: BoxFit.cover,File(state.picker!.path)
                                ) : Image.network(width: 105.w,
                                  height: 105.w,"${state.profileImage}",fit: BoxFit.cover,)),
                          ),
                          GestureDetector(
                            onTap: () async{
                              final imagePicker=ImagePicker();
                              XFile? picker= await imagePicker.pickImage(
                                source: ImageSource.gallery,
                              );

                              context.read<AppBloc>().add(Picker(picker: picker));

                            },
                            child: Container(
                              padding: EdgeInsets.all(5.w),
                              decoration: BoxDecoration(
                                color: blue,
                                border: Border.all(
                                  color: Colors.white,
                                  width: 2,
                                ),
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                Icons.edit,
                                color: white,
                                size: 16.sp,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20.h),
                      TextFormField(
                        controller: nameController,
                        decoration: InputDecoration(
                          hintText: 'Name',
                          filled: true,
                          fillColor: const Color(0xFFF0F2FC),
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 16.w,
                            vertical: 14.h,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.r),
                            borderSide: BorderSide.none,
                          ),
                        ),
                        validator: validateName,
                      ),
                      SizedBox(height: 8.h),
                      TextFormField(
                        controller: emailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          hintText: 'Email',
                          filled: true,
                          fillColor: const Color(0xFFF0F2FC),
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 16.w,
                            vertical: 14.h,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.r),
                            borderSide: BorderSide.none,
                          ),
                        ),
                        validator: validateEmail,
                      ),
                      SizedBox(height: 8.h),
                      TextFormField(
                        controller: passwordController,
                        obscureText: true,
                        decoration: InputDecoration(
                          hintText: 'Password',
                          filled: true,
                          fillColor: const Color(0xFFF0F2FC),
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 16.w,
                            vertical: 14.h,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.r),
                            borderSide: BorderSide.none,
                          ),
                        ),
                        validator: validatePassword,
                      ),
                      SizedBox(height: 250.h),
                      SizedBox(
                        width: double.infinity,
                        height: 44.h,
                        child: ElevatedButton(
                          onPressed: () {


                            if(formKey.currentState!.validate()){

                              if (state.picker == null) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                          "Failed!! Please add profile image first",
                                          style: AppTextStyles.b1),
                                      backgroundColor: Colors.transparent,));

                                return;
                              }
                              else{

                                context.read<AppBloc>().add(SetSignup(
                                    sGender: "",
                                    sImagePicker: "",
                                    sPhone: "",
                                    sEmail: emailController.text,
                                    sPassword: passwordController.text,
                                  name:nameController.text,
                                ));


                                if(state.status=="successful") {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text(
                                          'Profile updated successfully'),
                                    ),
                                  );
                                  Navigator.pop(context);
                                  Navigator.pushReplacement(context,
                                      MaterialPageRoute(builder: (context) =>
                                          SettingsScreen()));
                                }
                                else if(state.status=="exception"){
                                  Navigator.pop(context);
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text(
                                          'Profile updated failed, please fresh login first and than update!!'),
                                    ),
                                  );
                                }
                                else{

                                    showDialog(context: context, builder: (context) {
                                      return AlertDialog(
                                        backgroundColor: white,
                                        content: Container(
                                            height: 50.h,
                                            width: 50.w,
                                            child: Center(
                                                child: CircularProgressIndicator(color: blue,))),
                                      );
                                    });

                                }

                              }

                            }



                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF064BFF),
                            foregroundColor: white,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(7.r),
                            ),
                          ),
                          child: Text(
                            'Save Changes',
                            style: GoogleFonts.nunitoSans(
                              fontSize: 13.sp,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      }
    );
  }
}