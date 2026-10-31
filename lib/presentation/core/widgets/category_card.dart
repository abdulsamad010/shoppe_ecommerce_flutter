import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../colors/app_colors.dart';
import '../text_styles/app_text_styles.dart';

class CategoryCard extends StatelessWidget {
  final categories,index;
  CategoryCard({super.key,required this.categories,required this.index});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 202.h,
      width: 175.w,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(9.r),
          color: white,
          boxShadow: [
            BoxShadow(
                offset: Offset(0,5),
                blurRadius: 10,
                color: black.withOpacity(0.1)
            )
          ]
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding:EdgeInsets.only(left:6.w,right: 4.w,bottom: 4.w,top: 6.w),
                child: ClipRRect(
                  borderRadius: BorderRadiusGeometry.circular(5.r),
                  child: Image.network(categories[index]["img1"],
                    fit: BoxFit.cover,
                    height: 75.h,width: 75.w,
                  errorBuilder: (context, error, stackTrace) => SizedBox(height: 75.h,width: 75.w,),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 6.w,bottom: 4.w,right: 6.w),
                child: ClipRRect(
                  borderRadius: BorderRadiusGeometry.circular(5.r),
                  child: Image.network(categories[index]["img2"],
                    fit: BoxFit.cover,
                    height: 75.h,width: 75.w,
                      errorBuilder: (context, error, stackTrace) => SizedBox(height: 75.h,width: 75.w,)
                  ),

                ),
              ),
            ],
          ),

          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: EdgeInsets.only(left: 6.w,bottom: 6.w,right: 4.w),
                child: ClipRRect(
                  borderRadius: BorderRadiusGeometry.circular(5.r),
                  child: Image.network(categories[index]["img3"],
                    fit: BoxFit.cover,
                    height: 75.h,width: 75.w,
                      errorBuilder: (context, error, stackTrace) => SizedBox(height: 75.h,width: 75.w,)
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 6.w,right: 6.w),
                child: ClipRRect(
                  borderRadius: BorderRadiusGeometry.circular(5.r),
                  child: Image.network(categories[index]["img4"],
                    fit: BoxFit.cover,
                    height: 75.h,width: 75.w,
                      errorBuilder: (context, error, stackTrace) => SizedBox(height: 75.h,width: 75.w,)
                  ),
                ),
              ),
            ],
          ),


          Padding(
            padding: EdgeInsets.only(left: 6.w,bottom: 6.w,right: 6.w),
            child: Row(
              children: [
                Text("${categories[index]["name"]}",style: AppTextStyles.h3.copyWith(
                    fontSize: 17.sp,letterSpacing: -0.17
                ),),
              ],
            ),
          )

        ],
      ),
    );
  }
}
