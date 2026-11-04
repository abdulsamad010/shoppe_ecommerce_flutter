import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shoppe_ecommerce_flutter/presentation/core/bloc/app_bloc/app_event.dart';
import 'package:shoppe_ecommerce_flutter/presentation/core/bloc/app_bloc/app_state.dart';
import 'package:shoppe_ecommerce_flutter/presentation/core/text_styles/app_text_styles.dart';
import 'package:shoppe_ecommerce_flutter/presentation/core/widgets/input_field.dart';
import 'package:shoppe_ecommerce_flutter/presentation/features/login_email/bloc/auth_bloc.dart';
import 'package:shoppe_ecommerce_flutter/presentation/features/start/start_screen.dart';

import '../../../data/repositories/food_repository_impl.dart';
import '../../../domain/usecases/get_foods.dart';
import '../../core/bloc/app_bloc/app_bloc.dart';
import '../../core/colors/app_colors.dart';
import '../login_password/login_password_screen.dart';
import 'bloc/auth_event.dart';
import 'bloc/auth_state.dart';

class LoginEmailScreen extends StatefulWidget {
  const LoginEmailScreen({super.key});

  @override
  State<LoginEmailScreen> createState() => _LoginEmailScreenState();
}

class _LoginEmailScreenState extends State<LoginEmailScreen> {
  final getFoodsObject=GetFoods(repository: FoodRepositoryImpl());
  final eCon = TextEditingController();
  final pCon = TextEditingController();
  final phCon = TextEditingController();

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


  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create:(context)=>AuthBloc(getFoodsObject: getFoodsObject),
      child: BlocBuilder<AuthBloc,AuthState>(
        builder:(blocContext,state)=> Scaffold(

          backgroundColor: white,
          body: Form(
            key: fK,
            child: Stack(
                children:[

                  SvgPicture.asset("assets/icons/bubble 02.svg"),

                  SvgPicture.asset("assets/icons/bubble 01.svg"),

                  Align(
                      alignment: .topRight,
                      child: Padding(
                        padding: EdgeInsets.only(top: 150.w),
                        child: SvgPicture.asset("assets/icons/bubblle 03.svg"),
                      )),



                  Align(
                      alignment: .bottomRight,
                      child: SvgPicture.asset(
                          "assets/icons/bubble 04.svg")),




                  SingleChildScrollView(
                    child: Padding(
                      padding:  EdgeInsets.all(16.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [


                          SizedBox(height: 0.55.sh,),

                          Text("Login",style: AppTextStyles.h1,),



                          Row(
                            children: [
                              Text("Good to see you back!",style: AppTextStyles.b1,),

                              SizedBox(width: 8.w,),

                              Icon(Icons.favorite,color: black,)
                            ],
                          ),

                          SizedBox(height: 22.h,),

                          InputField(bColor: lightGrey,hint: Text(""), label: Text("Email",style: AppTextStyles.textField1,), isAbscure: false, isPrefix: false, isSuffix: false, preIcon:Icon(Icons.remove_red_eye), suffIcon: Icon(Icons.remove_red_eye), val: eVal, con: eCon),



                          SizedBox(height: 44.h,),

                          Center(
                            child: SizedBox(
                              width: 335.w,
                              height: 61.h,
                              child: ElevatedButton(onPressed: (){
                                if(fK.currentState!.validate()) {

                                  blocContext.read<AuthBloc>().add(SetEmail(email: eCon.text));

                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (context) =>
                                          BlocProvider.value(
                                              value: BlocProvider.of<AuthBloc>(blocContext),
                                              child: LoginPasswordScreen())));
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
                              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>StartScreen()));
                            }, child: Text(
                              "Cancel",style: AppTextStyles.button2,
                            )),
                          ),


                          SizedBox(height: 44.h,),

                        ],


                      ),
                    ),
                  ),
                ]
            ),
          ),
        ),
      ),
    );
  }
}
