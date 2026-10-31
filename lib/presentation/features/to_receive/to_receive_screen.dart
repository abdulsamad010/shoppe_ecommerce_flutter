import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shoppe_ecommerce_flutter/presentation/core/bloc/app_bloc/app_state.dart';
import 'package:shoppe_ecommerce_flutter/presentation/core/text_styles/app_text_styles.dart';
import 'package:shoppe_ecommerce_flutter/presentation/core/widgets/to_recieve_card.dart';

import '../../core/bloc/app_bloc/app_bloc.dart';
import '../../core/bloc/app_bloc/app_event.dart';
import '../../core/colors/app_colors.dart';

class ToReceiveScreen extends StatefulWidget {
  bool toRecieveOnly;
  bool toReviewOnly;
  ToReceiveScreen({super.key,this.toRecieveOnly=false,this.toReviewOnly=false});

  @override
  State<ToReceiveScreen> createState() => _ToReceiveScreenState();
}

class _ToReceiveScreenState extends State<ToReceiveScreen> {

  List<int> toRecieveIndexes=[],toReviewIndexes=[];


  @override
  void initState() {
    super.initState();
    context.read<AppBloc>().add(LoadOrdersAndProfileImage());

    if(widget.toRecieveOnly==true){
      for(int i=0;i<context.read<AppBloc>().state.ordersPlaced.length;i++){
        if(context.read<AppBloc>().state.ordersPlaced[i]["order_status"].last!="Delivered"){
          toRecieveIndexes.add(i);
        }
      }
    }
    else{
      for(int i=0;i<context.read<AppBloc>().state.ordersPlaced.length;i++){
        if(context.read<AppBloc>().state.ordersPlaced[i]["order_status"].last=="Delivered"){
          toReviewIndexes.add(i);
        }
      }
    }
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
                  child: Image.network("${state.profileImage}",fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => SizedBox(),
                  )),
            ),
          ),
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              Text("To Recieve",style: AppTextStyles.h3,),

              SizedBox(height: 6.h,),

              Text("My Orders",style: GoogleFonts.raleway(
                fontWeight: FontWeight(500),
                fontSize: 14
              ),),

            ],
          ),
        ),

        backgroundColor: white,

        body: Padding(
          padding: EdgeInsets.only(left:16.w,right: 16.w,top: 22.w,bottom: 16.w),
          child: ListView.builder(
            itemCount: widget.toRecieveOnly
                ? toRecieveIndexes.length
                : widget.toReviewOnly
                ? toReviewIndexes.length
                : state.ordersPlaced.length,

            itemBuilder: (context, index) {
              int orderIndex;

              if (widget.toRecieveOnly) {
                orderIndex = toRecieveIndexes[index];
              } else if (widget.toReviewOnly) {
                orderIndex = toReviewIndexes[index];
              } else {
                orderIndex = index;
              }

              return Padding(
                padding: EdgeInsets.only(bottom: 8.w),
                child: ToRecieveCard(index: orderIndex),
              );
            },
          ),
        ),
      ),
    );
  }
}

