import 'package:image_picker/image_picker.dart';

abstract class SignupEvent {
  SignupEvent();
}

class ChangeFlag extends SignupEvent{
  final link;
  ChangeFlag({required this.link});
}

class CleanSignupStatus extends SignupEvent{
  CleanSignupStatus();
}

class SetSignup extends SignupEvent{
  final String name,sEmail,sPassword,sPhone,sImagePicker,sGender,oSPassword;
  SetSignup({this.name="",required this.sGender,this.oSPassword="",required this.sImagePicker,required this.sPassword,required this.sEmail,required this.sPhone});
}

class Picker extends SignupEvent {
  XFile? picker;
  Picker({required this.picker});
}