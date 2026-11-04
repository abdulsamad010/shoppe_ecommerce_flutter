import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shoppe_ecommerce_flutter/presentation/core/text_styles/app_text_styles.dart';
import 'package:shoppe_ecommerce_flutter/presentation/features/bottom_navigation_bar/bottom_navigation_bar_screen.dart';
import 'package:shoppe_ecommerce_flutter/presentation/features/profile/bloc/profile_bloc.dart';
import 'package:shoppe_ecommerce_flutter/presentation/features/settings/settings_screen.dart';
import 'package:shoppe_ecommerce_flutter/presentation/features/to_receive/to_receive_screen.dart';
import 'package:shoppe_ecommerce_flutter/presentation/features/voucher/voucher_screen.dart';
import 'package:shoppe_ecommerce_flutter/presentation/features/voucher_payment/voucher_payment_screen.dart';

import '../../../data/repositories/food_repository_impl.dart';
import '../../../domain/usecases/get_foods.dart';
import '../../core/bloc/app_bloc/app_bloc.dart';
import '../../core/bloc/app_bloc/app_event.dart';
import '../../core/bloc/app_bloc/app_state.dart';
import '../../core/colors/app_colors.dart';
import '../../core/widgets/category_card.dart';
import '../../core/widgets/flash_sales_card.dart';
import '../../core/widgets/just_for_you_card.dart';
import '../../core/widgets/new_items_card.dart';
import '../../core/widgets/top_products_card.dart';
import '../cart/cart_screen.dart';
import '../product_details/product_details_screen.dart';
import '../see_all/all_categories_screen.dart';
import '../see_all/flase_sales.dart';
import '../see_all/new_items.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

  final getFoodsObject=GetFoods(repository: FoodRepositoryImpl());
  int indexOfEmail=-1;
  final List<String> buttonsNames=[
    "To Pay",
    "To Recieve",
    "To Review"
  ];
  String name="";
  int isToRecieveIndex=-1;
  List<int> unusedVoucherIndexes=[];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    context.read<AppBloc>().add(LoadOrdersAndProfileImage());

    indexOfEmail=FirebaseAuth.instance.currentUser!.email!.toString().indexOf("@");
    name=FirebaseAuth.instance.currentUser!.email.toString().substring(0,indexOfEmail);


    for(int i=0;i<context.read<AppBloc>().state.voucher.length;i++){
      bool isContains=false;
      for(int j=0;j<context.read<AppBloc>().state.voucher[i]["users_ids_used_voucher"].length;j++){
      if(context.read<AppBloc>().state.voucher[i][j]==FirebaseAuth.instance.currentUser!.uid){
        isContains=true;
      }
      }
      if(isContains!=true){
        unusedVoucherIndexes.add(i);
      }
    }

    isToRecieveIndex=context.read<AppBloc>().state.ordersPlaced.indexWhere((element) => element["order_status"] != "Delivered",);

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

            title: Container(
              height: 35.h,
              width: 115.w,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(
                  18.r
                ),
                color: blue,
              ),
              child: Center(
                child: Text("My Activity",
                style: GoogleFonts.raleway(
                  fontWeight: FontWeight(500),
                  color: white,
                  fontSize: 16,
                  letterSpacing: -0.16
                )),
              ),
            ),

            actionsPadding: EdgeInsets.only(right:16.w,top: 4.w),
            actions: [

              IconButton(
                  onPressed: (){

                      Navigator.push(context, MaterialPageRoute(builder: (context)=>VoucherScreen()));

                  },
                  icon: SvgPicture.asset("assets/icons/Component 7 – 3.svg")),

              SizedBox(width: 8.w,),

              IconButton(
                  onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>SettingsScreen()));
                  },
                  icon: SvgPicture.asset("assets/icons/Settings.svg"))

            ],

          ),

          backgroundColor: white,
            body: Padding(padding: EdgeInsets.only(left:16.w,right: 16.w,top: 8.w,bottom: 8.w),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Hello, ${name}!!",style: AppTextStyles.h2,),

                  SizedBox(height: 8.h,),

                  ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: state.voucher.length,
                    itemBuilder: (context,index) {
                      return

                        unusedVoucherIndexes.contains(index)?
                        Row(
                        children: [
                          Stack(
                            alignment: .topRight,
                            children:[ Container(
                              height: 60.w,
                              width: 60.w,
                              clipBehavior: Clip.hardEdge,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                    color: black.withOpacity(0.16),
                                    blurRadius: 10,
                                    offset: Offset(0, 5)
                                  )
                                ],
                                color: white,
                                border: Border.all(
                                    width: 2,
                                    color: blue)
                              ),

                              child: Center(
                                child: Icon(Icons.favorite,color: blue,size: 30.sp),
                              ),
                            ),

                              Transform.translate(
                                  offset: Offset(6, -6),
                                  child: SvgPicture.asset("assets/icons/Check (2).svg"))
                          ]),

                          SizedBox(width: 16.w,),

                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [

                              Text("You just got a reward",style: GoogleFonts.raleway(
                                fontSize: 14,
                                fontWeight: FontWeight(700),
                                letterSpacing: -0.14
                              ),),

                              Text("${state.voucher[index]["description"]}",style: GoogleFonts.nunitoSans(
                                fontSize: 11,
                                fontWeight: FontWeight(400),
                              )),
                            ],
                          )

                        ],
                      )

                      :

                      Row(
                      children: [
                      Container(
                      height: 60.w,
                      width: 60.w,
                      clipBehavior: Clip.hardEdge,
                      decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      boxShadow: [
                      BoxShadow(
                      color: black.withOpacity(0.16),
                      blurRadius: 10,
                      offset: Offset(0, 5)
                      )
                      ],
                      color: white,
                      border: Border.all(
                      width: 6,
                      color: Color(0xFFD97474))
                      ),

                      child: Center(
                      child:SvgPicture.asset("assets/icons/Group 1513.svg")    ),
                      ),

                      SizedBox(width: 16.w,),

                      Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                      Text("Your voucher will expire in ${(state.voucher[index]["exp_date"].toDate()).compareTo(DateTime.now())} days",style: GoogleFonts.raleway(
                      fontSize: 14,
                      fontWeight: FontWeight(700),
                      letterSpacing: -0.14
                      ),),

                      Text("${state.voucher[index]["description"]}",style: GoogleFonts.nunitoSans(
                      fontSize: 11,
                      fontWeight: FontWeight(400),
                      ),),
                      ],
                      )

                      ],
                      );


                    }
                  ),

                  SizedBox(height: 16.w,),

                  Text("My Orders",style: AppTextStyles.h3,),

                  SizedBox(height: 8.w,),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: List.generate(3, (index) {
                      return Stack(
                        alignment: .topRight,
                        children:[


                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xFFE5EBFC),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18.r),
                              ),
                              shadowColor: white,
                            ),
                            onPressed: (){

                              if(index==1){
                                Navigator.push(context, MaterialPageRoute(builder: (context)=>ToReceiveScreen(toRecieveOnly: true,)));
                              }
                              if(index==2){
                                Navigator.push(context, MaterialPageRoute(builder: (context)=>ToReceiveScreen(toReviewOnly: true,)));
                              }
                              if(index==0){
                                Navigator.push(context, MaterialPageRoute(builder: (context)=>BottomNavigationBarScreen()));
                                context.read<AppBloc>().add(ScreensNavigation(index: 3));
                              }

                            }, child: Text("${buttonsNames[index]}",style: GoogleFonts.raleway(
                          fontWeight: FontWeight(500),
                          fontSize: 16,
                          letterSpacing: -0.16,
                          color: blue
                        ),)),

                          index==1 && isToRecieveIndex!=-1 ?
                          Container(
                            decoration: BoxDecoration(
                                color: Colors.green,
                                shape: BoxShape.circle
                            ),
                            height: 14.w,
                            width: 14.w,
                          ) : SizedBox(),


                        ]);
                    },)
                  ),




                  SizedBox(height: 26.h,),

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
                        itemCount: state.newArrivalProducts.length>3 ? 3 : state.categories.length,
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






                  Row(
                    children: [
                      Text("Categories",style: AppTextStyles.h3,),

                      Spacer(),

                      Text("See All",style: AppTextStyles.h3.copyWith(
                          fontSize: 15
                      ),),

                      SizedBox(width: 8.w,),

                      GestureDetector(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>AllCategoriesScreen()));
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

                  GridView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount:state.categories.length>2 ? 2 : state.categories.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          mainAxisSpacing: 8.h,
                          crossAxisSpacing: 6.w,
                          childAspectRatio: 1.01,
                          crossAxisCount: 2),
                      itemBuilder: (context,index){

                        return GestureDetector(
                            onTap: (){
                              context.read<AppBloc>().add(
                                  SearchProducts(searchText: state.categories[index]["name"]));
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>BottomNavigationBarScreen()));
                              context.read<AppBloc>().add(ScreensNavigation(index: 0));
                            },
                            child: CategoryCard(categories: state.categories,index:index));

                      }),




                  SizedBox(height: 32.h,),

                  Row(
                    children: [
                      Text("Flash Sales",style: AppTextStyles.h3,),

                      Spacer(),

                      Icon(Icons.timer_sharp,color: blue,
                      ),


                      SizedBox(width: 8.w,),

                      GestureDetector(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>FlashSales()));
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
                    height: 115.h,
                    width: 335.w,
                    child: Padding(
                      padding: EdgeInsets.only(left: 3,right:3.w,bottom: 16.w),
                      child: GridView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisSpacing: 5.w,
                              childAspectRatio: 1,
                              mainAxisSpacing: 0,
                              crossAxisCount: 4),
                          itemCount: state.fleshSalesProducts.length>4 ? 4 : state.categories.length,
                          itemBuilder: (context,index){
                            return Padding(
                                padding: EdgeInsets.only(left: 3,right:3.w,),
                                child: GestureDetector(
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
                                    child: FlashSalesCard(image: "${state.fleshSalesProducts[index].imageUrl}",discount:state.fleshSalesProducts[index].discountPercentage))
                            );
                          }),
                    ),
                  ),




                  SizedBox(height: 12.h,),

                  Text("Top Products",style: AppTextStyles.h3,),


                  SizedBox(
                    height: 109.h,
                    width: 335.w,
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: state.topSoldProducts.length,
                        itemBuilder: (context,index){
                          return Padding(
                            padding: EdgeInsets.only(right:8.w),
                            child: GestureDetector(
                                onTap: (){

                                  int topIndex=state.products.indexWhere((item) {
                                    return item.id == state.topSoldProducts[index].id;
                                  });

                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ProductDetailsScreen(
                                          productId: state.products[topIndex].id
                                      ),
                                    ),
                                  );

                                },
                                child: TopProductsCard(image: "${state.topSoldProducts[index].imageUrl}")),
                          );
                        }),
                  ),




                  SizedBox(height: 32.h,),

                  Row(
                    children: [
                      Text("Just For You",style: AppTextStyles.h3,),

                      Icon(Icons.star,color: blue,
                        size: 20.sp,
                      ),
                    ],
                  ),

                  SizedBox(height: 8.h,),


                  GridView.builder(
                      itemCount: state.products.length,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,
                          childAspectRatio: 0.8,
                          mainAxisSpacing: 1.w,
                          crossAxisSpacing: 0.w
                      ),
                      itemBuilder: (context,index){
                        return Padding(
                            padding: EdgeInsets.only(left: 3,right:3.w),
                            child: GestureDetector(
                                onTap: (){
                                  Navigator.push(context, MaterialPageRoute(builder: (context)=>ProductDetailsScreen(productId:state.products[index].id)));
                                },
                                child: JustForYouCard(image: "${state.products[index].imageUrl}", text: "${state.products[index].name}", price: state.products[index].price))
                        );
                      }),




                ],
              ),
            ),
            ),
        );
      }
    );
  }
}
