import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shoppe_ecommerce_flutter/presentation/core/text_styles/app_text_styles.dart';

import '../colors/app_colors.dart';

class FlashSalesCard extends StatelessWidget {
  final discount,image;
  const FlashSalesCard({super.key, required this.image,required this.discount});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(4.w),
      height: 114.h,
      width: 109.w,
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(9.r),
        boxShadow: [
          BoxShadow(
            offset: Offset(0, 5),
            blurRadius: 10,
            color: black.withOpacity(0.2)
          )
        ],
        color: white
      ),
      child: Stack(
        alignment: .topRight,
        children:[
        Container(
          height: 103.h,
          width: 99.w,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5.r),
          ),
          clipBehavior: Clip.hardEdge,
          child: Image.network("$image",
          fit: BoxFit.cover,
            height: 103.h,
            width: 99.w,
          ),
        ),


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

        ]
      ),
    );
  }
}
