import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shoppe_ecommerce_flutter/presentation/core/bloc/app_bloc/app_event.dart';
import 'package:shoppe_ecommerce_flutter/presentation/core/text_styles/app_text_styles.dart';
import 'package:shoppe_ecommerce_flutter/presentation/core/widgets/custom_cart_floating_action_button.dart';

import '../../core/bloc/app_bloc/app_bloc.dart';
import '../../core/bloc/app_bloc/app_state.dart';
import '../../core/colors/app_colors.dart';

class ProductVariationsScreen extends StatefulWidget {
  final int productIndex;
  ProductVariationsScreen({super.key,required this.productIndex});

  @override
  State<ProductVariationsScreen> createState() => _ProductVariationsScreenState();
}


class _ProductVariationsScreenState extends State<ProductVariationsScreen> {


  Color getColorFromName(String colorName) {
    switch (colorName.toLowerCase()) {
      case 'blue':
        return Colors.blue;
      case 'green':
        return Colors.green;
      case 'red':
        return Colors.red;
      case 'black':
        return Colors.black;
      case 'white':
        return Colors.white;
      case 'yellow':
        return Colors.yellow;
      case 'purple':
        return Colors.purple;
      case 'pink':
        return Colors.pink;
      case 'orange':
        return Colors.orange;
      case 'grey':
      case 'gray':
        return Colors.grey;
      default:
        return Color(0xFFE5EBFC);
    }
  }



  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppBloc,AppState>(
      builder:(context,state)=> Scaffold(
        backgroundColor: white,
        body: SizedBox(
          height: 700.h,
          width: 375.w,
          child: Stack(

            children: [

              ImageFiltered(
                  imageFilter: ImageFilter.blur(sigmaX: 5,sigmaY: 5),
                  child: Image.network("${state.products[widget.productIndex].imageUrl}",height: 439.h,width: 375.w,fit: BoxFit.cover,)),




              Padding(
                padding: EdgeInsets.only(top:280.h),
                child: Container(
                  height: 450.h,
                  width: 375.w,
                   decoration: BoxDecoration(
                    color: white,
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(9.r),topRight: Radius.circular(9.r)),
                  ),

                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        Container(

                          height: 141.h,
                          width: 375.w,
                          padding: EdgeInsets.only(top: 22.w,bottom: 22.w,left: 16.w,right: 16.w,),
                          decoration: BoxDecoration(
                            color: Color(0xFFF8FAFF),
                            borderRadius: BorderRadius.circular(9.r),
                          ),

                          child: Row(
                            children: [
                              ClipRRect(
                                  borderRadius: BorderRadius.circular(6.r),
                                  child: Image.network("${state.products[widget.productIndex].imageUrl}",height: 75.w,width: 75.w,fit: BoxFit.cover,)),


                              SizedBox(width: 12.w,),

                              Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Transform.translate(
                                    offset: Offset(-6, 0),
                                    child: Row(
                                      children: [
                                        Icon(Icons.attach_money,fontWeight:FontWeight(800),size: 26,),


                                        Transform.translate(
                                          offset: Offset(-6.w, 0),
                                          child: Text("${state.products[widget.productIndex].price}",style: GoogleFonts.raleway(
                                              fontSize: 26,
                                              letterSpacing: -0.26,
                                              fontWeight: FontWeight(800)
                                          ),),
                                        ),

                                      ],
                                    ),
                                  ),

                                  SizedBox(height: 6.h,),

                                  Row(
                                    children: [

                                      Container(
                                        height: 25.w,
                                        width: 54.w,
                                        decoration: BoxDecoration(
                                            color: Color(0xFFE5EBFC),
                                            borderRadius: BorderRadius.circular(4.r)
                                        ),
                                        child: Center(
                                          child: Text("${state.cartProgress["color"]}",style: GoogleFonts.raleway(
                                            fontSize: 14,
                                            fontWeight: FontWeight(500),
                                          ),),
                                        ),
                                      ),

                                      SizedBox(width: 4.w,),

                                      Container(
                                        height: 25.w,
                                        width: 54.w,
                                        decoration: BoxDecoration(
                                            color: Color(0xFFE5EBFC),
                                            borderRadius: BorderRadius.circular(4.r)
                                        ),
                                        child: Center(
                                          child: Text("${state.cartProgress["size"]}",style: GoogleFonts.raleway(
                                            fontSize: 14,
                                            fontWeight: FontWeight(500),
                                          ),),
                                        ),
                                      ),


                                    ],
                                  ),

                            ],
                          ),
                                    ]),
                        ),



                            Padding(
                              padding:EdgeInsets.all(16.w),
                              child: SingleChildScrollView(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [

                                    Text("Color Options",style: GoogleFonts.raleway(
                                        fontSize: 17,
                                        fontWeight: FontWeight(700),
                                        letterSpacing: -0.17
                                    ),),


                                    SizedBox(height: 12.h,),

                                    SizedBox(
                                      height: 75.w,
                                      width: 330.w,
                                      child: ListView.builder(
                                          scrollDirection: Axis.horizontal,
                                          itemCount: state.products[widget.productIndex].colors.length,
                                          itemBuilder: (context,i){
                                            return Padding(
                                              padding: EdgeInsets.only(right: 6.w),
                                              child: GestureDetector(

                                                onTap: (){

                                                  if(!(state.cart.any((item) => item["productId"] == state.products[widget.productIndex].id))){
                                                    context.read<AppBloc>().add(UpdateCartProgress(productId: state.cartProgress["productId"], quantity: state.cartProgress['quantity'], color: state.products[widget.productIndex].colors[i], size: state.cartProgress['size']));
                                                  }
                                                  else{
                                                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Item is already in your cart",style: AppTextStyles.b1),backgroundColor: Colors.transparent,));
                                                  }
                                                  },

                                                child: Stack(
                                                  alignment: .bottomLeft,
                                                  children:[
                                                    Container(
                                                      height: 75.w,
                                                      width: 75.w,
                                                      decoration: BoxDecoration(
                                                        boxShadow: [
                                                          BoxShadow(color: grey,blurRadius: 1,spreadRadius: 1)
                                                        ],
                                                        borderRadius: BorderRadiusGeometry.circular(6.r),
                                                        color:getColorFromName(state.products[widget.productIndex].colors[i]) ,
                                                      ),
                                                    ),

                                                    state.products[widget.productIndex].colors[i]==state.cartProgress["color"] ?
                                                        Padding(padding: EdgeInsets.all(6.w),
                                                        child: Container(
                                                          height: 22.w,
                                                          width: 22.w,
                                                          clipBehavior: Clip.hardEdge,
                                                          decoration: BoxDecoration(
                                                            color: white,
                                                            shape: BoxShape.circle
                                                          ),
                                                          child:Center(child: Icon(Icons.check_circle,color: blue,)),
                                                        ),
                                                        ) : SizedBox(),
                                              ]
                                                ),
                                              ),
                                            );
                                          }),
                                    ),

                                    SizedBox(height: 18.h,),



                                    Text("Size",style: GoogleFonts.raleway(
                                        fontSize: 17,
                                        fontWeight: FontWeight(700),
                                        letterSpacing: -0.17
                                    ),),

                                    SizedBox(height: 12.h,),

                                    SizedBox(
                                      height: 25.w,
                                      width: 335.w,
                                      child: ListView.builder(
                                          scrollDirection: Axis.horizontal,
                                          itemCount: state.products[widget.productIndex].colors.length,
                                          itemBuilder: (context,i){
                                            return Padding(
                                              padding: EdgeInsets.only(right: 4.w),
                                              child: GestureDetector(

                                                onTap: (){
                                                  if(!(state.cart.any((item) => item["productId"] == state.products[widget.productIndex].id))){
                                                    context.read<AppBloc>().add(UpdateCartProgress(productId: state.cartProgress["productId"], quantity: state.cartProgress['quantity'], color:state.cartProgress['color'] , size: state.products[widget.productIndex].sizes[i]));
                                                  }
                                                  else{
                                                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Item is already in your cart",style: AppTextStyles.b1),backgroundColor: Colors.transparent,));
                                                  }

                                                  },

                                                child: Container(
                                                  padding: EdgeInsets.only(right: 4.w),
                                                  height: 25.w,
                                                  width: 50.w,
                                                  decoration: BoxDecoration(
                                                      color: state.products[widget.productIndex].sizes[i]==state.cartProgress["size"] ?
                                                          Color(0xFFE5EBFC)
                                                          :Color(0xFFF9F9F9),
                                                      borderRadius: BorderRadius.circular(4.r),

                                                    border: state.products[widget.productIndex].sizes[i]==state.cartProgress["size"] ? Border.all(color: blue) :Border.all(color: Colors.transparent)
                                                  ),
                                                  child: Center(
                                                    child: Text("${state.products[widget.productIndex].sizes[i]}",style: GoogleFonts.raleway(
                                                      fontSize: 14,
                                                      fontWeight: FontWeight(500),
                                                    ),),
                                                  ),
                                                ),
                                              ),
                                            );
                                          }),
                                    ),

                                    SizedBox(height: 16.h,),


                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text("Quantity",style: GoogleFonts.raleway(
                                            fontSize: 17,
                                            fontWeight: FontWeight(700),
                                            letterSpacing: -0.17
                                        ),),



                                        Row(
                                          children: [
                                            IconButton(onPressed: (){

                                              if(!(state.cart.any((item) => item["productId"] == state.products[widget.productIndex].id))){

                                               if(state.cartProgress['quantity']>1) {
                                                 context.read<AppBloc>().add(
                                                     UpdateCartProgress(
                                                         productId: state
                                                             .cartProgress["productId"],
                                                         quantity: state
                                                             .cartProgress['quantity'] -
                                                             1,
                                                         color: state
                                                             .cartProgress['color'],
                                                         size: state
                                                             .cartProgress['size']));
                                               }
                                               }
                                              else{
                                                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Item is already in your cart",style: AppTextStyles.b1),backgroundColor: Colors.transparent,));
                                              }
                                              }, icon: SvgPicture.asset("assets/icons/Less.svg")),



                                            SizedBox(width: 8.w,),

                                            Container(
                                              height: 25.h,
                                              width: 54.w,
                                              decoration: BoxDecoration(
                                                  color: Color(0xFFF9F9F9),
                                                  borderRadius: BorderRadius.circular(4.r)
                                              ),
                                              child: Center(
                                                child: Text("${state.cartProgress["quantity"]==null ? 0 : state.cartProgress["quantity"]}",style: GoogleFonts.raleway(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight(500),
                                                ),),
                                              ),
                                            ),

                                            SizedBox(width: 8.w,),

                                            IconButton(onPressed: (){

                                              if(!(state.cart.any((item) => item["productId"] == state.products[widget.productIndex].id))) {
                                                if (state
                                                    .cartProgress['quantity'] <
                                                    state.products[widget
                                                        .productIndex]
                                                        .quantity) {
                                                  context.read<AppBloc>().add(
                                                      UpdateCartProgress(
                                                          productId: state
                                                              .cartProgress["productId"],
                                                          quantity: state
                                                              .cartProgress['quantity'] +
                                                              1,
                                                          color: state
                                                              .cartProgress['color'],
                                                          size: state
                                                              .cartProgress['size']));
                                                }
                                              }
                                              else{
                                                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Item is already in your cart",style: AppTextStyles.b1),backgroundColor: Colors.transparent,));
                                              }

                                            }, icon: SvgPicture.asset("assets/icons/More (1).svg")),


                                          ],
                                        ),


                                      ],
                                    ),


                                  ],
                                ),
                              ),
                            )




                      ],
                    ),
                  ),
                ),
              )

            ],
          ),
        ),
        floatingActionButton: CustomCartFloatingActionButton(productId: state.products[widget.productIndex].id),
      ),
    );
  }
}
