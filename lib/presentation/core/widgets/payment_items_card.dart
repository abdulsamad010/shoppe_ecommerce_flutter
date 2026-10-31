import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../bloc/app_bloc/app_bloc.dart';
import '../bloc/app_bloc/app_state.dart';
import '../colors/app_colors.dart';
import '../text_styles/app_text_styles.dart';

class PaymentItemsCard extends StatefulWidget {
  int index;
  PaymentItemsCard({super.key,required this.index});

  @override
  State<PaymentItemsCard> createState() => _PaymentItemsCardState();
}

class _PaymentItemsCardState extends State<PaymentItemsCard> {

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
    return BlocBuilder<AppBloc,AppState>(
      builder:(context,state)=> Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [

          Row(
            children: [
              Stack(
                alignment: .topRight,
                children: [

                  Container(
                    clipBehavior: Clip.hardEdge,
                    padding: EdgeInsets.all(4.w),
                    height: 60.h,
                    width: 60.w,
                    decoration: BoxDecoration(
                      color: white,
                        boxShadow: [
                          BoxShadow(color: black.withOpacity(0.16),
                              blurRadius: 10,
                              offset: Offset(0, 5)
                          ),
                        ],
                        shape: BoxShape.circle,
                    ),
                    child: Container(
                    clipBehavior: Clip.hardEdge,
                        decoration:BoxDecoration(
                          shape: BoxShape.circle
                        ),
                      child: Image.network("${state.products[productIndex!].imageUrl}",fit: BoxFit.cover,)),
                    ),

                        Transform.translate(
                          offset: Offset(3, 3),
                          child: Container(
                            height: 22.w,
                            width: 22.w,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Color(0xFFE5EBFC),
                              border: Border.all(color: white)
                            ),
                            child: Center(child: Text("${state.cart.length}",style: AppTextStyles.h3.copyWith(fontSize: 13),)),
                          ),
                        ),


                ],
              ),

              SizedBox(width: 16.w,),

              Text("${state.products[productIndex!].name}",style: AppTextStyles.b2,),



            ],
          ),






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



        ],
      ),
    );
  }
}

