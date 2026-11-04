import 'package:image_picker/image_picker.dart';

class SignupState {
  final String signupStatus;
  XFile? picker;
  final String selectedLink;
  final String sEmail,sPassword,sPhone,sImagePicker,sGender;


  SignupState({
    required this.sGender,
    this.picker,
    required this.sImagePicker,
    required this.signupStatus,
    required this.sPhone,
    required this.sEmail,
    required this.sPassword,
    required this.selectedLink,
});
}