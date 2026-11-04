import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shoppe_ecommerce_flutter/presentation/core/text_styles/app_text_styles.dart';
import 'package:shoppe_ecommerce_flutter/presentation/features/signup/signup_screen.dart';

import '../../core/colors/app_colors.dart';
import '../login_email/login_email_screen.dart';

class StartScreen extends StatefulWidget {
  const StartScreen({super.key});

  @override
  State<StartScreen> createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      body: SingleChildScrollView(
        child: Column(
          children: [
        
           //Spacer(),
            SizedBox(height: 190.h,),
        
            Container(
              padding: EdgeInsets.all(32.w),
              decoration: BoxDecoration(
                color: white,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    offset: Offset(0, 3),
                    color: Color(0x29000000),
                    blurRadius: 8
                  )
                ],
              ),
              child: SvgPicture.asset("assets/icons/Group 1000004649.svg",),
            ),
        
            SizedBox(height: 16.h,),
        
            Text("Shoppe",style: AppTextStyles.h1,),
        
            SizedBox(height: 16.h,),
        
            Padding(
              padding: EdgeInsets.only(left:75.w,right: 75.w),
              child: Text(
                textAlign: TextAlign.center,
                "Beautiful eCommerce UI Kit for your online store",style: AppTextStyles.b1,),
            ),
        
            SizedBox(height: 90.h,),
        
            SizedBox(
              width: 335.w,
                height: 61.h,
              child: ElevatedButton(onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>SignupScreen()));
              },
                style: ElevatedButton.styleFrom(
                  backgroundColor: blue,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16),
                  ),
                ),
                child: Text(
                "Let's get started",
                style: AppTextStyles.button1,
              )),
            ),
        
            SizedBox(height: 16.h,),
        
            TextButton(
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginEmailScreen()));
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "I already have an account",style: AppTextStyles.button2,
                  ),
        
                  SizedBox(width: 8.w,),
        
                  Container(
                    padding: EdgeInsets.all(8.w),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: blue
                    ),
                    child: SvgPicture.asset("assets/icons/Arrow.svg"),
                  )
                ],
              ),
            ),
        
            SizedBox(height: 34.h,),
        
          ],
        ),
      ),
    );
  }
}

