import 'package:get/get.dart';
import 'package:khedme/Controllers/ProfileController.dart';

class ProfileBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProfileController>(() => ProfileController());
  }
}
