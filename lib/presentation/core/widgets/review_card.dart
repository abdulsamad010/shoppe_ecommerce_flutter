import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shoppe_ecommerce_flutter/presentation/core/bloc/app_bloc/app_bloc.dart';
import 'package:shoppe_ecommerce_flutter/presentation/core/bloc/app_bloc/app_state.dart';
import 'package:shoppe_ecommerce_flutter/presentation/core/text_styles/app_text_styles.dart';

import '../colors/app_colors.dart';

class ReviewCard extends StatelessWidget {
  final int productIndex,ReviewIndex;
  ReviewCard({super.key,required this.productIndex,required this.ReviewIndex});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppBloc,AppState>(
      builder:(context,state)=> Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Padding(
            padding: EdgeInsets.only(top:4.w),
            child: Container(
              height: 40.h,
              width: 40.w,
              padding: EdgeInsets.all(2.w),
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: white,
                  boxShadow: [
                    BoxShadow(
                      color: black.withOpacity(0.16),
                      blurRadius: 15,
                    )
                  ]
              ),
              child: Container(
                clipBehavior: Clip.hardEdge,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle
                  ),
                  child: Image.network("${state.products[productIndex].reviewersImages[ReviewIndex]}",fit: BoxFit.cover,)),
            ),
          ),


          Padding(
            padding:EdgeInsets.all(8.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Text("${state.products[productIndex].reviewersNames[ReviewIndex]}",style: GoogleFonts.raleway(
                  fontWeight: FontWeight(600),
                  fontSize: 16,
                ),),

                SizedBox(height:4),

                RatingBarIndicator(
                    itemCount: 5,
                    rating: state.products[productIndex].ratings[ReviewIndex].toDouble(),
                    itemSize: 20,
                    itemPadding: EdgeInsets.only(right: 2),
                    itemBuilder: (context,index){
                      return Icon(Icons.star,color: Color(0xFFECA61B),);
                    }),

                SizedBox(height: 8.h,),

                Text("${state.products[productIndex].reviews[ReviewIndex]}",
                  style: GoogleFonts.nunitoSans(
                    fontWeight: FontWeight(400),
                    fontSize: 12,
                  ),
                )

              ],
            ),
          )

        ],
      ),
    );;
  }
}
