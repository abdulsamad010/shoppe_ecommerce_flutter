import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:shoppe_ecommerce_flutter/presentation/features/signup/bloc/signup_event.dart';
import 'package:shoppe_ecommerce_flutter/presentation/features/signup/bloc/signup_state.dart';

import '../../../core/bloc/app_bloc/app_event.dart';
import '../../../core/bloc/app_bloc/app_state.dart';

class SignupBloc extends Bloc<SignupEvent, SignupState> {
  final getFoodsObject;

  SignupBloc({required this.getFoodsObject}) : super(SignupState(
    sGender: "",
    sImagePicker: "",
    signupStatus: "",
    sPhone: "",
    sEmail: "",
    sPassword: "",
    selectedLink: "assets/images/FLAG.png",
  )) {




    on<ChangeFlag>((event, emit) {
      emit(SignupState(
          sGender: state.sGender,
          sImagePicker: state.sImagePicker,
          signupStatus: state.signupStatus,
          sPhone: state.sPhone,
          sPassword: state.sPassword,sEmail: state.sEmail,selectedLink: event.link));
    });



    on<SetSignup>((event, emit) async {
      emit(SignupState(
        picker: state.picker,
        sGender: event.sGender,
        sImagePicker: event.sImagePicker,
        signupStatus: "waiting",
        sPhone: event.sPhone,
        sPassword: event.sPassword,
        sEmail: event.sEmail,
        selectedLink: state.selectedLink
      ));


      String status = "";

      try {
        var request = http.MultipartRequest(
          'POST',
          Uri.parse(
            'https://api.cloudinary.com/v1_1/djoek38oa/image/upload',
          ),
        );

        request.fields['upload_preset'] = 'shoppe_profile_pictures';
        request.files.add(
          await http.MultipartFile.fromPath('file', state.picker!.path),
        );

        var response = await request.send();
        var result = jsonDecode(await response.stream.bytesToString());


        emit(SignupState(
          selectedLink: state.selectedLink,
          picker: state.picker,
          sGender: event.sGender,
          sImagePicker: result["secure_url"],
          signupStatus: state.signupStatus,
          sPhone: event.sPhone,
          sPassword: event.sPassword,
          sEmail: event.sEmail,
        ));


        try {
          if (event.sGender != "") {
            final user = await FirebaseAuth.instance
                .createUserWithEmailAndPassword(
                email: event.sEmail, password: event.sPassword);

            await FirebaseFirestore.instance.collection("users_data").doc(
                user.user?.uid).set({
              "phone": event.sPhone,
              "profileImageUrl": state.sImagePicker,
              "gender": event.sGender
            });
          }
          else {
            final user = FirebaseAuth.instance.currentUser;

            if (user == null) return;

            await user.verifyBeforeUpdateEmail(event.sEmail.trim());

            await user.updatePassword(event.sPassword.trim());

            await FirebaseFirestore.instance
                .collection('users_data')
                .doc(user.uid)
                .update({
              'user_name': event.name.trim(),
            });
          }

          status = "successful";
        }
        on FirebaseAuthException catch (e) {
          print("Signup error: ${e.message}");
          status = "exception";
        }
      } catch (e) {
        print("Signup error: ${e}");
        status = "exception";
      }

      emit(SignupState(
        selectedLink: state.selectedLink,
        picker: state.picker,
        sGender: event.sGender,
        sImagePicker: state.sImagePicker,
        signupStatus: status,
        sPhone: event.sPhone,
        sPassword: event.sPassword,
        sEmail: event.sEmail,
      ));
    });


    on<CleanSignupStatus>((event, emit) async {
      emit(SignupState(
        selectedLink: state.selectedLink,
        sGender: state.sGender,
        sImagePicker: state.sImagePicker,
        signupStatus: "",
        sPhone: state.sPhone,
        sPassword: state.sPassword,
        sEmail: state.sEmail,
      ));
    });


    on<Picker>((event, emit) async {
      emit(SignupState(
        selectedLink: state.selectedLink,
        sGender: state.sGender,
        picker: event.picker,
        sImagePicker: state.sImagePicker,
        signupStatus: state.signupStatus,
        sPhone: state.sPhone,
        sPassword: state.sPassword,
        sEmail: state.sEmail,
      ));
    });
  }
}