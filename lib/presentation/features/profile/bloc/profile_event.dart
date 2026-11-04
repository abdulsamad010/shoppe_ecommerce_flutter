import 'package:image_picker/image_picker.dart';

abstract class ProfileEvent {
  ProfileEvent();
}

class DeleteAccount extends ProfileEvent{
}

class Logout extends ProfileEvent{
}