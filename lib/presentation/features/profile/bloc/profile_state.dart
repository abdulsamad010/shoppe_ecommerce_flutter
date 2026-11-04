import 'package:image_picker/image_picker.dart';

class ProfileState {
  final bool isAccountDeleted;
  final bool isNeedToLogin;
  final bool isSignout;
  final bool isPressed;


  ProfileState({
    this.isAccountDeleted=false,
    this.isNeedToLogin=false,
    this.isSignout=false,
    this.isPressed=false,
  });
}