import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shoppe_ecommerce_flutter/presentation/core/bloc/app_bloc/app_event.dart';
import 'package:shoppe_ecommerce_flutter/presentation/core/bloc/app_bloc/app_state.dart';
import 'package:shoppe_ecommerce_flutter/presentation/core/text_styles/app_text_styles.dart';
import 'package:shoppe_ecommerce_flutter/presentation/core/widgets/input_field.dart';
import 'package:shoppe_ecommerce_flutter/presentation/features/signup/bloc/signup_bloc.dart';
import 'package:shoppe_ecommerce_flutter/presentation/features/signup/bloc/signup_state.dart';

import '../../../data/repositories/food_repository_impl.dart';
import '../../../domain/usecases/get_foods.dart';
import '../../core/bloc/app_bloc/app_bloc.dart';
import '../../core/colors/app_colors.dart';
import '../login_email/bloc/auth_bloc.dart';
import '../login_email/login_email_screen.dart';
import 'bloc/signup_event.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final getFoodsObject=GetFoods(repository: FoodRepositoryImpl());
  final eCon = TextEditingController();
  final pCon = TextEditingController();
  final phCon = TextEditingController();

  String? _selectedGender;
  bool isDialogOpen = false;

  final fK=GlobalKey<FormState>();

  String? eVal(String? v) {
    if (v == null || v.trim().isEmpty) {
      return "Email cannot be empty";
    }
    final regex = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
    if (!regex.hasMatch(v.trim())) {
      return "Enter a valid email address";
    }
    return null;
  }

  String? pVal(String? v) {
    if (v == null || v.trim().isEmpty) {
      return "Password cannot be empty";
    }
    if (v.trim().length < 8 || v.trim().length > 8) {
      return "Password must be at least 8 characters long";
    }
    final regex = RegExp(r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$');
    if (!regex.hasMatch(v.trim())) {
      return "Password must contain both letters and numbers";
    }
    return null;
  }

  String? phVal(String? v) {
    if (v == null || v.trim().isEmpty) {
      return "Phone number cannot be empty";
    }
    final regex = RegExp(r"^[0-9]{7,12}$");
    if (!regex.hasMatch(v.trim())) {
      return "Enter a valid phone number (digits only)";
    }
    return null;
  }

  String? gVal(String? v) {
    if (v == null || v.trim().isEmpty) {
      return "Gender cannot be empty";
    }
    return null;
  }


  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create:(context)=>SignupBloc(getFoodsObject: getFoodsObject),
      child: BlocConsumer<SignupBloc,SignupState>(
        listener: (context,signupState){


          if(signupState.signupStatus=="waiting"){
            if (!isDialogOpen) {
              isDialogOpen = true;

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
          else if(signupState.signupStatus=="successful"){

            if (isDialogOpen) {
              Navigator.of(context, rootNavigator: true).pop();
              isDialogOpen = false;
            }

            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) =>
                    LoginEmailScreen()));

            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Signup Successful",style: AppTextStyles.b1),backgroundColor: Colors.transparent,));

            context.read<SignupBloc>().add(CleanSignupStatus());
          }
          else if(signupState.signupStatus=="exception"){

            if (isDialogOpen) {
              Navigator.of(context, rootNavigator: true).pop();
              isDialogOpen = false;
            }

            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Signup Failed",style: AppTextStyles.b1),backgroundColor: Colors.transparent,));

            context.read<SignupBloc>().add(CleanSignupStatus());
          }

        },

        builder:(context,signupState)=> BlocBuilder<AppBloc,AppState>(

          builder:(context,state)=> Scaffold(
            backgroundColor: white,
            body: Form(
              key: fK,
              child: Stack(
                children:[
        
                  Transform.translate(
                      offset: Offset(-58, -115),
                      child: SvgPicture.asset("assets/icons/bubble 02.svg")),
        
                  Align(
                      alignment: .topRight,
                      child: Padding(
                        padding: EdgeInsets.only(top:45.h),
                        child: SvgPicture.asset("assets/icons/bubble 01-1.svg"),
                      )),
        
                  SingleChildScrollView(
                  child: Padding(
                    padding:  EdgeInsets.all(16.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
        
        
                        SizedBox(height: 90.h,),
        
                        Padding(
                          padding: EdgeInsets.all(8.w),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
        
                              Text("Create",style: AppTextStyles.h1),
                              Text("Account",style: AppTextStyles.h1),
        
                              SizedBox(height: 42.h,),
        
                              GestureDetector(
                                  onTap: ()async{
                                    final imagePicker=ImagePicker();
                                    XFile? picker= await imagePicker.pickImage(
                                      source: ImageSource.gallery,
                                    );
        
                                    context.read<SignupBloc>().add(Picker(picker: picker));
        
                                  },
                                  child:
                                  signupState.picker!=null?
                                  Container(
                                    height: 90.h,
                                    width: 90.w,
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle
                                    ),
                                    clipBehavior: Clip.hardEdge,
                                    child: Image.file(fit: BoxFit.cover,File(signupState.picker!.path)),
                                  ) :
                                  SvgPicture.asset("assets/icons/Upload Photo.svg")),
        
        
                            ],
                          ),
                        ),
        
                        SizedBox(height: 28.h,),
        
                        InputField(bColor: lightGrey,hint: Text(""), label: Text("Email",style: AppTextStyles.textField1,), isAbscure: false, isPrefix: false, isSuffix: false, preIcon:Icon(Icons.remove_red_eye), suffIcon: Icon(Icons.remove_red_eye), val: eVal, con: eCon),
        
                        SizedBox(height: 8.h,),
        
                        InputField(bColor: lightGrey,hint: Text(""), label: Text("Password",style: AppTextStyles.textField1,), isAbscure: true, isPrefix: false, isSuffix: true, preIcon:Icon(Icons.remove_red_eye), suffIcon: Icon(Icons.visibility_off_outlined,), val: pVal, con: pCon),
        
        
                        SizedBox(height: 8.h,),
        
                        InputField(bColor: lightGrey,hint: Text(""), label: Text("Your number",style: AppTextStyles.textField1,), isAbscure: false, isPrefix: true, isSuffix: false,
                            preIcon:Padding(
                              padding: EdgeInsets.only(left: 16.w),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                                DropdownButton<String>(
                              underline: DropdownButtonHideUnderline(child: SizedBox()),
                              icon: Icon(Icons.keyboard_arrow_down,color: black,fontWeight: FontWeight.normal,),
                              value: null,
                              hint: Image.asset(signupState.selectedLink, width: 32),
                              items: [
                                DropdownMenuItem(
                                  value: "+92",
                                  child: Image.asset("assets/images/pakistan_640.png", width: 32),
                                ),
                                DropdownMenuItem(
                                  value: "+44",
                                  child: Image.asset("assets/images/FLAG.png", width: 32),
                                ),
        
                              ],
                              onChanged: (v) {
        
                                  String link="";
                                  if (v == "+44") {
                                    link = "assets/images/FLAG.png";
                                  }
                                  else if (v == "+92") {
                                    link = "assets/images/pakistan_640.png";
                                  }
        
                                  context.read<SignupBloc>().add(ChangeFlag(link: link));
                              },
                                                ),
        
                                                SizedBox(width: 8.w,),
        
                                                SizedBox(
                                height: 25.h,
                                child: VerticalDivider(thickness: 1.2,color: black.withOpacity(1),)),
        
                                              ],),
                            ), suffIcon: Icon(Icons.visibility_off_outlined), val: phVal, con: phCon),
        
        
                        SizedBox(height: 8.h,),
        
                        DropdownButtonFormField(
                          value: _selectedGender,
                          validator: gVal,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(35.r),
                            borderSide: BorderSide.none),
                              contentPadding: EdgeInsets.fromLTRB(19.76.w,15.81.w,19.76.w,15.81.w),
                              fillColor: lightGrey,
                            filled: true
                          ),
                          icon: Icon(Icons.keyboard_arrow_down,color: black,fontWeight: FontWeight.normal,),
                          hint:  Text("Gender",style: AppTextStyles.textField1,),
                          items: [
                            DropdownMenuItem(
                              value: "male",
                              child: Text("Male",)
                            ),
                            DropdownMenuItem(
                              value: "female",
                              child:  Text("Female")
                            ),
                            DropdownMenuItem(
                              value: "others",
                              child:  Text("Others",)  ),
        
                          ],
                          onChanged: (v) {
                            _selectedGender=v;
                            },
                        ),
        
        
        
                        SizedBox(height: 55.h,),
        
                        Center(
                          child: SizedBox(
                            width: 335.w,
                            height: 61.h,
                            child: ElevatedButton(onPressed: (){
        
                              if(fK.currentState!.validate() && signupState.picker!=null){
                                String ph="";
                                if(signupState.selectedLink=="assets/images/FLAG.png") {
                                  ph = "+44" + "${phCon.text}";
                                }
                                else{
                                  ph="+92"+"${phCon.text}";
                                }
                                  context.read<SignupBloc>().add(SetSignup(
                                    sGender: _selectedGender!,
                                      sImagePicker: "",
                                      sPhone: ph,
                                      sEmail: eCon.text,
                                      sPassword: pCon.text));
                                }
                              else {
                                if (signupState.picker == null) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(
                                            "Failed!! Please add profile image first",
                                            style: AppTextStyles.b1),
                                        backgroundColor: Colors.transparent,));
                                }
                              }
                            },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: blue,
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16),
                                  ),
                                ),
                                child: Text(
                                  "Done",
                                  style: AppTextStyles.button1,
                                )),
                          ),
                        ),
        
                        SizedBox(height: 22.h,),
        
                            Center(
                              child: TextButton(onPressed: (){
                                Navigator.pop(context);
                              }, child: Text(
                                "Cancel",style: AppTextStyles.button2,
                              )),
                            ),
        
        
                        SizedBox(height: 64.h,),
        
                      ],
        
        
                    ),
                  ),
                ),
                    ]
              ),
            ),
          ),
        ),
      ),
    );
  }
}
