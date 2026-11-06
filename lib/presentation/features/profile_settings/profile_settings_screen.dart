import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shoppe_ecommerce_flutter/presentation/features/profile/bloc/profile_bloc.dart';
import 'package:shoppe_ecommerce_flutter/presentation/features/settings/settings_screen.dart';
import 'package:shoppe_ecommerce_flutter/presentation/features/signup/bloc/signup_bloc.dart';
import 'package:shoppe_ecommerce_flutter/presentation/features/signup/bloc/signup_state.dart';

import '../../../data/repositories/food_repository_impl.dart';
import '../../../domain/usecases/get_foods.dart';
import '../../core/bloc/app_bloc/app_bloc.dart';
import '../../core/bloc/app_bloc/app_event.dart';
import '../../core/bloc/app_bloc/app_state.dart';
import '../../core/colors/app_colors.dart';
import '../../core/text_styles/app_text_styles.dart';
import '../profile/bloc/profile_state.dart';
import '../signup/bloc/signup_event.dart';

class ProfileSettingsScreen extends StatefulWidget {
  const ProfileSettingsScreen({super.key});

  @override
  State<ProfileSettingsScreen> createState() =>
      _ProfileSettingsScreenState();
}

class _ProfileSettingsScreenState extends State<ProfileSettingsScreen> {
  final formKey = GlobalKey<FormState>();
  final getFoodsObject=GetFoods(repository: FoodRepositoryImpl());
  final nameController = TextEditingController();
  final oldPasswordController = TextEditingController();
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
    passwordController.dispose();
    oldPasswordController.dispose();
    super.dispose();
  }



  bool isSearching=false;

  @override
  void initState() {
    super.initState();
    context.read<AppBloc>().add(LoadOrdersAndProfileImage());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(



      create: (context)=>SignupBloc(getFoodsObject: getFoodsObject),
      child: BlocConsumer<SignupBloc,SignupState>(
        listener: (context, signupState) {
          if(signupState.signupStatus=="successful") {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text(
                    'Profile updated successfully'),
              ),
            );



            Navigator.of(context, rootNavigator: true).pop();
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) =>
                    SettingsScreen()));
          }
          else if(signupState.signupStatus=="exception"){
            Navigator.of(context, rootNavigator: true).pop();
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text(
                    'Profile updated failed, please enter correct password or check you connection!!'),
              ),
            );
          }
          else if(signupState.signupStatus=="waiting" && isSearching==false){
            isSearching=true;
            showDialog(useRootNavigator: true,context: context, builder: (context) {
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
        },
        builder: (context,signupState) {
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


                                      child: signupState.picker!=null?
                                      Image.file(fit: BoxFit.cover,File(signupState.picker!.path)
                                      ) : Image.network(width: 105.w,
                                        height: 105.w,"${state.profileImage}",fit: BoxFit.cover,
                                      errorBuilder: (context, error, stackTrace) => SizedBox(),)),
                                ),
                                GestureDetector(
                                  onTap: () async{
                                    final imagePicker=ImagePicker();
                                    XFile? picker= await imagePicker.pickImage(
                                      source: ImageSource.gallery,
                                    );

                                    context.read<SignupBloc>().add(Picker(picker: picker));

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
                              //controller: emailController,
                              readOnly: true,
                              keyboardType: TextInputType.emailAddress,
                              decoration: InputDecoration(
                                hintText: '${state.email}',
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
                             // validator: validateEmail,
                            ),



                            SizedBox(height: 8.h),



                            TextFormField(
                              controller: oldPasswordController,
                              obscureText: true,
                              decoration: InputDecoration(
                                hintText: 'Old Password',
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
                            SizedBox(height: 8.h),






                            TextFormField(
                              controller: passwordController,
                              obscureText: true,
                              decoration: InputDecoration(
                                hintText: 'New Password',
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
                            SizedBox(height: 200.h),
                            SizedBox(
                              width: double.infinity,
                              height: 44.h,
                              child: ElevatedButton(
                                onPressed: () {



                                  if(formKey.currentState!.validate()){

                                    if (signupState.picker == null) {
                                      ScaffoldMessenger.of(context).showSnackBar(
                                          SnackBar(
                                            content: Text(
                                                "Failed!! Please add profile image first",
                                                style: AppTextStyles.b1),
                                            backgroundColor: Colors.transparent,));

                                      return;
                                    }
                                    else{

                                      context.read<SignupBloc>().add(SetSignup(
                                          sGender: "",
                                          sImagePicker: "",
                                          sPhone: "",
                                          sEmail: state.email,
                                          oSPassword:oldPasswordController.text,
                                          sPassword: passwordController.text,
                                        name:nameController.text,
                                      ));


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
      ),
    );
  }
}