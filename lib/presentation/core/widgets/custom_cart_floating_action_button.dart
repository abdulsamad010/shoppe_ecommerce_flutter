import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shoppe_ecommerce_flutter/presentation/core/bloc/app_bloc/app_event.dart';
import 'package:shoppe_ecommerce_flutter/presentation/features/bottom_navigation_bar/bottom_navigation_bar_screen.dart';
import 'package:shoppe_ecommerce_flutter/presentation/features/cart/cart_screen.dart';

import '../../features/shop/shop_screen.dart';
import '../bloc/app_bloc/app_bloc.dart';
import '../bloc/app_bloc/app_state.dart';
import '../colors/app_colors.dart';
import '../text_styles/app_text_styles.dart';

class CustomCartFloatingActionButton extends StatelessWidget {
  final String productId;
  CustomCartFloatingActionButton({super.key,required this.productId});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppBloc,AppState>(
      builder:(context,state)=> SizedBox(height: 84.h,
      width: 375.w,
        child: Container(

          padding: EdgeInsets.only(left: 32),
          decoration: BoxDecoration(
            color: white
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [

              GestureDetector(
              onTap: (){
                context.read<AppBloc>().add(AddToFavourite(productId:productId));

              },
                  child: state.favoriteProductsIds.contains(productId) ? 
                  Icon(Icons.favorite,color: Colors.red,size: 28,): SvgPicture.asset("assets/icons/Path 337.svg",


                  )),

              SizedBox(
                width: 128.w,
                height: 40.h,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(11.r),
                        )
                    ),
                    onPressed: (){
                      if(!(state.cart.any((item) => item["productId"] == productId))){

                        if(state.cartProgress["quantity"]>0) {

                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text("Item is added to your cart",
                                  style: AppTextStyles.b1),
                                backgroundColor: Colors.transparent,));


                          context.read<AppBloc>().add(AddToCart());

                          context.read<AppBloc>().add(ScreensNavigation(index: 0));

                          Navigator.push(
                              context, MaterialPageRoute(builder: (context) =>
                              BottomNavigationBarScreen()));

                             }
                        else{
                          SnackBar(content: Text("Quantity should be greater than zero!!",
                              style: AppTextStyles.b1),
                            backgroundColor: Colors.transparent,);
                        }
                      }
                      else{
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Item is already in your cart",style: AppTextStyles.b1),backgroundColor: Colors.transparent,));
                      }

                     }, child:Text("Add to cart",style: GoogleFonts.nunitoSans(fontWeight: FontWeight(300),
                    fontSize: 16,
                    color: Color(0xFFF3F3F3)),)),
              ),


              SizedBox(
                width: 128.w,
                height: 40.h,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: blue,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(11.r),
                        )
                    ),
                    onPressed: (){



                      if(!(state.cart.any((item) => item["productId"] == productId))){

                        if(state.cartProgress["quantity"]>0) {

                          context.read<AppBloc>().add(AddToCart());

                          context.read<AppBloc>().add(ScreensNavigation(index: 3));

                          Navigator.push(
                              context, MaterialPageRoute(builder: (context) =>
                              BottomNavigationBarScreen()));

                        }
                        else{
                          SnackBar(content: Text("Quantity should be greater than zero!!",
                              style: AppTextStyles.b1),
                            backgroundColor: Colors.transparent,);
                        }
                      }
                      else{
                        context.read<AppBloc>().add(ScreensNavigation(index: 3));

                        Navigator.push(
                            context, MaterialPageRoute(builder: (context) =>
                            BottomNavigationBarScreen()));
                          }




                        }, child:Text("Buy now",style: GoogleFonts.nunitoSans(fontWeight: FontWeight(300),
                    fontSize: 16,
                    color: Color(0xFFF3F3F3)),)),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
