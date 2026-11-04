

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoppe_ecommerce_flutter/presentation/features/login_email/bloc/auth_event.dart';
import 'package:shoppe_ecommerce_flutter/presentation/features/login_email/bloc/auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final getFoodsObject;
  AuthBloc({required this.getFoodsObject}) : super(AuthState(

    loginStatus:"",lEmail: "",lPassword: "1111111111",
  )) {
    on<SetEmail>((event, emit) {
      emit(AuthState(
        loginStatus: state.loginStatus,
        lPassword: state.lPassword,
        lEmail: event.email,
      ));
    });


    on<SetPassword>((event, emit) {
      emit(AuthState(
        loginStatus: state.loginStatus,
        lPassword: event.password,
        lEmail: state.lEmail,
      ));
    });


    on<Login>((event, emit) async {
      emit(AuthState(
        loginStatus: "waiting",
        lPassword: state.lPassword,
        lEmail: state.lEmail,
      ));

      print("${state.lEmail},${state.lPassword}");

      String status = "";
      try {
        await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: state.lEmail,
            password: state.lPassword
        );
        status = "successful";
      }
      on FirebaseAuthException catch (e) {
        print("Login code: ${e.code},${e}");
        status = "exception";
      }

      emit(AuthState(
        loginStatus: status,
        lPassword: "",
        lEmail: state.lEmail,
      ));
    });


    on<CleanLoginStatus>((event, emit) async {
      emit(AuthState(
        loginStatus: "",
        lPassword: "",
        lEmail: state.lEmail,
      ));
    });


    on<PasswordRecovery>((event, emit) async{

      try {
        print(state.lEmail);
        await FirebaseAuth.instance.sendPasswordResetEmail(email:state.lEmail);

      }
      on FirebaseAuthException catch(e) {
        print("Reset Email message exception: ${e.message}");
      }

      emit(AuthState(
        loginStatus: state.lPassword,
        lEmail: state.lEmail,
        lPassword: state.lPassword
      ));
    });



  }
}