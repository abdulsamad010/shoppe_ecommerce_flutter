import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shoppe_ecommerce_flutter/presentation/core/bloc/app_bloc/app_state.dart';
import 'package:shoppe_ecommerce_flutter/presentation/core/widgets/voucher_card.dart';
import 'package:shoppe_ecommerce_flutter/presentation/features/bottom_navigation_bar/bottom_navigation_bar_screen.dart';
import 'package:shoppe_ecommerce_flutter/presentation/features/to_receive/to_receive_screen.dart';

import '../../core/bloc/app_bloc/app_bloc.dart';
import '../../core/bloc/app_bloc/app_event.dart';
import '../../core/colors/app_colors.dart';
import '../../core/text_styles/app_text_styles.dart';
import '../../core/widgets/input_field.dart';
import '../../core/widgets/payment_items_card.dart';

class VoucherPaymentScreen extends StatefulWidget {
  const VoucherPaymentScreen({super.key});

  @override
  State<VoucherPaymentScreen> createState() => _VoucherPaymentScreenState();
}

class _VoucherPaymentScreenState extends State<VoucherPaymentScreen> {


  final aC = TextEditingController();
  final tC = TextEditingController();
  final pC = TextEditingController();

  final fK = GlobalKey<FormState>();

  final pGK = GlobalKey<FormState>();

  String? aV(String? v) {
    if (v != null && v.trim().length >= 6) {
      return null;
    }
    return "Address must be at least 6 characters";
  }

  String? tV(String? v) {
    if (v != null && v.trim().length >= 2) {
      return null;
    }
    return "Enter a valid town or city";
  }

  String? pV(String? v) {
    if (v != null && RegExp(r'^\d{5}$').hasMatch(v.trim())) {
      return null;
    }
    return "Enter a valid 5-digit postcode";
  }

  final phC = TextEditingController();

  String? phV(String? v) {
    if (v != null &&
        RegExp(r'^\+?[0-9]{10,15}$').hasMatch(v.trim())) {
      return null;
    }
    return "Enter a valid phone number";
  }

  bool isShowed=false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    context.read<AppBloc>().add(LoadAddress());
    context.read<AppBloc>().add(LoadContact());
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppBloc,AppState>(
      listener: (context, state) {


        if(state.cart.isEmpty && isShowed==false){

          showDialog(
              barrierDismissible: false,
              context: context, builder: (context){
            return AlertDialog(
              clipBehavior: Clip.none,
              backgroundColor: white,
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
                          child: Center(child: SvgPicture.asset("assets/icons/Component 5 – 2.svg",height: 50.w,width: 50.w,))),

                      Transform.translate(
                        offset: Offset(0, 15),
                        child: Column(
                          children: [

                            Text("Done!",style: GoogleFonts.raleway(
                              fontSize: 19,
                              fontWeight: FontWeight(700),
                            ),),

                            SizedBox(height: 8.h,width: 347.w,),

                            Text("Your order is placed successfully",style: GoogleFonts.nunitoSans(
                              fontSize: 13,
                              fontWeight: FontWeight(600),
                            ),),




                          ],
                        ),
                      ),

                      Transform.translate(
                        offset: Offset(0, 22),
                        child: SizedBox(
                          width: 163.w,
                          height: 40.h,
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(backgroundColor: Color(0xFFE7E8EB),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(11.r)
                                  )
                              ),
                              onPressed: (){

                                print("done");
                                context.read<AppBloc>().add(ScreensNavigation(index: 2));
                                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>BottomNavigationBarScreen()));
                                isShowed=true;

                              }, child: Text("Track My Order",style: AppTextStyles.b2,)),
                        ),
                      )


                    ],
                  ),
                ),
              ),
            );
          });
        }



        if(state.isProceed){

          showDialog(context: context, builder: (context) {
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

      },

      builder:(context, state) {
        double total = 0;

        for (int i = 0; i < state.cart.length; i++) {
          int index = state.products.indexWhere((item) {
            return item.id == state.cart[i]["productId"];
          });

          if (index != -1) {
            total += state.products[index].price *
                (state.cart[i]["quantity"] as num).toDouble();
          }
        }

        total=total+state.delivery_methods[state.selectedDeliveryIndex]["charges"];

        if(state.voucherUsedIndex!=null) {
          total -= total * ((state.voucher[state.voucherUsedIndex!]["discount_percentage"] as num).toDouble() / 100);
        }


        return Scaffold(
          appBar: AppBar(
            backgroundColor: white,
            automaticallyImplyLeading: false,
            title: Text("Payment",style: AppTextStyles.h2,),
          ),

          backgroundColor: white,
          body:SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(16.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  Container(
                    padding: EdgeInsets.all(12.w),
                    height: 70.w,
                    width: 335.w,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.r),
                        color: Color(0xFFF9F9F9)
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        Text("Shipping Address",style: GoogleFonts.raleway(
                          fontSize: 14,
                          fontWeight: FontWeight(700),
                          letterSpacing: -0.14
                        ),),



                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("${state.address}",style: AppTextStyles.b2.copyWith(
                              fontSize: 10,
                              fontWeight: FontWeight(400),
                            )),


                            GestureDetector(
                              onTap: () {
                                showModalBottomSheet(
                                  context: context,
                                  isScrollControlled: true,
                                  backgroundColor: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.vertical(
                                      top: Radius.circular(16.r),
                                    ),
                                  ),
                                  builder: (context) {
                                    return Padding(
                                      padding: EdgeInsets.only(
                                        bottom: MediaQuery.of(context).viewInsets.bottom,
                                      ),
                                      child: Form(
                                        key: fK,
                                        child: SingleChildScrollView(
                                          child: Padding(
                                            padding: EdgeInsets.all(16.w),
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "Shipping Address",
                                                  style: AppTextStyles.h3,
                                                ),
                                                SizedBox(height: 20.h),
                                                Text("Country", style: AppTextStyles.b2),
                                                SizedBox(height: 6.h),
                                                Container(
                                                  width: double.infinity,
                                                  padding: EdgeInsets.all(12.w),
                                                  decoration: BoxDecoration(
                                                    color: Color(0xFFF0F2FF),
                                                    borderRadius: BorderRadius.circular(8.r),
                                                  ),
                                                  child: Text(
                                                    "Pakistan",
                                                    style: AppTextStyles.b2,
                                                  ),
                                                ),
                                                SizedBox(height: 16.h),
                                                Text("Address", style: AppTextStyles.b2),
                                                SizedBox(height: 6.h),
                                                InputField(
                                                  bColor: lightGrey,
                                                  con: aC,
                                                  hint: Text("Enter your street address"),
                                                  isAbscure: false,
                                                  isPrefix: false,
                                                  isSuffix: false,
                                                  label: Text("Address"),
                                                  preIcon: SizedBox(),
                                                  suffIcon: SizedBox(),
                                                  val: aV,
                                                ),
                                                SizedBox(height: 16.h),
                                                Text("Town / City", style: AppTextStyles.b2),
                                                SizedBox(height: 6.h),
                                                InputField(
                                                  bColor: lightGrey,
                                                  con: tC,
                                                  hint: Text("Enter your town or city"),
                                                  isAbscure: false,
                                                  isPrefix: false,
                                                  isSuffix: false,
                                                  label: Text("Town / City"),
                                                  preIcon: SizedBox(),
                                                  suffIcon: SizedBox(),
                                                  val: tV,
                                                ),
                                                SizedBox(height: 16.h),
                                                Text("Postcode", style: AppTextStyles.b2),
                                                SizedBox(height: 6.h),
                                                InputField(
                                                  bColor: lightGrey,
                                                  con: pC,
                                                  hint: Text("Enter postcode"),
                                                  isAbscure: false,
                                                  isPrefix: false,
                                                  isSuffix: false,
                                                  label: Text("Postcode"),
                                                  preIcon: SizedBox(),
                                                  suffIcon: SizedBox(),
                                                  val: pV,
                                                ),
                                                SizedBox(height: 20.h),
                                                SizedBox(
                                                  width: double.infinity,
                                                  height: 48.h,
                                                  child: ElevatedButton(
                                                    style: ElevatedButton.styleFrom(
                                                      backgroundColor: blue,
                                                      foregroundColor: Colors.white,
                                                      elevation: 0,
                                                      shape: RoundedRectangleBorder(
                                                        borderRadius: BorderRadius.circular(10.r),
                                                      ),
                                                    ),
                                                    onPressed: () {
                                                      if (fK.currentState!.validate()) {
                                                        String address =
                                                            "${aC.text.trim()}, "
                                                            "${tC.text.trim()}, "
                                                            "${pC.text.trim()}, Pakistan";

                                                        context.read<AppBloc>().add(
                                                          EditAddress(
                                                            value: address,
                                                            purpose: "address",
                                                          ),
                                                        );

                                                        Navigator.pop(context);
                                                      }
                                                    },
                                                    child: Text("Save Changes"),
                                                  ),
                                                ),
                                                SizedBox(height: 12.h),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                );
                              },
                              child: SvgPicture.asset("assets/icons/Button.svg"),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),



                  SizedBox(height: 4.w,),



                  Container(
                    padding: EdgeInsets.all(12.w),
                    height: 70.w,
                    width: 335.w,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.r),
                        color: Color(0xFFF9F9F9)
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        Text("Contact Information",style: GoogleFonts.raleway(
                          fontSize: 14,
                          fontWeight: FontWeight(700),

                        ),),


                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("${state.contact}",style: AppTextStyles.b2.copyWith(
                                  fontSize: 10,
                                  fontWeight: FontWeight(400),
                                )),


                                Text("${state.email}",style: AppTextStyles.b2.copyWith(
                                  fontSize: 10,
                                  fontWeight: FontWeight(400),
                                )),

                              ],
                            ),


                            GestureDetector(
                              onTap: () {
                                showModalBottomSheet(
                                  context: context,
                                  useSafeArea: true,
                                  isScrollControlled: true,
                                  builder: (context) {
                                    return Padding(
                                      padding: EdgeInsets.only(
                                        bottom: MediaQuery.of(context).viewInsets.bottom,
                                      ), child: Form(
                                        key: pGK,
                                        child: Padding(
                                          padding: EdgeInsets.all(16.w),
                                          child: SingleChildScrollView(
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "Contact Information",
                                                  style: AppTextStyles.h3,
                                                ),
                                                SizedBox(height: 20.h),
                                                Text(
                                                  "Phone Number",
                                                  style: AppTextStyles.b2,
                                                ),
                                                SizedBox(height: 6.h),
                                                InputField(
                                                  bColor: lightGrey,
                                                  con: phC,
                                                  hint: Text("Enter phone number"),
                                                  isAbscure: false,
                                                  isPrefix: false,
                                                  isSuffix: false,
                                                  label: Text("Phone Number"),
                                                  preIcon: SizedBox(),
                                                  suffIcon: SizedBox(),
                                                  val: phV,
                                                ),
                                                SizedBox(height: 20.h),
                                                SizedBox(
                                                  width: double.infinity,
                                                  height: 48.h,
                                                  child: ElevatedButton(
                                                    style: ElevatedButton.styleFrom(
                                                      backgroundColor: blue,
                                                      foregroundColor: Colors.white,
                                                    ),
                                                    onPressed: () {
                                                      if (pGK.currentState!.validate()) {
                                                        String contact =
                                                            "${phC.text.trim()}";

                                                        context.read<AppBloc>().add(
                                                          EditAddress(
                                                            value: contact,
                                                            purpose: "contact",
                                                          ),
                                                        );

                                                        Navigator.pop(context);
                                                      }
                                                    },
                                                    child: Text("Save Changes"),
                                                  ),
                                                ),
                                                SizedBox(height: 12.h),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                );
                              },
                              child: SvgPicture.asset("assets/icons/Button.svg"),
                            )

                          ],
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 16.h,),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Text("Items",style: AppTextStyles.h3,),
                          SizedBox(width:2.w,),
                          Container(
                            height: 30.w,
                            width: 30.w,
                            clipBehavior: Clip.hardEdge,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Color(0xFFE5EBFC)
                            ),
                            child: Center(child: Text("${state.cart.length}",style: AppTextStyles.h3,)),
                          ),
                        ],
                      ),

                      SizedBox(
                        height: 30.w,
                      width: 120.w,
                      child: ElevatedButton(onPressed: (){
                        showModalBottomSheet(context: context,
                            backgroundColor: white,
                            builder: (context) {
                              return Column(
                                children: [

                                  Container(
                                    height: 80.w,
                                    width: 375.w,
                                    padding: EdgeInsets.all(26.w),
                                    decoration: BoxDecoration(
                                      color: Color(0xFFF8FAFF),
                                      borderRadius: BorderRadius.only(topLeft: Radius.circular(9.r),topRight: Radius.circular(9.r)),
                                    ),
                                    child: Text("Active Vouchers",style: AppTextStyles.h3,),
                                  ),



                                  ListView.builder(
                                    physics: NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    itemCount: state.voucher.length,
                                    itemBuilder: (context,index) {
                                      return Padding(
                                        padding:  EdgeInsets.only(left: 18.w,right: 18.w,top: 18.w,bottom: 16.w),
                                        child: VoucherCard(index: index),
                                      );
                                    }
                                  ),
                                ],
                              );
                            },);
                      },
                            style:ElevatedButton.styleFrom(
                              padding: EdgeInsets.all(0),
                              backgroundColor:state.voucherUsedIndex==null ? white: blue,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.r),
                              side: BorderSide(color: blue))
                            ),
                            child: state.voucherUsedIndex==null ?
                            Center(child: Text("Add Voucher",style: AppTextStyles.b2,))

                      : Center(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("${state.voucher[state.voucherUsedIndex!]["discount_percentage"]}% Discount",style: AppTextStyles.b2.copyWith(fontSize: 12,
                            fontWeight: FontWeight(400),
                              color: white
                            ),),
                            IconButton(onPressed: (){
                              context.read<AppBloc>().add(RemoveVoucherInApp());
                            }, icon: Icon(Icons.clear,color: white,))
                          ],
                        ),
                      ) ,),
                      ),
                      
                    ],
                  ),

                  SizedBox(height: 12.w,),



                  ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: state.cart.length,
                      itemBuilder: (context,index){
                        return Padding(padding: EdgeInsets.only(bottom: 8.h),
                          child: PaymentItemsCard(index:index),
                        );
                      }),




                  SizedBox(height: 16.w,),

                  Text("Shipping Options",style: AppTextStyles.h3,),

                  SizedBox(height: 8.h,),

                  ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: state.delivery_methods.length,
                    itemBuilder: (context,index){
                      return Padding(
                        padding: EdgeInsets.only(bottom: 8.0),
                        child: GestureDetector(
                          onTap: (){
                            context.read<AppBloc>().add(ChangeDeliveryIndex(index: index));
                          },
                          child: Container(
                            padding: EdgeInsets.only(bottom: 4.w),
                            width: 335.w,
                            height: 40.h,
                            decoration: BoxDecoration(
                              color: state.selectedDeliveryIndex==index? Color(0xFFE5EBFC) : Color(0xFFF9F9F9),
                                borderRadius: BorderRadius.circular(10.r),
                            ),
                            child: Row(
                              children: [
                                SizedBox(width: 4.w,),

                                state.selectedDeliveryIndex==index?
                                    SvgPicture.asset("assets/icons/Group 1196 (1).svg")
                                : SvgPicture.asset("assets/icons/Check Empty.svg"),

                                SizedBox(width: 6.w,),

                                Text("${state.delivery_methods[index]["name"]}",style: GoogleFonts.raleway(
                                  fontSize: 16,
                                  letterSpacing: -0.16,
                                  fontWeight: FontWeight(600),
                                ),),

                                SizedBox(width: 8.w,),

                                Container(
                                  height: 26.h,
                                  width: 72.w,
                                  decoration: BoxDecoration(
                                      color: Color(0xFFF5F8FF),
                                      borderRadius: BorderRadius.circular(5.r)
                                  ),
                                  child: Center(
                                    child: Text("${state.delivery_methods[index]["days"]}",style:GoogleFonts.raleway(
                                        fontSize: 13,
                                        fontWeight: FontWeight(500),
                                        color: blue
                                    ),),
                                  ),
                                ),

                                Spacer(),

                                Icon(Icons.attach_money,fontWeight:FontWeight(700),size: 16,),

                                Transform.translate(
                                  offset: Offset(-4.w, 0),
                                  child: Text("${state.delivery_methods[index]["charges"]}",style: GoogleFonts.raleway(
                                      fontSize: 16,
                                      fontWeight: FontWeight(700)
                                  ),),
                                ),

                                SizedBox(width: 8.w,),

                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),

                  SizedBox(height: 4.w,),


                  Text("Delivered on or before ${state.deliveryDate}"),

                  SizedBox(height: 22.w,),

                  Text("Payment Options",style: AppTextStyles.h3,),

                  SizedBox(height: 12.h,),

                  Container(
                    height: 30.w,
                    width: 73.w,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(18.r),
                      color: Color(0xFFE5EBFC)
                    ),
                    child: Center(
                      child: Text("Cash",style: GoogleFonts.raleway(
                        fontSize: 15,
                        color: blue,
                        fontWeight: FontWeight(700)
                      ),),
                    ),

                  ),

                  SizedBox(height: 70.h,)

                ],
              ),
            ),
          ),


          floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,

          floatingActionButton: Container(
            padding: EdgeInsets.all(8.w),
            width: 355.w,
            height: 60.h,
            decoration:  BoxDecoration(
              color: Color(0xFFF9F9F9),
            ),
            child: Center(
              child: Row(
                children: [
                  Text("Total ",style: AppTextStyles.h3.copyWith(
                    fontSize: 20,
                    fontWeight: FontWeight(800),
                    letterSpacing: -0.2
                  ),),

                  Icon(Icons.attach_money,fontWeight:FontWeight(700),),

                  Transform.translate(
                    offset: Offset(-6.w, 1),
                    child: Text("${total}",style: GoogleFonts.raleway(
                        fontWeight: FontWeight(700),
                        fontSize: 18,
                      letterSpacing: -0.18
                    ),),
                  ),

                  Spacer(),

                  GestureDetector(
                    onTap: (){

                      if(total!=0 && state.address.isNotEmpty && state.cart.isNotEmpty){

                        context.read<AppBloc>().add(StoreOrder(totalCost: total));

                      }
                    },
                    child: Container(
                      height: 40.h,
                      width: 128.w,
                      decoration: BoxDecoration(
                          color: black,
                          borderRadius: BorderRadius.circular(11.r)
                      ),
                      child: Center(
                        child: Text("Proceed",style: AppTextStyles.b1.copyWith(
                          fontWeight: FontWeight(300),
                          fontSize: 16,
                          color: white
                        ),),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),


      );},
    );
  }
}
