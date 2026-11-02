import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shoppe_ecommerce_flutter/presentation/core/text_styles/app_text_styles.dart';
import 'package:shoppe_ecommerce_flutter/presentation/core/widgets/input_field.dart';

import '../../core/bloc/app_bloc/app_bloc.dart';
import '../../core/bloc/app_bloc/app_event.dart';
import '../../core/bloc/app_bloc/app_state.dart';
import '../../core/colors/app_colors.dart';
import '../../core/widgets/cart_items_card.dart';
import '../../core/widgets/favorate_items_card.dart';
import '../voucher_payment/voucher_payment_screen.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {


  final aC = TextEditingController();
  final tC = TextEditingController();
  final pC = TextEditingController();

  final fK = GlobalKey<FormState>();

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


  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    context.read<AppBloc>().add(LoadAddress());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppBloc,AppState>(
      builder:(context,state){

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

        return Scaffold(
        appBar: AppBar(
          backgroundColor: white,
          automaticallyImplyLeading: false,
          title: Row(
            children: [
              Text("Cart",style: AppTextStyles.h2,),
              SizedBox(width:2.w,),
              Container(
                height: 30.h,
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
        ),

        backgroundColor: white,
        body: SingleChildScrollView(
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
                      ),),

                      
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("${state.address}",style: AppTextStyles.b2),


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


                SizedBox(height: 16.w,),

                state.cart==null || state.cart.length==0 ? Center(child: SvgPicture.asset("assets/icons/Empty Cart.svg"))

                    : ListView.builder(
                  shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: state.cart.length,
                    itemBuilder: (context,index){
                      return Padding(padding: EdgeInsets.only(bottom: 12.h),
                        child: CartItemsCard(index:index),
                      );
                    }),

                SizedBox(height: 8.w,),

                Text("From Your Wishlist",style: AppTextStyles.h3,),
                SizedBox(height: 16.w,),
                ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: state.favoriteProductsIds.length,
                    itemBuilder: (context,index){
                      return Padding(padding: EdgeInsets.only(bottom: 14.h),
                        child: FavorateItemsCard(index:index),
                      );
                    }),

                SizedBox(height: 36.h,),
              ],
            ),
          ),
        ),

        floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,


        floatingActionButton: Transform.translate(
          offset: Offset(15, 0),
          child: Container(
            padding: EdgeInsets.all(8.w),
            width: 375.w,
            height: 60.h,
            decoration:  BoxDecoration(
              color: Color(0xFFF9F9F9),
            ),
            child: Center(
              child: Row(
                children: [
                  Text("Total ",style: AppTextStyles.h3.copyWith(
                    fontWeight: FontWeight(800),
                    fontSize: 20,
                    letterSpacing: -0.2
                  ),),

                  Icon(Icons.attach_money,fontWeight:FontWeight(700),),

                  Transform.translate(
                    offset: Offset(-6.w, 0),
                    child: Text("${total}",style: GoogleFonts.raleway(
                      fontWeight: FontWeight(700),
                      fontSize: 18
                    ),),
                  ),

                  Spacer(),

                  GestureDetector(
                    onTap: (){
                      if(total!=0 && state.address.isNotEmpty && state.cart.isNotEmpty){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>VoucherPaymentScreen()));
                      }
                    },
                    child: Container(
                      height: 40.h,
                      width: 128.w,
                      decoration: BoxDecoration(
                        color: state.cart.length==0 ? white : blue,
                        borderRadius: BorderRadius.circular(11.r)
                      ),
                      child: Center(
                        child: Text("Checkout",style: AppTextStyles.b1.copyWith(
                          color: state.cart.length==0 ? Colors.black : white,
                        ),),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),

      );}
    );
  }
}
