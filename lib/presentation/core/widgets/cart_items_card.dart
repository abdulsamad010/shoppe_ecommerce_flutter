import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shoppe_ecommerce_flutter/presentation/core/bloc/app_bloc/app_state.dart';
import 'package:shoppe_ecommerce_flutter/presentation/core/colors/app_colors.dart';
import 'package:shoppe_ecommerce_flutter/presentation/core/text_styles/app_text_styles.dart';
import '../../core/bloc/app_bloc/app_bloc.dart';
import '../bloc/app_bloc/app_event.dart';

class CartItemsCard extends StatefulWidget {
  int index;
  CartItemsCard({super.key, required this.index});


  @override
  State<CartItemsCard> createState() => _CartItemsCardState();
}

class _CartItemsCardState extends State<CartItemsCard> {

  String? cartProductId;
  int? productIndex;
  @override
  void initState() {
    
    super.initState();

    cartProductId=context.read<AppBloc>().state.cart[widget.index]["productId"];
    productIndex=context.read<AppBloc>().state.products.indexWhere((item){
      return item.id==cartProductId;
    });
  }

  @override
  Widget build(BuildContext context) {
    return
      productIndex!=-1 && productIndex!=null ?
      BlocBuilder<AppBloc,AppState>(
        builder:(context,state)=> Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Stack(
                alignment: .bottomLeft,
                children:[
            Container(
              padding: EdgeInsets.all(3.w),
              height: 101.w,
              width: 121.w,
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(
                color: white,
                boxShadow: [
                  BoxShadow(color: black.withOpacity(0.1),
                  blurRadius: 10,
                    offset: Offset(0, 5)
                  ),
                ],
                borderRadius: BorderRadius.circular(9.r)
              ),
              child:ClipRRect(
                borderRadius: BorderRadius.circular(9.r),
                child: Image.network("${state.products[productIndex!].imageUrl}",
                  fit: BoxFit.cover,
                  height: 101.w,
                  width: 121.w,
                ),
              ),
            ),


                  Padding(
                    padding:  EdgeInsets.all(8.w),
                    child: GestureDetector(
                        onTap: (){
                          context.read<AppBloc>().add(RemoveFromCart(removeIndex: widget.index));
                        },
                        child: SvgPicture.asset("assets/icons/Frame.svg")),
                  )
                ],
              ),


            SizedBox(width: 8.w,),

            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Text("${state.products[productIndex!].name}",style: GoogleFonts.nunitoSans(fontSize: 12,fontWeight: FontWeight(400)),),

                SizedBox(height: 12.h,),

                Text("${state.cart[widget.index]["color"]}, Size ${state.cart[widget.index]["size"]}",style: AppTextStyles.b2.copyWith(letterSpacing: -0.14,fontWeight: FontWeight(500),fontSize: 14),),

                SizedBox(height: 18.h,),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [

                    Row(
                      children: [
                        Icon(Icons.attach_money,fontWeight:FontWeight(700),),


                        Transform.translate(
                          offset: Offset(-6.w, 0),
                          child: Text("${(state.products[productIndex!].price)*(state.cart[widget.index]["quantity"] as num)}",style: AppTextStyles.h3.copyWith(
                              fontSize: 17,
                              letterSpacing: -0.17
                          ),),
                        ),


                      ],
                    ),



SizedBox(width: 5.w),

                    Row(
                      children: [
                        IconButton(onPressed: (){


                            if(state.cart[widget.index]['quantity']>1) {
                              context.read<AppBloc>().add(DecreaseQuantityFromCart(decreaseIndex: widget.index));
                            }

                        }, icon: SvgPicture.asset("assets/icons/Less.svg",height: 30.h,width: 30.w,)),





                        Container(
                          height: 25.h,
                          width: 54.w,
                          decoration: BoxDecoration(
                              color: Color(0xFFF9F9F9),
                              borderRadius: BorderRadius.circular(4.r)
                          ),
                          child: Center(
                            child: Text("${state.cart[widget.index]["quantity"]}",style: GoogleFonts.raleway(
                              fontSize: 14,
                              fontWeight: FontWeight(500),
                            ),),
                          ),
                        ),



                        IconButton(onPressed: (){

                           if (state
                                .cart[widget.index]['quantity'] <
                                state.products[state.products.indexWhere((item)=>item.id==state.cart[widget.index]["productId"])]
                                    .quantity) {
    context.read<AppBloc>().add(IncreaseQuantityFromCart(increaseIndex: widget.index));
                            }



                        }, icon: SvgPicture.asset("assets/icons/More (1).svg",height: 30.h,width: 30.w,),),


                      ],
                    ),







                  ],
                ),
              ],
            )

          ],
        ),
      )
    : Center(child: Text("Product Not Found!!",style: AppTextStyles.h3,),);
  }
}

