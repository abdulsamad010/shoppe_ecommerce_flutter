
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shoppe_ecommerce_flutter/data/repositories/food_repository_impl.dart';
import 'package:shoppe_ecommerce_flutter/domain/usecases/get_foods.dart';
import 'package:shoppe_ecommerce_flutter/presentation/core/bloc/app_bloc/app_bloc.dart';
import 'package:shoppe_ecommerce_flutter/presentation/core/notification_service/notification_service.dart';
import 'package:shoppe_ecommerce_flutter/presentation/features/bottom_navigation_bar/bottom_navigation_bar_screen.dart';
import 'package:shoppe_ecommerce_flutter/presentation/features/profile/bloc/profile_bloc.dart';
import 'package:shoppe_ecommerce_flutter/presentation/features/shop/shop_screen.dart';
import 'package:shoppe_ecommerce_flutter/presentation/features/start/start_screen.dart';
import 'firebase_options.dart';

User? user;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  user=await FirebaseAuth.instance.currentUser;




  final GlobalKey<ScaffoldMessengerState> messengerKey =
  GlobalKey<ScaffoldMessengerState>();


    FirebaseMessaging.onBackgroundMessage(
      firebaseBackgroundHandler,
    );

    await NotificationService.initialize(messengerKey);



  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {

    final getFoodsObject=GetFoods(repository: FoodRepositoryImpl());

    return ScreenUtilInit(
        designSize: const Size(375, 812),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return MultiBlocProvider(
            providers: [
              BlocProvider(create:(context)=>AppBloc(getFoodsObject:getFoodsObject),),
          BlocProvider(create:(context)=>ProfileBloc(getFoodsObject: getFoodsObject))
            ],
            child: MaterialApp(
              debugShowCheckedModeBanner: false,
                    title: 'shoppe_ecommerce_flutter',
                    home: user==null ? StartScreen() : BottomNavigationBarScreen(),
                  ),
          );}
    );
  }
}


