import 'package:get/get.dart';

class ProfileController extends GetxController {
  // Define any variables or methods you need for the profile page

  var userName = ''.obs;
  var userEmail = ''.obs;


  void updateUserName(String name) {
    userName.value = name;
  }

  void updateUserEmail(String email) {
    userEmail.value = email;
  }
}
