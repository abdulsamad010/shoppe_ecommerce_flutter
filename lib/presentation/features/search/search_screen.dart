import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shoppe_ecommerce_flutter/presentation/core/widgets/new_items_card.dart';
import 'package:shoppe_ecommerce_flutter/presentation/features/shop/shop_screen.dart';

import '../../core/bloc/app_bloc/app_bloc.dart';
import '../../core/bloc/app_bloc/app_event.dart';
import '../../core/bloc/app_bloc/app_state.dart';
import '../../core/colors/app_colors.dart';
import '../../core/text_styles/app_text_styles.dart';
import '../product_details/product_details_screen.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {

  final sC=TextEditingController();

  bool isSubmit=false;

  List<String> mainCategories = [
    "Clothing",
    "Shoes",
    "Bags",
    "Lingerie",
    "Watch",
    "Hoodies",
  ];

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppBloc,AppState>(
      listener: (context, state) { if(isSubmit) {
        if(state.searchedProducts.isNotEmpty) {
          sC.clear();
          Navigator.pop(context);
        isSubmit=false;
        }
        else{ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("No matching product found",style: AppTextStyles.b1),backgroundColor: Colors.transparent
          ,));
        isSubmit=false;
        }
    }},


      builder:(context,state)=> Scaffold(
        backgroundColor: white,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding:  EdgeInsets.only(left:17.w,right: 17.w,top: 8.w,bottom: 8.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  Row(
                    children: [
                      Text("Search",style: AppTextStyles.h2,),
                      SizedBox(width: 8.w,),
                      SizedBox(
                        width: 234.w,
                        height: 36.h,
                        child: TextField(
                          onSubmitted: (v){
                            if(sC.text.isNotEmpty) {
                              context.read<AppBloc>().add(
                                  SearchProducts(searchText: sC.text));

                              isSubmit=true;
                            }
                          },
                          controller: sC,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.only(top:0.w,left: 16.w,right: 16.w),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(18.r),
                                borderSide: BorderSide(
                                color: grey
                            )),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(18.r),
                                borderSide: BorderSide(
                                    color: grey
                                )
                            ),
                            fillColor: white,
                            filled: true,
                            focusColor: lightGrey,
                            suffixIcon: Icon(Icons.search,color: blue,)
                          ),
                        ),
                      )
                    ],
                  ),

                  SizedBox(height: 16.h,),

                  Text("Search history",style: GoogleFonts.raleway(
                    fontSize: 18,
                    fontWeight: FontWeight(500),
                      color: Color(0xFF202020)
                  ),),

                  SizedBox(height: 22.h,),

                  Wrap(
                    spacing: 10.w,
                    runSpacing: 10.w,
                    children: List.generate(state.searchHistory.length,
                    (index) => GestureDetector(
                      onTap:(){
                        sC.text=state.searchHistory[index];
                        context.read<AppBloc>().add(
                            SearchProducts(searchText: sC.text));

                        isSubmit=true;
                      },
                      child: Container(
                        height: 36.h,
                        width: 62.w,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(9.r),
                          color: Color(0xFFF4F4F4)
                        ),
                        child:Center(
                          child: Text("${state.searchHistory[index]}",style: GoogleFonts.raleway(
                            fontWeight: FontWeight(500),
                            fontSize: 17,
                            letterSpacing: -0.17
                          ),),
                        ),
                      ),
                    ),
                    ),
                  ),

                  SizedBox(height: 32.h,),

                  Text("Recommendations",style: GoogleFonts.raleway(
                      fontSize: 18,
                      fontWeight: FontWeight(500),
                      color: Color(0xFF202020)
                  ),),

                  SizedBox(height: 22.h,),


                  Wrap(
                    spacing: 10.w,
                    runSpacing: 10.w,
                    children: List.generate(mainCategories.length,
                          (index) => Container(
                        height: 36.h,
                        width: 62.w,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(9.r),
                            color: Color(0xFFF4F4F4)
                        ),
                        child:Center(
                          child: Text("${mainCategories[index]}",style: GoogleFonts.raleway(
                              fontWeight: FontWeight(500),
                              fontSize: 17,
                              letterSpacing: -0.17
                          ),),
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: 32.h,),

                  Text("Discover",style: AppTextStyles.h2,),
                  SizedBox(
                    height: 245.h,
                    width: 432.w,
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: state.newArrivalProducts.length,
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

                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
