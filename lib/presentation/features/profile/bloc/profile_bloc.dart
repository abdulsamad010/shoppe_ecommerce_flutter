
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoppe_ecommerce_flutter/presentation/features/profile/bloc/profile_event.dart';
import 'package:shoppe_ecommerce_flutter/presentation/features/profile/bloc/profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final getFoodsObject;

  ProfileBloc({required this.getFoodsObject}) : super(ProfileState(
  )) {


    on<Logout>((event, emit) async{

      emit(ProfileState(
        isPressed: true
      ));

      if(FirebaseAuth.instance.currentUser!=null) {
        FirebaseAuth.instance.signOut();
      }
      emit(ProfileState(
        isSignout:true,
      ));
    });


    on<DeleteAccount>((event, emit) async{

      emit(ProfileState(
          isPressed: true
      ));

      bool isNeedToLogin1=await getFoodsObject.deleteUser();

      emit(ProfileState(
        isNeedToLogin:isNeedToLogin1,
        isAccountDeleted:true,
      ));
    });

  }
}