import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shoppe_ecommerce_flutter/presentation/core/bloc/app_bloc/app_state.dart';
import 'package:shoppe_ecommerce_flutter/presentation/core/text_styles/app_text_styles.dart';

import '../../core/bloc/app_bloc/app_bloc.dart';
import '../../core/colors/app_colors.dart';
import '../../core/widgets/favorate_items_card.dart';

class WishlistScreen extends StatefulWidget {
  const WishlistScreen({super.key});

  @override
  State<WishlistScreen> createState() => _WishlistScreenState();
}

class _WishlistScreenState extends State<WishlistScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppBloc,AppState>(
      builder: (context,state) {
        return Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            title: Text("Wishlist",style: AppTextStyles.h2,),
            backgroundColor: white,
          ),

          backgroundColor: white,
          body: Padding(
            padding:EdgeInsets.all(16.w),
            child: state.favoriteProductsIds.isNotEmpty ?

            ListView.builder(
                itemCount: state.favoriteProductsIds.length,
                itemBuilder: (context,index){
                  return Padding(padding: EdgeInsets.only(bottom: 14.h),
                    child: FavorateItemsCard(index:index),
                  );
                }) : Center(child: SvgPicture.asset("assets/icons/Empty.svg")),
          ),
        );
      }
    );
  }
}
