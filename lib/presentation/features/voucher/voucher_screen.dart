import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shoppe_ecommerce_flutter/presentation/core/bloc/app_bloc/app_event.dart';

import '../../core/bloc/app_bloc/app_bloc.dart';
import '../../core/bloc/app_bloc/app_state.dart';
import '../../core/colors/app_colors.dart';
import '../../core/text_styles/app_text_styles.dart';
import '../../core/widgets/voucher_card.dart';

class VoucherScreen extends StatefulWidget {
  const VoucherScreen({super.key});

  @override
  State<VoucherScreen> createState() => _VoucherScreenState();
}

class _VoucherScreenState extends State<VoucherScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    context.read<AppBloc>().add(GetProducts());

  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppBloc,AppState>(
      builder: (context,state) {
        return Scaffold(

          appBar: AppBar(

            backgroundColor: white,
            leading: Padding(
              padding:EdgeInsets.only(left:12.w,top: 5.0),
              child: Container(
                height: 40.h,
                width: 40.w,
                padding: EdgeInsets.all(3.w),
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

            title: Text("Vouchers",style: AppTextStyles.h3,),

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

                  },
                  icon: SvgPicture.asset("assets/icons/Settings.svg"))

            ],

          ),


          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [


              Padding(
                padding: EdgeInsets.only(top: 12.w,left: 16.w),
                child: Container(
                  height: 30.h,
                  width: 162.w,
                  decoration: BoxDecoration(
                    color: Color(0xFFE5EBFC),
                    borderRadius: BorderRadius.circular(18.r)
                  ),
                  child: Center(
                    child: Text("Active Rewards",style: GoogleFonts.raleway(
                    fontSize: 15,
                    fontWeight: FontWeight(500),
                    color: blue
                              )),
                  ),
                ),
              ),



              ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: state.voucher.length,
                  itemBuilder: (context,index) {

                    final uid = FirebaseAuth.instance.currentUser!.uid;

                    final List<dynamic> usedUsers =
                        state.voucher[index]["users_ids_used_voucher"] ?? [];

                    final bool isCollected = usedUsers.contains(uid);

                    print("user Id: $uid     **************** used users:    $usedUsers         iscollected:   $isCollected");

                    return Padding(
                      padding:  EdgeInsets.only(left: 18.w,right: 18.w,top: 18.w,bottom: 16.w),
                      child: VoucherCard(index: index,isFromProfile: true,isCollected: isCollected,),
                    );
                  }
              ),
            ],
          ),
        );
      }
    );
  }
}
