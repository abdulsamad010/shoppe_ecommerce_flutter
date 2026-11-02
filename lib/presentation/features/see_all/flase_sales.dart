import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../core/bloc/app_bloc/app_bloc.dart';
import '../../core/bloc/app_bloc/app_event.dart';
import '../../core/bloc/app_bloc/app_state.dart';
import '../../core/colors/app_colors.dart';
import '../../core/text_styles/app_text_styles.dart';
import '../../core/widgets/flash_sales_card.dart';
import '../../core/widgets/flesh_sales_screen_card.dart';
import '../../core/widgets/just_for_you_card.dart';
import '../../core/widgets/new_items_card.dart';
import '../../core/widgets/top_products_card.dart';
import '../product_details/product_details_screen.dart';
import 'new_items.dart';

class FlashSales extends StatelessWidget {
  const FlashSales({super.key});



  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppBloc,AppState>(
        builder: (context,state) {
          return Scaffold(

              body: SingleChildScrollView(
               child: Stack(
                 alignment: .topRight,
                 children:[

                   SvgPicture.asset("assets/icons/bubble 02 (3).svg"),

                   SvgPicture.asset("assets/icons/bubble 01 (9).svg"),

                   Padding(
                     padding: EdgeInsets.only(left:16.w,right: 16.w,top: 42.w,bottom: 16.w),

                     child: Column(
                     crossAxisAlignment: CrossAxisAlignment.start,
                     children: [


                       Row(
                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                         children: [
                           Column(
                             crossAxisAlignment: CrossAxisAlignment.start,
                             children: [

                               Text("Flash Sales",style: AppTextStyles.h2),
                               Text("Choose Your Discount",style: AppTextStyles.b2),


                             ],
                           ),


                           Row(
                             children: [

                               Center(child: Icon(Icons.timer_sharp,color: white,)),

                               SizedBox(width: 8.w,),


                               Container(
                                 padding: const EdgeInsets.all(5),
                                 decoration: BoxDecoration(
                                   color: Colors.grey.shade100,
                                   borderRadius: BorderRadius.circular(8),
                                 ),
                                 child: Text(
                                   state.flashSale['endAt'] == null
                                       ? '00'
                                       : ((state.flashSale['endAt'] as Timestamp)
                                       .toDate()
                                       .difference(DateTime.now())
                                       .isNegative
                                       ? 0
                                       : (state.flashSale['endAt'] as Timestamp)
                                       .toDate()
                                       .difference(DateTime.now())
                                       .inDays ~/
                                       30)
                                       .toString()
                                       .padLeft(2, '0'),
                                   style: AppTextStyles.h3.copyWith(fontSize: 17),
                                 ),
                               ),
                               const SizedBox(width: 8),
                               Container(
                                 padding: const EdgeInsets.all(5),
                                 decoration: BoxDecoration(
                                   color: Colors.grey.shade100,
                                   borderRadius: BorderRadius.circular(8),
                                 ),
                                 child: Text(
                                   state.flashSale['endAt'] == null
                                       ? '00'
                                       : ((state.flashSale['endAt'] as Timestamp)
                                       .toDate()
                                       .difference(DateTime.now())
                                       .isNegative
                                       ? 0
                                       : (state.flashSale['endAt'] as Timestamp)
                                       .toDate()
                                       .difference(DateTime.now())
                                       .inDays %
                                       30)
                                       .toString()
                                       .padLeft(2, '0'),
                                   style: AppTextStyles.h3.copyWith(fontSize: 17),
                                 ),
                               ),
                               const SizedBox(width: 8),
                               Container(
                                 padding: const EdgeInsets.all(5),
                                 decoration: BoxDecoration(
                                   color: Colors.grey.shade100,
                                   borderRadius: BorderRadius.circular(8),
                                 ),
                                 child: Text(
                                   state.flashSale['endAt'] == null
                                       ? '00'
                                       : ((state.flashSale['endAt'] as Timestamp)
                                       .toDate()
                                       .difference(DateTime.now())
                                       .isNegative
                                       ? 0
                                       : (state.flashSale['endAt'] as Timestamp)
                                       .toDate()
                                       .difference(DateTime.now())
                                       .inHours %
                                       24)
                                       .toString()
                                       .padLeft(2, '0'),
                                   style: AppTextStyles.h3.copyWith(fontSize: 17),
                                 ),
                               ),


                             ],
                           ),





                         ],
                       ),

                       SizedBox(height: 16.w,),


                       Container(
                         height: 40.w,
                         child: Stack(
                           clipBehavior: Clip.none,
                           alignment: Alignment.center,
                           children: [
                             Container(
                               height: 28.w,
                               decoration: BoxDecoration(
                                 color: const Color(0xFFF9F9F9),
                                 borderRadius: BorderRadius.circular(8),
                               ),
                             ),

                             Row(
                               mainAxisAlignment: MainAxisAlignment.spaceAround,
                               children: [
                                 for (int i = 0; i < 6; i++)
                                   GestureDetector(
                                     onTap: () {
                                       context.read<AppBloc>().add(
                                         SelectFlashSales(percentIndex: i),
                                       );

                                       context.read<AppBloc>().add(SelectedFlashSalesDiscount(percentSelected: ['All', '10', '20', '30', '40', '50'][i]));
                                     },
                                     child: SizedBox(
                                       width: 48.w,
                                       height: 40.w,
                                       child: Center(
                                         child: Container(
                                           width: 60.w,
                                           height: state.flashSaleIndex == i ? 40.w : 28.w,
                                           alignment: Alignment.center,
                                           decoration: BoxDecoration(
                                             color: state.flashSaleIndex == i
                                                 ? Colors.white
                                                 : Colors.transparent,
                                             borderRadius: BorderRadius.circular(22.r),
                                             border: state.flashSaleIndex == i
                                                 ? Border.all(
                                               color: const Color(0xff246BFD),
                                               width: 2,
                                             )
                                                 : null,
                                             boxShadow: state.flashSaleIndex == i
                                                 ? [
                                               BoxShadow(
                                                 color: Colors.black.withOpacity(0.12),
                                                 blurRadius: 10,
                                                 offset: const Offset(0, 5),
                                               ),
                                             ]
                                                 : [],
                                           ),
                                           child: Stack(
                                             clipBehavior: Clip.none,
                                             alignment: Alignment.center,
                                             children: [
                                               Text(
                                                 ['All', '10%', '20%', '30%', '40%', '50%'][i],
                                                 style: GoogleFonts.raleway(
                                                   fontSize: state.flashSaleIndex == i
                                                       ? 16
                                                       : 13,
                                                   fontWeight: state.flashSaleIndex == i
                                                       ? FontWeight(800)
                                                       : FontWeight(700),
                                                   color: state.flashSaleIndex == i
                                                       ? const Color(0xff246BFD)
                                                       : Colors.black,
                                                 ),
                                               ),
                                               if (state.flashSaleIndex == i)
                                                 const Positioned(
                                                   top: -23,
                                                   child: Icon(
                                                     Icons.arrow_drop_down,
                                                     color: Color(0xff246BFD),
                                                     size: 35,
                                                   ),
                                                 ),
                                             ],
                                           ),
                                         ),
                                       ),
                                     ),
                                   ),
                               ],
                             ),
                           ],
                         ),
                       ),

                       SizedBox(height: 26.w,),

                       Row(
                         children: [
                           Text(
                             ['All', '10%', '20%', '30%', '40%', '50%'][state.flashSaleIndex],
                             style: GoogleFonts.raleway(
                               fontSize: 21,
                               fontWeight: FontWeight(700),
                               color:  Colors.black,
                             ),
                           ),

                           Text(
                             " Discount",style: GoogleFonts.raleway(
                               fontSize: 21,
                               fontWeight: FontWeight(700),
                               color:  Colors.black,
                             ),
                           ),
                         ],
                       ),

                       state.fleshSalesProducts.isNotEmpty?
                       GridView.builder(
                         physics: NeverScrollableScrollPhysics(),
                           shrinkWrap: true,
                           itemCount: state.fleshSalesProducts.length,
                           gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,
                               childAspectRatio: 0.8,
                               mainAxisSpacing: 1.w,
                               crossAxisSpacing: 0.w
                           ),
                           itemBuilder: (context,index){

                             return GestureDetector(

                                 onTap: (){


                                   int flashIndex=state.products.indexWhere((item) {
                                     return item.id == state.fleshSalesProducts[index].id;
                                   });

                                   Navigator.push(
                                     context,
                                     MaterialPageRoute(
                                       builder: (context) => ProductDetailsScreen(
                                           productId: state.products[flashIndex].id
                                       ),
                                     ),
                                   );


                                 },
                                 child: Padding(
                                   padding: EdgeInsets.only(left: 3,right:3.w),
                                   child: FleshSalesScreenCard(discount: state.fleshSalesProducts[index].discountPercentage,text: state.fleshSalesProducts[index].name,price: state.fleshSalesProducts[index].price,image: "${state.fleshSalesProducts[index].imageUrl}")));



                           }) : Center(child: Text("No Product Found!!",style: AppTextStyles.b1,)),


                       SizedBox(height: 16.h,),

                       Row(
                         children: [
                           Text("New Items",style: AppTextStyles.h3,),

                           Spacer(),

                           Text("See All",style: AppTextStyles.h3.copyWith(
                               fontSize: 15
                           ),),

                           SizedBox(width: 8.w,),

                           GestureDetector(
                             onTap: (){
                               Navigator.push(
                                 context,
                                 MaterialPageRoute(
                                     builder: (context) => NewItems()
                                 ),
                               );
                             },
                             child: Container(
                               height: 30.h,
                               width: 30.w,
                               padding: EdgeInsets.all(6.w),
                               clipBehavior: Clip.hardEdge,
                               decoration: BoxDecoration(
                                 shape: BoxShape.circle,
                                 color: blue,
                               ),
                               child: SvgPicture.asset(height: 11.h,width: 14.w,
                                   "assets/icons/Arrow.svg"),
                             ),
                           )
                         ],
                       ),

                       SizedBox(height: 8.h,),


                       SizedBox(
                         height: 245.h,
                         width: 432.w,
                         child: ListView.builder(
                             scrollDirection: Axis.horizontal,
                             itemCount: state.categories.length>3 ? 3 : state.categories.length,
                             itemBuilder: (context,index){
                               return GestureDetector(
                                 onTap: (){


                                   int arrivalIndex=state.products.indexWhere((item) {
                                     return item.id == state.newArrivalProducts[index].id;
                                   });

                                   Navigator.push(
                                     context,
                                     MaterialPageRoute(
                                       builder: (context) => ProductDetailsScreen(
                                           productId: state.products[arrivalIndex].id
                                       ),
                                     ),
                                   );


                                 },
                                 child: AspectRatio(
                                   aspectRatio: 0.6,
                                   child: Padding(
                                       padding: EdgeInsets.only(left: 3,right:3.w),
                                       child: NewItemsCard(image: "${state.newArrivalProducts[index].imageUrl}", text: "${state.newArrivalProducts[index].name}", price: state.newArrivalProducts[index].price)
                                   ),
                                 ),
                               );
                             }),
                       ),



                     ],
                                      ),
                   ),
               ]),
                                ));});
  }
}



