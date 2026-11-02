import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shoppe_ecommerce_flutter/presentation/core/bloc/app_bloc/app_bloc.dart';
import 'package:shoppe_ecommerce_flutter/presentation/core/bloc/app_bloc/app_event.dart';
import 'package:shoppe_ecommerce_flutter/presentation/core/text_styles/app_text_styles.dart';
import 'package:shoppe_ecommerce_flutter/presentation/features/bottom_navigation_bar/bottom_navigation_bar_screen.dart';
import 'package:shoppe_ecommerce_flutter/presentation/features/shop/shop_screen.dart';

import '../../core/colors/app_colors.dart';

class HelloCardScreen2 extends StatefulWidget {
  const HelloCardScreen2({super.key});

  @override
  State<HelloCardScreen2> createState() => _HelloCardScreen2State();
}

class _HelloCardScreen2State extends State<HelloCardScreen2> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      body: Stack(
        children: [


          SvgPicture.asset("assets/icons/bubble 01 (4).svg"),

          Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [

                SizedBox(height: 55.h,),

                Container(
                   width: 326.w,
                  height: 614.h,
                  decoration: BoxDecoration(
                    color: white,
                      boxShadow: [
                        BoxShadow(
                            color: black.withOpacity(0.16),
                            blurRadius: 37,
                            offset: Offset(0, 10)
                        )
                      ],
                    borderRadius: BorderRadius.circular(30.r)
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [

                      ClipRRect(
                          borderRadius: BorderRadius.only(topLeft: Radius.circular(30.r),
                          topRight: Radius.circular(30.r)
                          ),
                          child: Image.asset("assets/images/Placeholder_01.png",width: 326.w,height: 338.h,fit: BoxFit.cover,)),

                      SizedBox(height: 45.h,),

                      Text("Ready?",style: AppTextStyles.h2,),


                      Padding(
                        padding: EdgeInsets.only(left:26.w,right: 26.w,top: 8.w,bottom: 22.w),
                        child: Column(
                          children: [
                            Text(
                              textAlign: TextAlign.center,
                              "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
                            style: AppTextStyles.b1,
                            ),

                            SizedBox(height: 16.w,),

                            SizedBox(
                              width: 201.w,
                              height: 50.h,
                              child: ElevatedButton(onPressed: (){
                                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>BottomNavigationBarScreen()));
                                context.read<AppBloc>().add(ScreensNavigation(index: 0));
                              },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: blue,
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16),
                                    ),
                                  ),
                                  child: Text(
                                    "Let's Start",
                                    style: AppTextStyles.button1,
                                  )),
                            ),


                          ],
                        ),
                      )
                    ],
                  ),
                ),

                SizedBox(height: 35.h,),

                SizedBox(
                  width: 140.w,
                  height: 20.h,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: List.generate(4, (index) {
                      return Container(
                        height: 20.h,
                        width: 20.w,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: index==3 ?
                              blue : Color(0xFFC7D6FB),
                        ),
                      );
                    },),
                  ),
                ),

                SizedBox(height: 45.h,),

              ],
            ),
          )


        ],
      ),
    );
  }
}
