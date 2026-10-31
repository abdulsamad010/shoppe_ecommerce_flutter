import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart';
import 'package:shoppe_ecommerce_flutter/presentation/core/widgets/progress_slider.dart';

import '../../core/bloc/app_bloc/app_bloc.dart';
import '../../core/bloc/app_bloc/app_event.dart';
import '../../core/bloc/app_bloc/app_state.dart';
import '../../core/colors/app_colors.dart';
import '../../core/text_styles/app_text_styles.dart';

class TrackScreen extends StatefulWidget {
  int ordersPlacedIndex;
  TrackScreen({super.key,required this.ordersPlacedIndex});

  @override
  State<TrackScreen> createState() => _TrackScreenState();
}

class _TrackScreenState extends State<TrackScreen> {

  String? cartProductId;
  int? productIndex;

  @override
  void initState() {

    super.initState();
    context.read<AppBloc>().add(LoadOrdersAndProfileImage());
    cartProductId=context.read<AppBloc>().state.ordersPlaced[widget.ordersPlacedIndex]["cart_items"][0]["productId"];
    productIndex=context.read<AppBloc>().state.products.indexWhere((item){
      return item.id==cartProductId;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppBloc,AppState>(
        builder:(context,state)=>Scaffold(
          appBar: AppBar(
            backgroundColor: white,
            leading: Padding(
              padding:EdgeInsets.only(top: 5.0,bottom: 2),
              child: Container(
                height: 40.h,
                width: 40.w,
                padding: EdgeInsets.all(4.w),
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
                child: Container(
                    clipBehavior: Clip.hardEdge,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle
                    ),
                    child: Image.network("${state.profileImage}",fit: BoxFit.cover,)),
              ),
            ),
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                SizedBox(height: 6.h,),

                Text("To Recieve",style: AppTextStyles.h3,),

                SizedBox(height: 6.h,),

                Text("Track Your Order",style: GoogleFonts.raleway(
                    fontWeight: FontWeight(500),
                    fontSize: 14
                ),),

              ],
            ),
          ),

          backgroundColor: white,

          body: SingleChildScrollView(
            child: Padding(padding: EdgeInsets.all(16.w),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
              children: [


                ProgressSlider(currentStage: state.ordersPlaced[widget.ordersPlacedIndex]["order_status"].length),

                SizedBox(height: 12.h,),

                Container(
                  height: 52.w,
                  width: 335.w,
                  padding: EdgeInsets.all(8.w),
                  decoration: BoxDecoration(
                    color: Color(0xFFF9F9F9),
                    borderRadius: BorderRadius.circular(10.r)
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                          Text("Tracking Number",style: GoogleFonts.raleway(
                            fontSize: 14,
                            fontWeight: FontWeight(700)
                          ),),
                          SizedBox(height: 0.h,),
                          Text("${state.ordersPlaced[widget.ordersPlacedIndex]["order_id"]}",style: GoogleFonts.nunitoSans(
                              fontSize: 12,
                              fontWeight: FontWeight(400)
                          ),),

                        ],
                      ),

                      Spacer(),

                      SvgPicture.asset("assets/icons/Copy.svg",fit: BoxFit.cover,),
                    ],
                  ),
                ),

                SizedBox(height: 22.h,),


                ListView.builder(
                  shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: state.ordersPlaced[widget.ordersPlacedIndex]["order_status"].length,
                    itemBuilder: (context,index){
                  return Padding(
                    padding:  EdgeInsets.only(bottom:26.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("${index!=5 ? state.ordersPlaced[widget.ordersPlacedIndex]["order_status"][index]
                            :
                            state.ordersPlaced[widget.ordersPlacedIndex]["status_note"][index]
                            }",style: GoogleFonts.raleway(
                                fontSize: 17,
                                color: index!=5 ? black : blue,
                                fontWeight: FontWeight(700),
                              letterSpacing: -0.17
                            ),),

                            Container(
                                height: 22.w,
                                width: 90.w,
                                decoration: BoxDecoration(
                                    color: index==5 ? Colors.red : Color(0xFFF9F9F9),
                                    borderRadius: BorderRadius.circular(10.r)
                                ),
                                child: Center(
                                  child: Text("${state.ordersPlaced[widget.ordersPlacedIndex]["order_status_date"][index].toDate().toString().substring(0,14)}",style: GoogleFonts.raleway(
                                      fontSize: 13,
                                      fontWeight: FontWeight(500)
                                  ),),
                                ),
                            )
                          ],
                        ),

                        SizedBox(height: 6.h,),

                        index!=5 ?
                        Text(textAlign: TextAlign.justify,"${state.ordersPlaced[widget.ordersPlacedIndex]["status_note"][index]}",style: GoogleFonts.nunitoSans(
                            fontSize: 12,
                            color:  black,
                            fontWeight: FontWeight(400)
                        ),): SizedBox(),

                      ],
                    ),
                  );
                })

              ],
            ),
            ),
          ),
        ));
      }
  }
