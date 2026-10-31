import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/bloc/app_bloc/app_bloc.dart';
import '../../core/bloc/app_bloc/app_state.dart';
import '../../core/colors/app_colors.dart';
import '../../core/text_styles/app_text_styles.dart';
import '../../core/widgets/just_for_you_card.dart';
import '../../core/widgets/new_items_card.dart';
import '../product_details/product_details_screen.dart';

class NewItems extends StatelessWidget {
  const NewItems({super.key});


  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppBloc,AppState>(
        builder: (context,state) {
          return Scaffold(
              appBar: AppBar(title: Text("New Items",style: AppTextStyles.h3,),
                backgroundColor: white,
                leading: IconButton(onPressed: (){Navigator.pop(context);}, icon: Icon(Icons.arrow_back_ios_new,color: blue,)),),
              backgroundColor: white,

              body: Padding(
                padding: EdgeInsets.only(left:16.w,right: 16.w),
                child: GridView.builder(
                    itemCount: state.newArrivalProducts.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,
                        childAspectRatio: 0.8,
                        mainAxisSpacing: 1.w,
                        crossAxisSpacing: 0.w
                    ),
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
                          child: Padding(
                            padding: EdgeInsets.only(left: 3,right:3.w),
                            child: JustForYouCard(image: "${state.newArrivalProducts[index].imageUrl}", text: "${state.newArrivalProducts[index].name}", price: state.newArrivalProducts[index].price),
                          )
                      );

                    })));});
        }

}
