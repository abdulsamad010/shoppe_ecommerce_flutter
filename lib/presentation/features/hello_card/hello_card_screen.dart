import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shoppe_ecommerce_flutter/presentation/core/text_styles/app_text_styles.dart';

import '../../core/colors/app_colors.dart';
import 'hello_card_screen2.dart';

class HelloCardScreen extends StatefulWidget {
  const HelloCardScreen({super.key});

  @override
  State<HelloCardScreen> createState() => _HelloCardScreenState();
}

class _HelloCardScreenState extends State<HelloCardScreen> {

  void wait()async{
    await Future.delayed(Duration(seconds: 5));
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>HelloCardScreen2()));
  }

  @override
  void initState() {

    super.initState();
    wait();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      body: Stack(
        children: [


          SvgPicture.asset("assets/icons/bubble 01 (4).svg"),

          Center(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
              
                  SizedBox(height: 55.h,),
              
                  Container(
                     width: 326.w,
                    height: 614.h,
                    decoration: BoxDecoration(
                      color: white,
                        boxShadow: [
                          BoxShadow(
                              color: black.withOpacity(0.16),
                              blurRadius: 37,
                              offset: Offset(0, 10)
                          )
                        ],
                      borderRadius: BorderRadius.circular(30.r)
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
              
                        ClipRRect(
                            borderRadius: BorderRadius.only(topLeft: Radius.circular(30.r),
                            topRight: Radius.circular(30.r)
                            ),
                            child: Image.asset("assets/images/71838C20-3BF0-4ACB-92D4-F30E0CF43659 (1).png",width: 326.w,height: 338.h,fit: BoxFit.cover,)),
              
                        SizedBox(height: 45.h,),
              
                        Text("Hello",style: AppTextStyles.h2,),
              
              
                        Padding(
                          padding: EdgeInsets.only(left:26.w,right: 26.w,top: 8.w,bottom: 26.w),
                          child: Text(
                            textAlign: TextAlign.center,
                            "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed non consectetur turpis. Morbi eu eleifend lacus.",
                          style: AppTextStyles.b1,
                          ),
                        )
                      ],
                    ),
                  ),
              
                  SizedBox(height: 35.h,),
              
                  SizedBox(
                    width: 140.w,
                    height: 20.h,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: List.generate(4, (index) {
                        return Container(
                          height: 20.h,
                          width: 20.w,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: index==1 ?
                                blue : Color(0xFFC7D6FB),
                          ),
                        );
                      },),
                    ),
                  ),
              
                  SizedBox(height: 45.h,),
              
                ],
              ),
            ),
          )


        ],
      ),
    );
  }
}
