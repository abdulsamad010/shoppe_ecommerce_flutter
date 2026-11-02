import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shoppe_ecommerce_flutter/presentation/core/bloc/app_bloc/app_event.dart';
import 'package:shoppe_ecommerce_flutter/presentation/core/bloc/app_bloc/app_state.dart';
import 'package:shoppe_ecommerce_flutter/presentation/core/text_styles/app_text_styles.dart';
import 'package:shoppe_ecommerce_flutter/presentation/features/track/track_screen.dart';

import '../../features/bottom_navigation_bar/bottom_navigation_bar_screen.dart';
import '../../features/shop/shop_screen.dart';
import '../bloc/app_bloc/app_bloc.dart';
import '../colors/app_colors.dart';

class ToRecieveCard extends StatefulWidget {
  int index;
  ToRecieveCard({super.key,required this.index});

  @override
  State<ToRecieveCard> createState() => _ToRecieveCardState();
}

class _ToRecieveCardState extends State<ToRecieveCard> {
  String? cartProductId;
  int? productIndex;


  final con=TextEditingController();

  @override
  void initState() {

    super.initState();

    context.read<AppBloc>().add(GetProducts());

    cartProductId=context.read<AppBloc>().state.ordersPlaced[widget.index]["cart_items"][0]["productId"];
    productIndex=context.read<AppBloc>().state.products.indexWhere((item){
      return item.id==cartProductId;
    });
  }



  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppBloc,AppState>(

      listener: (context, state) {


        if(state.isProceed){

          showDialog(context: context,barrierDismissible: false, builder: (context) {
            return AlertDialog(
              backgroundColor: white,
              content: Container(
                  height: 50.h,
                  width: 50.w,
                  child: Center(
                      child: CircularProgressIndicator(color: blue,))),
            );
          });
        }
        
        
        if(state.isSubmitted==true){
          Navigator.pop(context);
          showDialog(barrierDismissible: false,context: context, builder: (context){
            return AlertDialog(
              backgroundColor: white,
              clipBehavior: Clip.none,
              title: Center(
                child: Transform.translate(
                  offset: Offset(0, -60),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                          height: 80.w,
                          width: 80.w,
                          clipBehavior: Clip.hardEdge,
                          padding: EdgeInsets.all(8.w),
                          decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.black.withOpacity(0.16),
                                    blurRadius: 8.r
                                )
                              ],
                              shape: BoxShape.circle,
                              color: white
                          ),
                          child: Center(child: SvgPicture.asset("assets/icons/Component 5 – 3 (1).svg",height: 50.w,width: 50.w,))),

                      //SizedBox(height: 8.h),

                      Transform.translate(
                        offset: Offset(0, 20),
                        child: Column(
                          children: [

                            Text("Done!",style: GoogleFonts.raleway(
                              fontSize: 19,
                              fontWeight: FontWeight(700),
                            ),),

                            SizedBox(height: 8.h,width: 347.w,),

                            Text("Thank you for your review",style: GoogleFonts.nunitoSans(
                              fontSize: 13,
                              fontWeight: FontWeight(600),
                            ),),


                            Transform.translate(
                              offset: Offset(0, 18),
                              child: SizedBox(
                                width: 225.w,
                                height: 34.h,
                                child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(backgroundColor: blue,
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(11.r)
                                        )
                                    ),

                                    onPressed: (){

                                      Navigator.pop(context);
                                      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>BottomNavigationBarScreen()), (route) => true);
                                      context.read<AppBloc>().add(ScreensNavigation(index: 0));
                                    }, child: Text("Go to Home",style: AppTextStyles.b2.copyWith(color: white),)),
                              ),
                            )

                          ],
                        ),
                      )


                    ],
                  ),
                ),
              ),
            );
          });

        }
      },

        builder: (context,state) {
          return SizedBox(
            height: 89.w,
            width: 335.w,
            child: Row(
              children: [

                Container(
                  height: 89.w,
                  width: 89.w,
                  padding: EdgeInsets.all(5.w),
                  decoration: BoxDecoration(
                      color: white,
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 10,
                            offset: Offset(0, 5),
                            color: black.withOpacity(0.1)
                        ),
                      ],
                      borderRadius: BorderRadius.circular(9.r)
                  ),
                  clipBehavior: Clip.hardEdge,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(9.r),
                    child: productIndex!=null ?Image.network("${state.products[productIndex!].imageUrl}",fit: BoxFit.cover,) : SizedBox(),
                  ),
                ),

                SizedBox(width: 16.w,),

                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 113.w,
                      height: 18.w,
                      child: Text("Order #${state.ordersPlaced[widget.index]["order_id"]}",
                        style: GoogleFonts.raleway(
                            fontSize: 14,
                            fontWeight: FontWeight(700)
                        ),),
                    ),

                    SizedBox(height: 6.h,),

                    Text("${state.ordersPlaced[widget.index]["delivery_method"]["name"]} Delivery",
                      style: GoogleFonts.raleway(
                          fontSize: 14,
                          fontWeight: FontWeight(500)
                      ),),

                    SizedBox(height: 16.h,),

                    SizedBox(
                      width: 100.w,
                      height: 20.h,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Expanded(child: Text("${state.ordersPlaced[widget.index]["order_status"].last}")),

                          SizedBox(width: 4.w,),

                          SvgPicture.asset("assets/icons/Group 1196 (1).svg"),
                        ],
                      ),
                    )

                  ],
                ),

                SizedBox(width: 30.w,),

                SizedBox(
                  height: 89.h,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [

                      Container(
                        height: 22.h,
                        width: 61.w,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4.r),
                            color: Color(0xFFF9F9F9)
                        ),
                        child: Center(
                          child: Text("${state.ordersPlaced[widget.index]["cart_items"].length} items"),
                        ),
                      ),

                      state.ordersPlaced[widget.index]["order_status"].last!="Delivered" ?
                      SizedBox(
                        height: 30.h,
                        width: 86.w,
                        child: ElevatedButton(onPressed: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>TrackScreen(ordersPlacedIndex: widget.index)));
                        },
                            style: ElevatedButton.styleFrom(
                                backgroundColor: blue,
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(9.r))
                            ),
                            child: Text("Track",style: GoogleFonts.raleway(
                                fontWeight: FontWeight(500),
                                fontSize: 16,
                                color: white
                            ),)),
                      ) :
                      SizedBox(
                        height: 30.h,
                        width: 86.w,
                        child: ElevatedButton(onPressed: (){

                          state.ordersPlaced[widget.index]["order_rating"]==null || state.ordersPlaced[widget.index]["order_rating"].isEmpty ?
                          showModalBottomSheet(backgroundColor: white,
                              useSafeArea: true,
                              context: context, builder: (context){
                                double selectedRating = 0.0;
                            return Padding(
                              padding:  EdgeInsets.only(
                                bottom: MediaQuery.of(context).viewInsets.bottom,
                              ),
                              child: SingleChildScrollView(
                                child: Column(
                                  children: [

                                    Container(
                                      height: 80.h,
                                      width: 375.w,
                                      padding: EdgeInsets.all(12.w),
                                      decoration: BoxDecoration(
                                        color: Color(0xFFF8FAFF),
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(9.r),
                                          topRight: Radius.circular(9.r)
                                        )
                                      ),
                                      child: Text("Review",style: GoogleFonts.raleway(
                                          fontWeight: FontWeight(700),
                                          fontSize: 22,
                                          color: black
                                      ),),
                                    ),

                                    Padding(
                                      padding:  EdgeInsets.all(16.w),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [

                                          Row(
                                            children: [
                                              Container(
                                                height: 40.w,
                                                width: 40.w,
                                                padding: EdgeInsets.all(2.w),
                                                clipBehavior: Clip.hardEdge,
                                                decoration: BoxDecoration(
                                                    color: white,
                                                    shape: BoxShape.circle,
                                                    boxShadow: [
                                                      BoxShadow(
                                                        color: black.withOpacity(0.16),
                                                        blurRadius: 15,
                                                      ),
                                                    ]
                                                ),
                                                child: Image.network("${state.profileImage}",fit: BoxFit.cover,),
                                              ),

                                              SizedBox(width: 6.w,),
                                              Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [

                                                  Text("Please Write Your Review for",style: GoogleFonts.nunitoSans(
                                                      fontWeight: FontWeight(400),
                                                      fontSize: 12,
                                                      color: black
                                                  ),),

                                                  SizedBox(height: 8.w,),

                                                  Text("Order #${state.ordersPlaced[widget.index]["order_id"]}",style: GoogleFonts.raleway(
                                                      fontWeight: FontWeight(700),
                                                      fontSize: 14,
                                                      color: black
                                                  ),),

                                                ],
                                              )


                                            ],
                                          ),

                                          SizedBox(height: 8.h,),

                                          SizedBox(
                                            height: 35,
                                            child: RatingBar.builder(
                                              itemCount: 5,
                                              initialRating: 1,
                                              itemPadding: EdgeInsets.only(right: 3.w),
                                              itemSize: 35.w,
                                              minRating: 1,
                                              maxRating: 5,
                                              allowHalfRating: false,
                                              onRatingUpdate: (v) {

                                                selectedRating=v;

                                                print("Selected rating: $v");
                                                try {
                                                  context.read<AppBloc>().add(
                                                      ChangeRating(
                                                          value: v.toDouble()));
                                                }catch(e){
                                                  print("exception");
                                                }
                                                print("2. ChangeRating dispatched");
                                              },
                                              //unratedColor:  Color(0xFFECA61B).withOpacity(0.5),
                                              itemBuilder: (context, index) {
                                                return Icon(
                                                  Icons.star_border,
                                                  color: Color(0xFFECA61B),
                                                );
                                              },
                                            ),
                                          ),

                                          SizedBox(height: 8.h,),

                                          SizedBox(
                                            height: 100.w,
                                            width: 335.w,
                                            child: TextField(
                                              controller: con,
                                              expands: true,
                                              maxLines: null,
                                              textAlignVertical: TextAlignVertical.top,
                                              decoration: InputDecoration(
                                                hint: Text("Your comment",style: GoogleFonts.raleway(
                                                  fontWeight: FontWeight(500),
                                                  fontSize: 16
                                                ),),
                                                filled: true,
                                                fillColor: Color(0xFFF1F4FE),
                                                border: OutlineInputBorder(
                                                  borderSide: BorderSide.none
                                                ),
                                                disabledBorder: OutlineInputBorder(
                                                  borderSide: BorderSide.none,
                                                borderRadius: BorderRadius.circular(9.r)
                                                )
                                              ),
                                            ),
                                          ),

                                          SizedBox(height: 16.w,),

                                          SizedBox(
                                            height: 40.h,
                                            width: 325.w,
                                            child: ElevatedButton(onPressed: (){

                                              print(con.text);

                                              print(selectedRating);

                                              if(con!=null && con.text.trim().length>2 && selectedRating>0) {

                                                
                                                context.read<AppBloc>().add(
                                                    SaveRating(ratingValue: con
                                                        .text,ordersPlacedIndex:widget.index));


                                              }
                                            },
                                                style: ElevatedButton.styleFrom(
                                                    backgroundColor: blue,
                                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(9.r))
                                                ),
                                                child: Text("Say it!",style: GoogleFonts.nunitoSans(
                                                    fontWeight: FontWeight(300),
                                                    fontSize: 16,
                                                    color: Color(0xFFF3F3F3)
                                                ),)),
                                          ),

                                          SizedBox(height: 16.w,),

                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          })
                          :

                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("You already reviewed this order",style: AppTextStyles.b1),backgroundColor: Colors.transparent,));
                        },
                            style: ElevatedButton.styleFrom(
                                backgroundColor: white,
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(9.r
                                ),side: BorderSide(
                                  color: blue,
                                ))
                            ),
                            child: Text("${state.ordersPlaced[widget.index]["order_rating"]==null || state.ordersPlaced[widget.index]["order_rating"].isEmpty ?  "Review":"Reviewed"}",style: GoogleFonts.raleway(
                                fontWeight: FontWeight(500),
                                color: blue,
                                fontSize: 8
                            ),)),
                      ),

                    ],
                  ),
                )

              ],
            ),
          );
        }
    );
  }
}

