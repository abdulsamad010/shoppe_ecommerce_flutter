import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:http/http.dart';
import 'package:shoppe_ecommerce_flutter/presentation/core/bloc/app_bloc/app_state.dart';

import '../../core/bloc/app_bloc/app_bloc.dart';
import '../../core/bloc/app_bloc/app_event.dart';
import '../../core/colors/app_colors.dart';
import '../../core/text_styles/app_text_styles.dart';
import '../../core/widgets/category_card.dart';
import '../bottom_navigation_bar/bottom_navigation_bar_screen.dart';

class AllCategoriesScreen extends StatelessWidget {
  const AllCategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppBloc,AppState>(
      builder: (context,state) {
        return Scaffold(
          appBar: AppBar(title: Text("Categories",style: AppTextStyles.h3,),
          backgroundColor: white,
          leading: IconButton(onPressed: (){Navigator.pop(context);}, icon: Icon(Icons.arrow_back_ios_new,color: blue,)),),
          backgroundColor: white,

          body: Padding(
            padding: EdgeInsets.only(left:16.w,right: 16.w),
            child: GridView.builder(
                    itemCount: state.categories.length,
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
          ));
      }
    );
  }
}
