import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shoppe_ecommerce_flutter/presentation/core/bloc/app_bloc/app_state.dart';
import 'package:shoppe_ecommerce_flutter/presentation/core/text_styles/app_text_styles.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:shoppe_ecommerce_flutter/presentation/core/widgets/review_card.dart';
import '../../core/bloc/app_bloc/app_bloc.dart';
import '../../core/colors/app_colors.dart';

class ReviewScreen extends StatefulWidget {

  final int productIndex;
  const ReviewScreen({super.key,required this.productIndex});

  @override
  State<ReviewScreen> createState() => _ReviewScreenState();
}

class _ReviewScreenState extends State<ReviewScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppBloc,AppState>(
      builder:(context,state)=> Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: white,
          title: Text("Reviews",style: AppTextStyles.h2,),
        ),
        backgroundColor: white,
        body: Padding(
          padding:  EdgeInsets.all(16.w),
          child: ListView.builder(
              itemCount: state.products[widget.productIndex].reviews.length,
              itemBuilder: (context,index){
                return ReviewCard(productIndex: widget.productIndex, ReviewIndex: index);
              }),
        ),
      ),
    );
  }
}
