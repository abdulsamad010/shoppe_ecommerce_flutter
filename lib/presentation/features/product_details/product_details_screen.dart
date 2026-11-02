import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:share_plus/share_plus.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shoppe_ecommerce_flutter/presentation/core/bloc/app_bloc/app_event.dart';
import 'package:shoppe_ecommerce_flutter/presentation/core/bloc/app_bloc/app_state.dart';
import 'package:shoppe_ecommerce_flutter/presentation/core/widgets/review_card.dart';
import 'package:shoppe_ecommerce_flutter/presentation/features/product_variations/product_variations_screen.dart';
import 'package:shoppe_ecommerce_flutter/presentation/features/review/review_screen.dart';

import '../../core/colors/app_colors.dart';

import '../../core/bloc/app_bloc/app_bloc.dart';
import '../../core/colors/app_colors.dart';
import '../../core/text_styles/app_text_styles.dart';
import '../../core/widgets/custom_cart_floating_action_button.dart';
import '../../core/widgets/just_for_you_card.dart';
import '../../core/widgets/top_products_card.dart';

class ProductDetailsScreen extends StatefulWidget {
  String productId;
  ProductDetailsScreen({super.key,required this.productId});

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  int? index;
  @override
  void initState() {

    super.initState();

    for(int i=0;i<context.read<AppBloc>().state.products.length;i++){
      if(context.read<AppBloc>().state.products[i].id==widget.productId){
        index=i;
        break;
      }
    }

    context.read<AppBloc>().add(UpdateCartProgress(productId: widget.productId, quantity: 1, color: context.read<AppBloc>().state.products[index!].colors[0], size:  context.read<AppBloc>().state.products[index!].sizes[0]));

  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppBloc,AppState>(
      builder:(context,state)=>Scaffold(
        backgroundColor: white,
        body: index==null ? Center(child: Text("Product details not found")):

        SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                
                Stack(
                  alignment: .topLeft,
                  children:[ Image.network("${state.products[index!].imageUrl}",
                  fit: BoxFit.cover,
                  width: 375.w,
                      height: 439.h,
                  ),
          
          
                    Padding(padding: EdgeInsets.all(16.w),
                    child: IconButton(onPressed: (){Navigator.pop(context);}, icon: Icon(Icons.arrow_left)),
                    )
               ] ),
            
            
            
                Padding(
                  padding: EdgeInsets.all(16.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
            
                          Row(
                            children: [
                              Icon(Icons.attach_money,fontWeight:FontWeight(800),size: 26,),
            
                              Transform.translate(
                                offset: Offset(-6.w, 0),
                                child: Text("${state.products[index!].price}",style: GoogleFonts.raleway(
                                    fontSize: 26,
                                    letterSpacing: -0.26,
                                  fontWeight: FontWeight(800)
                                ),),
                              ),
            
                            ],
                          ),
            
            
                          IconButton(
                              onPressed: (){
                                SharePlus.instance.share(
                                  ShareParams(
                                    text: 'Check out ${state.products[index!].name} for Rs. ${state.products[index!].price}!',
                                  ),
                                );
                              },
                              icon: SvgPicture.asset("assets/icons/Share.svg"))
                        ],
                      ),
            
            
            
                      SizedBox(height: 16.h,),
            
                      Text("${state.products[index!].description}",style: GoogleFonts.nunitoSans(
                        fontWeight: FontWeight(400),
                        fontSize: 15
                      ),),
            
                      SizedBox(height: 22.h,),
            
                      Row(
                        children: [
                          Text("Variations",style: AppTextStyles.h3,),
            
                          SizedBox(width: 16.w,),
            
                          Container(
                            height: 25.h,
                            width: 54.w,
                            decoration: BoxDecoration(
                                color: Color(0xFFF9F9F9),
                                borderRadius: BorderRadius.circular(4.r)
                            ),
                            child: Center(
                              child: Text("${state.cartProgress["color"]!=null ? state.cartProgress["color"] : ""}",style: GoogleFonts.raleway(
                                fontSize: 14,
                                fontWeight: FontWeight(500),
                              ),),
                            ),
                          ),
            
                          SizedBox(width: 16.w,),
            
                          Container(
                            height: 25.h,
                            width: 54.w,
                            decoration: BoxDecoration(
                                color: Color(0xFFF9F9F9),
                                borderRadius: BorderRadius.circular(4.r)
                            ),
                            child: Center(
                              child: Text("${state.cartProgress["size"]!=null ? state.cartProgress["size"] : ""}",style: GoogleFonts.raleway(
                                fontSize: 14,
                                fontWeight: FontWeight(500),
                              ),),
                            ),
                          ),
            
            
                          Spacer(),
            
                          GestureDetector(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>ProductVariationsScreen(productIndex: index!,)));
                          },
                          child: Container(
                              padding: EdgeInsets.all(8.w),
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: blue
                              ),
                              child: SvgPicture.asset("assets/icons/Arrow.svg"),
                            ),
                          )
            
                        ],
                      ),
          
                      SizedBox(height: 8.h,),
            
                      SizedBox(
                        height: 75.h,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                            itemCount: 3,
                            itemBuilder: (context,i){
                          return Padding(
                            padding: EdgeInsets.only(right: 4.w),
                            child: ClipRRect(
                              borderRadius: BorderRadiusGeometry.circular(6.r),
                              child: Image.network("${state.products[index!].relatedTmages[i]}",width: 75.w,height: 75.h,fit: BoxFit.cover,),
                            ),
                          );
                        }),
                      ),
          
                      SizedBox(height: 22.h,),
          
                      Text("Specifications",style: AppTextStyles.h3,),
            
                      SizedBox(width: 16.w,),
                      
                      Text("Material",style: GoogleFonts.raleway(
                        fontSize: 17,
                        fontWeight: FontWeight(700),
                        letterSpacing: -0.17
                      ),),
            
            
                      SizedBox(
                        height: 25.h,
                        child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: state.products[index!].materials.length,
                            itemBuilder: (context,i){
                              return Padding(
                                padding: EdgeInsets.only(right: 4.w),
                                child: Container(
                                  height: 25.h,
                                  width: 96.w,
                                  decoration: BoxDecoration(
                                      color: Color(0xFFFFEBEB),
                                      borderRadius: BorderRadius.circular(4.r)
                                  ),
                                  child: Center(
                                   child: Text("${state.products[index!].materials[i]}",style: GoogleFonts.raleway(
                                      fontSize: 14,
                                      fontWeight: FontWeight(500),
                                    ),),
                                  ),
                                ),
                              );
                            }),
                      ),
          
                      SizedBox(height: 16.h,),
            
                      Text("Origin",style: GoogleFonts.raleway(
                          fontSize: 17,
                          fontWeight: FontWeight(700),
                          letterSpacing: -0.17
                      ),),
            
            
                      SizedBox(
                        height: 25.h,
                        child: Container(
                          height: 25.h,
                          width: 59.w,
                          decoration: BoxDecoration(
                              color: Color(0xFFE5EBFC),
                              borderRadius: BorderRadius.circular(4.r)
                          ),
                          child: Center(
                            child: Text("${state.products[index!].origin}",style: GoogleFonts.raleway(
                                      fontSize: 14,
                                      fontWeight: FontWeight(500),
                                    ),),
                          ),
                        ),
                      ),
          
          
                      SizedBox(height: 16.h,),
          
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Size guide",style: GoogleFonts.raleway(
                              fontSize: 17,
                              fontWeight: FontWeight(700),
                              letterSpacing: -0.17
                          ),),
          
          
                          GestureDetector(
                            onTap: (){


                              showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    backgroundColor: Colors.white,
                                    surfaceTintColor: Colors.white,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                    title: Text(
                                      'EU Size Guide',
                                      style: GoogleFonts.raleway(
                                        fontSize: 22,
                                        fontWeight: FontWeight.w700,
                                        color: const Color(0xFF202020),
                                      ),
                                    ),
                                    content: SingleChildScrollView(
                                      child: Text(
                                        'What are EU sizes?\n\n'
                                            'EU sizes are European sizing standards used for clothing and footwear.\n\n'
                                            '• Clothing: Common sizes include EU 34, 36, 38, 40, and 42. Generally, higher numbers indicate larger sizes.\n\n'
                                            '• Shoes: Common sizes include EU 36, 37, 38, 39, and 40. Each size corresponds to a different foot length.\n\n'
                                            '• Choosing your size: Check the product details and compare your measurements with the size chart when available.\n\n'
                                            '• Please note: Sizing can vary between brands and products. Always check the product-specific size recommendations.',
                                        style: GoogleFonts.raleway(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                          height: 1.6,
                                          color: const Color(0xFF666666),
                                        ),
                                      ),
                                    ),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: Text(
                                          'Close',
                                          style: GoogleFonts.raleway(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w700,
                                            color: blue
                                          ),
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              );


                            },
                            child: Container(
                              padding: EdgeInsets.all(8.w),
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: blue
                              ),
                              child: SvgPicture.asset("assets/icons/Arrow.svg"),
                            ),
                          )
          
                        ],
                      ),
          
          
                      SizedBox(height: 22.h,),
          
                      Text("Delivery",style: AppTextStyles.h3,),
          
                      SizedBox(height: 8.h,),
          
                      Container(
                        width: 335.w,
                        height: 40.h,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.r),
                          border: Border.all(color: blue)
                        ),
                        child: Row(
                          children: [
                            SizedBox(width: 8.w,),
          
                            Text("Standard",style: GoogleFonts.raleway(
                              fontSize: 14,
                              fontWeight: FontWeight(500),
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
                                child: Text("5-7 days",style:GoogleFonts.raleway(
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
                              child: Text("3,00",style: GoogleFonts.raleway(
                                  fontSize: 16,
                                  fontWeight: FontWeight(700)
                              ),),
                            ),
          
                            SizedBox(width: 8.w,),
          
                          ],
                        ),
                      ),
          
          
          
                      SizedBox(height: 8.h,),
          
                      Container(
                        width: 335.w,
                        height: 40.h,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.r),
                            border: Border.all(color: blue)
                        ),
                        child: Row(
                          children: [
                            SizedBox(width: 8.w,),
          
                            Text("Express",style: GoogleFonts.raleway(
                              fontSize: 14,
                              fontWeight: FontWeight(500),
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
                                child: Text("1-2 days",style:GoogleFonts.raleway(
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
                              child: Text("12,00",style: GoogleFonts.raleway(
                                  fontSize: 16,
                                  fontWeight: FontWeight(700)
                              ),),
                            ),
          
                            SizedBox(width: 8.w,),
          
                          ],
                        ),
                      ),
          
          
          
                      SizedBox(height: 22.h,),
          
                      Text("Rating & Reviews",style: AppTextStyles.h3,),
          
                      SizedBox(height: 22.h,),
          
                      Row(
                        children: [
                          RatingBarIndicator(
                              itemCount: 5,
                              itemSize: 30,
                              itemPadding: EdgeInsets.only(right: 4),
                              rating: state.products[index!].ratings[0].toDouble(),
                              itemBuilder: (context,index){
                            return Icon(Icons.star,color: Color(0xFFECA61B),);
                          }),
          
          
                          SizedBox(width: 4.w,),
          
                          Container(
                            height: 20.h,
                            width: 38.w,
                            decoration: BoxDecoration(
                              color: Color(0xFFDFE9FF),
                              borderRadius: BorderRadius.circular(6.r)
                            ),
                            child: Center(child: Text("${state.products[index!].ratings[0]}/5",style: TextStyle(fontWeight: FontWeight.bold),)),
                          )
                        ],
                      ),
          
                      ReviewCard(productIndex: index!, ReviewIndex: 0),
          
                      SizedBox(height: 16.h,),
          
                      SizedBox(
                        width: 335.w,
                        height: 40.h,
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: blue,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(11.r),
                              )
                            ),
                            onPressed: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>ReviewScreen(productIndex: index!)));
                          }, child:Text("View All Reviews",style: GoogleFonts.nunitoSans(fontWeight: FontWeight(300),
                            fontSize: 16,
                            color: Color(0xFFF3F3F3)),)),
                      ),


                      SizedBox(height: 26.h,),

                      Text("Top Products",style: AppTextStyles.h3,),

                      SizedBox(height: 22.h,),

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


                      SizedBox(height: 22.h,),

                      Text("You Might Like",style: AppTextStyles.h3,),

                      SizedBox(height: 22.h,),

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

                SizedBox(height: 74.h,),
              ],
            ),
          ),
        ),


        floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,

        floatingActionButton: CustomCartFloatingActionButton(productId: widget.productId),


      ),
    );
  }
}
