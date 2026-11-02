import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shoppe_ecommerce_flutter/presentation/core/bloc/app_bloc/app_bloc.dart';
import 'package:shoppe_ecommerce_flutter/presentation/core/bloc/app_bloc/app_event.dart';
import 'package:shoppe_ecommerce_flutter/presentation/core/bloc/app_bloc/app_state.dart';
import 'package:shoppe_ecommerce_flutter/presentation/core/text_styles/app_text_styles.dart';
import 'package:shoppe_ecommerce_flutter/presentation/features/hello_card/hello_card_screen.dart';
import 'package:shoppe_ecommerce_flutter/presentation/features/password_recovery/password_recovery_screen.dart';

import '../../core/colors/app_colors.dart';

class LoginPasswordScreen extends StatefulWidget {
  const LoginPasswordScreen({super.key});

  @override
  State<LoginPasswordScreen> createState() => _LoginPasswordScreenState();
}

class _LoginPasswordScreenState extends State<LoginPasswordScreen> {

  final pCon=TextEditingController();

  final fK=GlobalKey<FormState>();

  bool isDialogOpen=false;

  String emailDisplayName="";

  @override
  void initState() {
    super.initState();

    emailDisplayName = context
        .read<AppBloc>()
        .state
        .lEmail;
    int index = emailDisplayName.indexOf("@");
    if (index != -1) {
      emailDisplayName = emailDisplayName.substring(0, index);
    }
  }

  @override
  Widget build(BuildContext context) {
    final myFocusNode=FocusNode();
    return BlocListener<AppBloc,AppState>(

      listener: (context,state){


        if(state.loginStatus=="waiting"){

          if (!isDialogOpen) {
            isDialogOpen = true;

            showDialog(context: context, builder: (context) {
              return AlertDialog(
                backgroundColor: white,
                content: Container(
                    height: 50.h,
                    width: 50.w,
                    child: Center(
                        child: CircularProgressIndicator(color: blue,))),
              );
            });
          }
        }
        else if(state.loginStatus=="successful"){

          if (isDialogOpen) {
            Navigator.of(context, rootNavigator: true).pop();
            isDialogOpen = false;
          }

          context.read<AppBloc>().add(CleanLoginStatus());


          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) =>
                  HelloCardScreen()));

          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Login Successful",style: AppTextStyles.b1),backgroundColor: Colors.transparent,));
        }
        else if(state.loginStatus=="exception"){

          if (isDialogOpen) {
            Navigator.of(context, rootNavigator: true).pop();
            isDialogOpen = false;
          }

          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Login Failed, Try Forget Password",style: AppTextStyles.b1),backgroundColor: Colors.transparent,));

          context.read<AppBloc>().add(CleanLoginStatus());
        }


      },

      child: Scaffold(
        backgroundColor: white,
          body: Stack(
            children: [

              SvgPicture.asset("assets/icons/bubble 02.svg"),

              SvgPicture.asset("assets/icons/bubble 01.svg"),

              SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.all(16.w),
                  child: Column(
                    children: [

                    SizedBox(height: 0.2.sh,),

                     Container(
                         padding: EdgeInsets.all(8.w),
                         decoration:BoxDecoration(
                           shape: BoxShape.circle,
                           color: white,
                           boxShadow: [
                             BoxShadow(
                               blurRadius: 5,
                               color: Color(0xFF000029).withOpacity(0.1)
                             )
                           ]
                         ),
                         child: Image.asset("assets/images/image.png")),


                      SizedBox(height: 32.h,),

                      Text("Hello, ${emailDisplayName}!!",style: AppTextStyles.h2,),

                      SizedBox(height: 32.h,),

                      Text("Type your password",style: AppTextStyles.b1,),

                      TextField(
                        maxLength: 8,
                        onChanged: (v){
                          if(pCon.text.length==8){
                            print("password: ${pCon.text}");

                            context.read<AppBloc>().add(
                                SetPassword(password: pCon.text));

                            context.read<AppBloc>().add(Login());
                            pCon.text="";



                          }


                          if(pCon.text.length<=8) {
                            context.read<AppBloc>().add(
                                SetPassword(password: pCon.text));


                          }
                        },
                          cursorColor: Colors.transparent,
                          obscureText: true,
                          controller: pCon,
                        focusNode: myFocusNode,
                        style: TextStyle(color: Colors.transparent),
                          decoration: InputDecoration(
                            counterText: "",
                            border: OutlineInputBorder(borderSide: BorderSide.none),
                            contentPadding: EdgeInsets.all(0),
                            fillColor: Colors.transparent,
                          ),
                        ),



                      Transform.translate(
                        offset: Offset(0, -40.h),
                        child: BlocBuilder<AppBloc,AppState>(
                          builder:(context,state)=> GestureDetector(
                            onTap: (){
                              myFocusNode.requestFocus();
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children:
                                List.generate(8, (index){
                                  return Container(
                                    height: 17.w,
                                    width: 17.w,
                                    decoration: BoxDecoration(
                                      color: state.lPassword.length==0 ? Colors.red : index<state.lPassword.length ? blue : grey,
                                      shape: BoxShape.circle
                                    ),
                                  );
                                })
                            ),
                          ),
                        ),
                      ),




                      Center(
                        child: BlocBuilder<AppBloc,AppState>(
                          builder:(context,state)=>
                              state.lPassword.length==0 ?
                              TextButton(onPressed: (){

                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) =>
                                    PasswordRecoveryScreen()));


                          }, child: Text(
                            "Forgot your password?",style: AppTextStyles.button2,
                          )) : SizedBox(),
                        ),
                      ),





                    ],
                  ),
                ),
              )

            ],
          ),
      ),
    );
  }
}
