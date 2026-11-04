import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shoppe_ecommerce_flutter/presentation/core/bloc/app_bloc/app_event.dart';
import 'package:shoppe_ecommerce_flutter/presentation/core/bloc/app_bloc/app_state.dart';
import 'package:shoppe_ecommerce_flutter/presentation/core/text_styles/app_text_styles.dart';
import 'package:shoppe_ecommerce_flutter/presentation/core/widgets/category_card.dart';
import 'package:shoppe_ecommerce_flutter/presentation/core/widgets/flash_sales_card.dart';
import 'package:shoppe_ecommerce_flutter/presentation/core/widgets/new_items_card.dart';
import 'package:shoppe_ecommerce_flutter/presentation/core/widgets/top_products_card.dart';
import 'package:shoppe_ecommerce_flutter/presentation/features/product_details/product_details_screen.dart';
import 'package:shoppe_ecommerce_flutter/presentation/features/search/search_screen.dart';

import '../../core/bloc/app_bloc/app_bloc.dart';
import '../../core/colors/app_colors.dart';
import '../../core/widgets/just_for_you_card.dart';
import '../categories_filtering/category_filtering_screen.dart';
import '../see_all/all_categories_screen.dart';
import '../see_all/flase_sales.dart';
import '../see_all/new_items.dart';

class ShopScreen extends StatefulWidget {
  const ShopScreen({super.key});

  @override
  State<ShopScreen> createState() => _ShopScreenState();
}

class _ShopScreenState extends State<ShopScreen> {

  @override
  void initState() {
    super.initState();
    context.read<AppBloc>().add(GetProducts());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppBloc,AppState>(

      builder:(context,state){

        return Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: white,
            title: Padding(
              padding: EdgeInsets.only(left:6.w),
              child: Text("Shop",style: AppTextStyles.h2,),
            ),
            actionsPadding: EdgeInsets.only(right: 16.w),
            actions: [
              GestureDetector(


                onTap: (){
                  if(state.searchedProducts.isNotEmpty) {
                    context.read<AppBloc>().add(ClearSearch());
                  }
                  else{
                    context.read<AppBloc>().add(LoadSearchHistory());
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => SearchScreen()));
                  }
                },
                child: Container(
                  padding: EdgeInsets.only(left: 16.w,right: 16.w),
                  height: 36.h,
                  width: 248.w,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(18.r),
                    color: lightGrey,
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      state.searchedProducts.isEmpty ?
                      Text("Search",style: GoogleFonts.raleway(
                        fontSize: 16.sp,
                        color: grey,
                        letterSpacing: -0.16,
                        fontWeight: FontWeight(500),
                      )) :
                      Row(
                        children: [
                          Text(state.lastSearch,style: TextStyle(color: blue),),
                          SizedBox(width: 8.w,),
                          SvgPicture.asset("assets/icons/Close Icon.svg"),
                        ],
                      ),

                      Spacer(),

                      Icon(Icons.search,color: blue,)
                    ],
                  ),
                ),
              ),

              GestureDetector(
                onTap: (){

                  state.filteredProducts.isEmpty && state.filters.isEmpty ?
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>CategoriesFilteringScreen()))
                      :
                  context.read<AppBloc>().add(ClearFilter());
                },
                child: state.filteredProducts.isEmpty && state.filters.isEmpty? SvgPicture.asset("assets/icons/Filter Icon.svg")
                    :
                Icon(Icons.clear,color: Colors.red,),
              )
            ],
          ),



          backgroundColor: white,
          body:
          state.filters.isNotEmpty ?


          state.filteredProducts.isNotEmpty?
          Padding(
            padding:  EdgeInsets.only(left:17.w,right: 17.w,top: 8.w,bottom: 8.w),
            child: GridView.builder(
                itemCount: state.filteredProducts.length,
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
                          child: JustForYouCard(image: "${state.filteredProducts[index].imageUrl}", text: "${state.filteredProducts[index].name}", price: state.filteredProducts[index].price))
                  );
                }),
          ) : Center(child: Text("No product found!!",style: AppTextStyles.h3,),)

              :
          state.searchedProducts.isEmpty ?

          SingleChildScrollView(
            child:Padding(
              padding:  EdgeInsets.only(left:17.w,right: 17.w,top: 8.w,bottom: 8.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  Center(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>FlashSales()));
                      },
                      child: SizedBox(
                        width: 335.w,
                        height: 200.h,
                        child: PageView.builder(
                          itemCount: 2,
                          itemBuilder: (context,index) {
                            return Column(
                              children: [
                                Padding(
                                  padding: EdgeInsets.all(2.w),
                                  child: Container(
                                    width: 335.w,
                                    height: 150.h,
                                    clipBehavior: Clip.hardEdge,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(9.r),
                                        color:index==1? Color(0xFFF1B11c).withOpacity(0.92):Color(0xFFF1B11C).withOpacity(0.85)
                                    ),
                                    child: Stack(
                                        children:[


                                          Align(
                                            alignment: .centerRight,
                                            child: Padding(
                                              padding: EdgeInsets.only(right: index!=1 ?32.w : 55.w),
                                              child:index==1?
                                              Image.asset("assets/images/img_1.png",):
                                              Image.asset("assets/images/img.png",),
                                            ),
                                          ),

                                          Align(
                                              alignment: .bottomRight,
                                              child: SvgPicture.asset("assets/icons/bubble 02 (2).svg",)) ,

                                          Align(
                                              alignment: .bottomRight,
                                              child: SvgPicture.asset("assets/icons/bubble 01 (8).svg",color: index==1? blue:Color(0xFFFFD471),)),

                                          Align(
                                              alignment: .bottomLeft,
                                              child: SvgPicture.asset("assets/icons/bubble 01 (7).svg",color: index==1? blue:Color(0xFFFFD471),)),


                                          Padding(
                                            padding: EdgeInsets.only(top:8.w,bottom: 4.w,left: 16.w,right: 16.w),
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text("Big Sale",style: AppTextStyles.h2.copyWith(
                                                    color: index==1? black:white
                                                ),),
                                                Text("Up to ${state.flashSale["discountPercentage"]}%",style: GoogleFonts.nunitoSans(
                                                  fontWeight: FontWeight(700),
                                                  fontSize: 12.sp,
                                                  color: index==1? black:white,
                                                ),),
                                                Spacer(),
                                                Text("Happening\nNow",style: GoogleFonts.raleway(
                                                  fontWeight: FontWeight(700),
                                                  fontSize: 11.sp,
                                                  letterSpacing: -0.11,
                                                  color: white,
                                                ),),
                                              ],
                                            ),
                                          )
                                        ]
                                    ),
                                  ),
                                ),



                                SizedBox(height: 12.h,),


                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [



                                    SizedBox(width: 4.w,),

                                    Row(children: List.generate(2,
                                          (i) {
                                        return Padding(
                                          padding: EdgeInsets.only(right: 4.w),
                                          child:

                                              index==i?
                                              Container(
                                                width: 40.w,
                                                height: 10.h,
                                                decoration: BoxDecoration(
                                                    color: blue,
                                                    borderRadius: BorderRadius.circular(5.r)
                                                ),
                                              )
                                              :
                                          Container(
                                            width: 10.w,
                                            height: 10.h,
                                            decoration: BoxDecoration(
                                                color:  Color(0xFFC7D6FB),
                                                shape: BoxShape.circle
                                            ),
                                          ),
                                        );
                                      },
                                    ))

                                  ],
                                ),


                              ],
                            );
                          }
                        ),
                      ),
                    ),
                  ),







                  SizedBox(height: 0.h,),


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
                            },
                            child: CategoryCard(categories: state.categories,index:index));

                      }),


                  SizedBox(height: 32.h,),

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
                        itemCount: state.newArrivalProducts.length>3 ? 3 : state.newArrivalProducts.length,
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
                      Text("Flash Sales",style: AppTextStyles.h3,),

                      Spacer(),

                      Icon(Icons.timer_sharp,color: blue,
                      ),


                      SizedBox(width: 8.w,),


                      Row(
                        children: [
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
                          itemCount: state.fleshSalesProducts.length>4 ? 4 : state.fleshSalesProducts.length,
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



                  SizedBox(height: 6.h,),

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
          )

              : SingleChildScrollView(
            child: Padding(
              padding:  EdgeInsets.only(left:17.w,right: 17.w,top: 8.w,bottom: 8.w),
              child: Column(
                crossAxisAlignment: .start,
                children: [

                  SizedBox(height: 16.h,),

                  Text("All Items",style: AppTextStyles.h3,),

                  SizedBox(height: 16.h,),

                  GridView.builder(
                      itemCount: state.searchedProducts.length,
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
                                  Navigator.push(context, MaterialPageRoute(builder: (context)=>ProductDetailsScreen(productId: state.searchedProducts[index].id)));
                                },
                                child: JustForYouCard(image: "${state.searchedProducts[index].imageUrl}", text: "${state.searchedProducts[index].name}", price: state.searchedProducts[index].price))
                        );
                      }),


                ],
              ),
            ),
          )
          ,


        );
      },
    );
  }
}
