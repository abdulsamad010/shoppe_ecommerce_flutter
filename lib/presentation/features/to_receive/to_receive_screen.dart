import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shoppe_ecommerce_flutter/presentation/core/bloc/app_bloc/app_state.dart';
import 'package:shoppe_ecommerce_flutter/presentation/core/text_styles/app_text_styles.dart';
import 'package:shoppe_ecommerce_flutter/presentation/core/widgets/to_recieve_card.dart';
import 'package:shoppe_ecommerce_flutter/presentation/features/settings/settings_screen.dart';

import '../../core/bloc/app_bloc/app_bloc.dart';
import '../../core/bloc/app_bloc/app_event.dart';
import '../../core/colors/app_colors.dart';
import '../bottom_navigation_bar/bottom_navigation_bar_screen.dart';
import '../voucher/voucher_screen.dart';

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
    context.read<AppBloc>().add(GetProducts());
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


  bool isProgressShown=false;
  bool isProgressShown1=false;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppBloc,AppState>(
      listener: (context, state) {


        if(state.isProceed && isProgressShown==false){
          isProgressShown=true;
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


        if (state.isSubmitted && isProgressShown){
          isProgressShown=false;
          Navigator.of(context, rootNavigator: true).pop();
          showDialog(barrierDismissible: false,context: context, builder: (context){
            return PopScope(
              canPop: false,
              child: AlertDialog(
                backgroundColor: white,
                clipBehavior: Clip.none,
                title: Center(
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


                      Column(
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
                            offset: Offset(0, 0),
                            child: SizedBox(
                              width: 225.w,
                              height: 34.h,
                              child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(backgroundColor: blue,
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(11.r)
                                      )
                                  ),

                                  onPressed: () {
                                    context.read<AppBloc>().add(ScreensNavigation(index: 0));

                                    Navigator.of(context, rootNavigator: true).pushAndRemoveUntil(
                                      MaterialPageRoute(
                                        builder: (context) => BottomNavigationBarScreen(),
                                      ),
                                          (route) => false,
                                    );
                                  }, child: Text("Go to Home",style: AppTextStyles.b2.copyWith(color: white),)),
                            ),
                          )

                        ],
                      )


                    ],
                  ),
                ),
              ),
            );
          });

        }
      },


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

          actionsPadding: EdgeInsets.only(right:16.w,top: 4.w),
          actions: [

            IconButton(
                onPressed: (){

                  Navigator.push(context, MaterialPageRoute(builder: (context)=>VoucherScreen()));

                },
                icon: SvgPicture.asset("assets/icons/Component 7 – 3.svg")),

            //SizedBox(width: 8.w,),

            IconButton(
                onPressed: (){

                  Navigator.push(context, MaterialPageRoute(builder: (context)=>SettingsScreen()));

                },
                icon: SvgPicture.asset("assets/icons/Settings.svg"))

          ],
        ),

        backgroundColor: white,

        body:

            Center(
              child: state.ordersPlaced.isEmpty?Text("No order is placed yet!!",style: AppTextStyles.h3,) :
                      Padding(
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
      ),
    );
  }
}

