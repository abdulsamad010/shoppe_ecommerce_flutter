import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shoppe_ecommerce_flutter/presentation/core/bloc/app_bloc/app_bloc.dart';
import 'package:shoppe_ecommerce_flutter/presentation/core/bloc/app_bloc/app_state.dart';
import 'package:shoppe_ecommerce_flutter/presentation/features/profile/profile_screen.dart';
import 'package:shoppe_ecommerce_flutter/presentation/features/to_receive/to_receive_screen.dart';
import 'package:shoppe_ecommerce_flutter/presentation/features/wishlist/wishlist_screen.dart';

import '../../core/bloc/app_bloc/app_event.dart';
import '../../core/colors/app_colors.dart';
import '../cart/cart_screen.dart';
import '../shop/shop_screen.dart';

class BottomNavigationBarScreen extends StatefulWidget {
  const BottomNavigationBarScreen({super.key});

  @override
  State<BottomNavigationBarScreen> createState() => _BottomNavigationBarScreenState();
}

class _BottomNavigationBarScreenState extends State<BottomNavigationBarScreen> {

  final screensList=[
    ShopScreen(),
    WishlistScreen(),
    ToReceiveScreen(),
    CartScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppBloc,AppState>(
      builder: (context,state)=>Scaffold(

        body: screensList[state.screenIndex],

        bottomNavigationBar: BottomNavigationBar(
          showSelectedLabels: false,
            backgroundColor: white,
            unselectedItemColor: blue,
            selectedItemColor: black,
            onTap: (i){
              context.read<AppBloc>().add(ScreensNavigation(index:i));
            },
            currentIndex: state.screenIndex,

            items: [
          BottomNavigationBarItem(icon: SvgPicture.asset("assets/icons/shop.svg"),
          backgroundColor: white,
              label: "",
            activeIcon: Column(
              children: [
                SvgPicture.asset("assets/icons/shop.svg",color: black,),
                SizedBox(height: 4.h,),
                SvgPicture.asset("assets/icons/Mark 05.svg"),
              ],
            ),
          ),

              BottomNavigationBarItem(icon: SvgPicture.asset("assets/icons/heart.svg"),
                backgroundColor: white,
                label: "",
                activeIcon: Column(
                  children: [
                    SvgPicture.asset("assets/icons/heart.svg",color: black,),
                    SizedBox(height: 4.h,),
                    SvgPicture.asset("assets/icons/Mark 05.svg"),
                  ],
                ),
              ),


              BottomNavigationBarItem(icon: SvgPicture.asset("assets/icons/Categories.svg"),
                backgroundColor: white,
                  label: "",
                activeIcon: Column(
                  children: [
                    SvgPicture.asset("assets/icons/Categories.svg",color: black,),
                    SizedBox(height: 4.h,),
                    SvgPicture.asset("assets/icons/Mark 05.svg"),
                  ],
                ),
              ),



              BottomNavigationBarItem(icon: SvgPicture.asset("assets/icons/Cart (1).svg"),
                backgroundColor: white,
                  label: "",
                activeIcon: Column(
                  children: [
                    SvgPicture.asset("assets/icons/Cart (1).svg",color: black,),
                    SizedBox(height: 4.h,),
                    SvgPicture.asset("assets/icons/Mark 05.svg"),
                  ],
                ),
              ),



              BottomNavigationBarItem(icon: SvgPicture.asset("assets/icons/Group 1948.svg"),
                backgroundColor: white,
                  label: "",
                activeIcon: Column(
                  children: [
                    SvgPicture.asset("assets/icons/Group 1948.svg",color: black,),
                    SizedBox(height: 4.h,),
                    SvgPicture.asset("assets/icons/Mark 05.svg"),
                  ],
                ),
              )

        ]),

      ),
    );
  }
}
