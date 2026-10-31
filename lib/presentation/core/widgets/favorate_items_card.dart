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

class FavorateItemsCard extends StatefulWidget {
  int index;
  FavorateItemsCard({super.key, required this.index});


  @override
  State<FavorateItemsCard> createState() => _FavorateItemsCardState();
}

class _FavorateItemsCardState extends State<FavorateItemsCard> {

  String? favorateProductId;
  int? productIndex;
  @override
  void initState() {
    
    super.initState();

    favorateProductId=context.read<AppBloc>().state.favoriteProductsIds[widget.index];
    productIndex=context.read<AppBloc>().state.products.indexWhere((item){
      return item.id==favorateProductId;
    });
  }

  @override
  Widget build(BuildContext context) {
    return
      productIndex!=-1 && productIndex!=null ?
      BlocBuilder<AppBloc,AppState>(
        builder:(context,state)=> Row(
          mainAxisSize: MainAxisSize.min,
          children: [

            Stack(
                alignment: .bottomLeft,
                children:[
            Container(
              padding: EdgeInsets.all(3.w),
              height: 101.w,
              width: 121.w,
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(color: black.withOpacity(0.1),
                  blurRadius: 10,
                    offset: Offset(0, 5)
                  ),
                ],
                color: white,
                borderRadius: BorderRadius.circular(9.r)
              ),
              child: ClipRRect(
                    borderRadius: BorderRadius.circular(9.r),
                    child: Image.network("${state.products[productIndex!].imageUrl}",
                    fit: BoxFit.cover,
                                    ),
                  ),
            ),

                  Padding(
                    padding:  EdgeInsets.all(8.w),
                    child: GestureDetector(
                        onTap: (){
                          context.read<AppBloc>().add(RemoveFromFavourite(productId: favorateProductId!));
                        },
                        child: SvgPicture.asset("assets/icons/Frame.svg")),
                  )
                ],
              ),

            SizedBox(width: 8.w,),

            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Text("${state.products[productIndex!].name}",style: GoogleFonts.nunitoSans(
                  fontWeight: FontWeight(400),
                  fontSize: 12,
                ),),

                SizedBox(height: 26.h,),

                Transform.translate(
                  offset: Offset(-6, 0),
                  child: Row(
                    children: [
                      Icon(Icons.attach_money,fontWeight:FontWeight(700),),

                      Transform.translate(
                        offset: Offset(-6.w, 0),
                        child: Text("${(state.products[productIndex!].price)}",style: GoogleFonts.raleway(
                          fontWeight: FontWeight(700),
                          fontSize: 18,
                          letterSpacing: -0.18
                        ),),
                      ),
                    ],
                  ),
                ),



                SizedBox(height: 16.w,),

                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [



                    Container(
                      height: 25.w,
                      width: 54.w,
                      decoration: BoxDecoration(
                          color: Color(0xFFE5EBFC),
                          borderRadius: BorderRadius.circular(4.r)
                      ),
                      child: Center(
                        child: Text("${state.products[productIndex!].colors[0]}",style: AppTextStyles.b2,),

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
                        child: Text("${state.products[productIndex!].sizes[0]}",style: AppTextStyles.b2,),

                      ),
                    ),


                    SizedBox(width: 55,),

                    GestureDetector(
                        onTap: (){

                          int isAlreadyInCart=state.cart.indexWhere((item){
                            return item["productId"]==favorateProductId;
                          });

                          if(isAlreadyInCart==-1) {
                            context.read<AppBloc>().add(AddFavorateToCart(
                                productId: favorateProductId!));
                          }
                          },
                        child: SvgPicture.asset("assets/icons/Add.svg")),

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

