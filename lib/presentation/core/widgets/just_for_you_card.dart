import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shoppe_ecommerce_flutter/presentation/core/text_styles/app_text_styles.dart';

import '../colors/app_colors.dart';

class JustForYouCard extends StatelessWidget {
  final image,text,price;
  const JustForYouCard({super.key,required this.image,required this.text,required this.price});

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
              child: Image.network("$image",
                fit: BoxFit.cover,
                height: 171.h,
                width: 155.w,
              errorBuilder: (context, error, stackTrace) => SizedBox(),
              ),
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
              ],
            ),
          )]);
  }
}
