import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shoppe_ecommerce_flutter/presentation/core/colors/app_colors.dart';

import '../colors/app_colors.dart' as Colors;

class TopProductsCard extends StatelessWidget {
  final image;
  const TopProductsCard({super.key,required this.image});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 69.h,
      width: 60.w,
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: white,
        boxShadow: [
          BoxShadow(
            color: black.withOpacity(0.16),
            blurRadius: 10,
            offset: Offset(0, 5)
          )
        ]
      ),
      child: Center(
        child: Container(
          clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(
              shape: BoxShape.circle
            ),
            child: Image.network("$image",
              height: 63.h,width: 54.w,
              fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) => SizedBox(),
            )),
      )
    );
  }
}
