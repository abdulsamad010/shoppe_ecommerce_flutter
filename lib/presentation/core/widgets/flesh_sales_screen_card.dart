import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shoppe_ecommerce_flutter/presentation/core/text_styles/app_text_styles.dart';

import '../colors/app_colors.dart';

class FleshSalesScreenCard extends StatelessWidget {
  final image,text,price,discount;
  const FleshSalesScreenCard({super.key,required this.discount,required this.image,required this.text,required this.price});

  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
      Container(
      height: 181.h,
      width: 165.w,
      padding: EdgeInsets.all(4.w),
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        color: white,
        borderRadius: BorderRadius.circular(9.r),
        boxShadow: [
          BoxShadow(color: black.withOpacity(0.2),
          offset: Offset(0, 5),
            blurRadius: 10
          ),
        ],
      ),
      child: Center(
            child: Container(
              clipBehavior: Clip.hardEdge,
              height: 171.h,
              width: 155.w,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5.r),

              ),
              child: Stack(
                alignment: .topRight,
                children:[
                  Image.network("$image",
                  fit: BoxFit.cover,
                  height: 171.h,
                  width: 155.w,),


                  Container(
                    height: 18.h,
                    width: 39.w,
                    decoration: BoxDecoration(
                        gradient:
                        LinearGradient(colors: [
                          Color(0xFFF81140),
                          Color(0xFFFF5790)
                        ],
                          begin: AlignmentGeometry.centerLeft,
                          end: AlignmentGeometry.centerRight,
                        ),
                        borderRadius: BorderRadius.circular(5.r)
                    ),
                    child: Center(
                      child: Text("-$discount",
                          style: AppTextStyles.h3.copyWith(
                              fontSize: 13,
                              letterSpacing: -0.13,
                              color: white
                          )
                      ),
                    ),
                  ),

                ]),
            ),
          )),

          SizedBox(height: 6.h,),

          Text("$text",style: AppTextStyles.b2,),

          SizedBox(height: 6.h,),

          Transform.translate(
            offset: Offset(-4.w, 0),
            child: Row(
              children: [

                Icon(Icons.attach_money,fontWeight:FontWeight(700),),

                Transform.translate(
                  offset: Offset(-6.w, 0),
                  child: Text("$price",style: AppTextStyles.h3.copyWith(
                    fontSize: 17,
                    letterSpacing: -0.17
                  ),),
                ),


                SizedBox(
                  width: 80.w,
                  height: 18.w,
                  child: Stack(
                    children:[ 
                      Row(
                      children: [
                        Transform.translate(
                            offset: Offset(-8.w, 0),
                            child: Icon(Icons.attach_money,fontWeight:FontWeight(700),color: Color(0xFFF1AEAE),)),
                    
                        Flexible(
                          child: Transform.translate(
                            offset: Offset(-14.w, 0),
                            child: Text("${price/(1-discount/100)}",style: AppTextStyles.h3.copyWith(
                              fontSize: 17,
                              letterSpacing: -0.17
                              ,color: Color(0xFFF1AEAE),
                            ),),
                          ),
                        ),
                    
                      ],
                    ),
                      
                      Text("__________",style: TextStyle(color:Color(0xFFF1AEAE) ),)
                      
    ]
                  ),
                ),



              ],
            ),
          )]);
  }
}
