import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shoppe_ecommerce_flutter/presentation/features/voucher_payment/voucher_payment_screen.dart';
import '../../core/bloc/app_bloc/app_bloc.dart';
import '../bloc/app_bloc/app_event.dart';
import '../bloc/app_bloc/app_state.dart';
import '../colors/app_colors.dart';
import '../text_styles/app_text_styles.dart';

class VoucherCard extends StatelessWidget {
  int index;
  bool isFromProfile,isCollected;
  VoucherCard({super.key,required this.index,this.isFromProfile=false,this.isCollected=false});

  @override
  Widget build(BuildContext context) {

    return BlocBuilder<AppBloc,AppState>(
      builder:(context,state){


        final String buttonText = isFromProfile
            ? (isCollected ? "Collected" : "Collect")
            : "Apply";


          return Stack(
        clipBehavior: Clip.hardEdge,
        children: [

          SvgPicture.asset("assets/icons/Subtraction.svg",width: 356.w,height: 100.w,),

          Padding(
            padding: EdgeInsets.only(left:18,top: 45.h),
            child: SvgPicture.asset("assets/icons/Line.svg",),
          ),

          Container(
            height: 100.w,
            width: 336.w,
            padding: EdgeInsets.only(left: 16.w,right: 16.w,top: 8.w,bottom: 8.w),
            decoration: BoxDecoration(
              color: Colors.transparent
            ),
            clipBehavior: Clip.hardEdge,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Voucher",style: AppTextStyles.h3.copyWith(color: blue),),

                          Container(
                            height: 19.h,
                              width: 130.w,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4.r),
                                color: Color(0xFFFFEBEB)
                              ),
                              child: Center(child: Text("Valid until ${state.voucher[index]["exp_date"].toDate().toString().substring(0, 10)}",style: GoogleFonts.raleway(
                                fontWeight: FontWeight(500),
                                fontSize: 11,
                                color: black
                              ),)))
                        ],
                      ),


                Padding(
                  padding:  EdgeInsets.only(left: 8.w,top: 12.w),
                  child: Row(
                    children: [

                      SvgPicture.asset("assets/icons/Icon (1).svg"),

                      Text("${state.voucher[index]["name"]}",style: AppTextStyles.h3.copyWith(
                        fontWeight: FontWeight(700),
                        fontSize: 17
                      ),),

                    ],
                  ),
                ),

                Padding(
                  padding: EdgeInsets.only(left: 8.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [

                      Text("${state.voucher[index]["description"]}",style: AppTextStyles.b2,),

                      SizedBox(
                        width: 100.w,
                        height: 26.h,
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: blue,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(6.r)
                              )
                            ),
                            onPressed: (){

                              if(isFromProfile!=true) {
                                if (state
                                    .voucher[index]["users_ids_used_voucher"]
                                    .contains(
                                    FirebaseAuth.instance.currentUser!.uid)) {
                                  Navigator.pop(context);
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(content: Text(
                                          "You already used this voucher!!",
                                          style: AppTextStyles.b1),
                                        backgroundColor: Colors.transparent,));
                                }
                                else if (
                                state.voucher[index]["exp_date"]
                                    .toDate()
                                    .isBefore(DateTime.now())
                                ) {
                                  Navigator.pop(context);
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        "Voucher is now expired!!",
                                        style: AppTextStyles.b1,
                                      ),
                                    ),
                                  );
                                }
                                else {
                                  context.read<AppBloc>().add(
                                      StoreVoucherInApp(voucherIndex: index));
                                  Navigator.pop(context);
                                }
                              }

                        }, child: Center(
                          child: Text(
                          buttonText,
                          style: AppTextStyles.b2.copyWith(color: white),
                        ),
                      ),
                      ),

                      )],
                  ),
                )

              ],
            ),
          )

        ],
      );},
    );
  }
}
