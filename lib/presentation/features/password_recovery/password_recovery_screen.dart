import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shoppe_ecommerce_flutter/presentation/core/bloc/app_bloc/app_bloc.dart';
import 'package:shoppe_ecommerce_flutter/presentation/core/bloc/app_bloc/app_event.dart';
import 'package:shoppe_ecommerce_flutter/presentation/core/bloc/app_bloc/app_state.dart';
import 'package:shoppe_ecommerce_flutter/presentation/core/text_styles/app_text_styles.dart';

import '../../core/colors/app_colors.dart';
import '../login_email/login_email_screen.dart';

class PasswordRecoveryScreen extends StatefulWidget {
  const PasswordRecoveryScreen({super.key});

  @override
  State<PasswordRecoveryScreen> createState() => _PasswordRecoveryScreenState();
}

class _PasswordRecoveryScreenState extends State<PasswordRecoveryScreen> {



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      body: Stack(
        children: [

          Align(
              alignment: .topRight,
              child: SvgPicture.asset("assets/icons/bubble 02 (1).svg")),

          Align(
              alignment: .topRight,
              child: SvgPicture.asset("assets/icons/bubble 01 (3).svg")),

          Padding(
            padding: EdgeInsets.all(16.w),
            child: Column(
              children: [

                SizedBox(height: 0.2.sh,),

                Container(
                    padding: EdgeInsets.all(8.w),
                    decoration:BoxDecoration(
                        shape: BoxShape.circle,
                        color: white,
                        boxShadow: [
                          BoxShadow(
                              blurRadius: 5,
                              color: Color(0xFF000029).withOpacity(0.1)
                          )
                        ]
                    ),
                    child: Image.asset("assets/images/image.png")),


                SizedBox(height: 8.h,),

                Text("Password Recovery",style: AppTextStyles.h2,),

                SizedBox(height: 8.h,),

                Text(
                  textAlign: TextAlign.center,
                  "How you would like to restore your password?",style: AppTextStyles.b1,),


                SizedBox(height: 32.h,),

               Center(
                    child: Container(
                      padding: EdgeInsets.all(6.w),
                      decoration: BoxDecoration(
                        color: Color(0xFFE5EBFC),
                        borderRadius: BorderRadius.circular(18.r)
                      ),
                      width: 199.w,
                      height: 40.h,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                                              children: [
                      Expanded(
                        child: Text(
                          "Email",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.raleway(color: blue,
                        fontWeight: FontWeight(700),
                          fontSize: 15.sp,
                          letterSpacing: -0.15,
                        ),
                        ),
                      ),



                      Container(
                        padding: EdgeInsets.all(1.5.w),
                        height: 22,
                        width: 22,
                        decoration: BoxDecoration(
                          color:white ,
                          shape: BoxShape.circle
                        ),
                        child: Container(
                          height: 22,
                          width: 22,
                          padding: EdgeInsets.all(4.w),
                          decoration: BoxDecoration(
                              color:blue ,
                              shape: BoxShape.circle
                          ),
                          child: SvgPicture.asset("assets/icons/Icon feather-check.svg"),
                        ),
                      )
                                              ],
                                            ),
                    ),
                  ),




                Spacer(),


                Center(
                  child: SizedBox(
                    width: 335.w,
                    height: 61.h,
                    child: ElevatedButton(onPressed: () {

                      context.read<AppBloc>().add(PasswordRecovery());

                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("If your email is registered you will get a password reset link",style: AppTextStyles.b1),backgroundColor: Colors.white,));

                      Navigator.pushReplacement(context,
                            MaterialPageRoute(builder: (context) =>
                                LoginEmailScreen()));
                    },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: blue,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                        child: Text(
                          "Next",
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


                SizedBox(height: 24.h,),


              ],
            ),
          )

        ],
      ),
    );
  }
}
