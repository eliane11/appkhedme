import 'package:get/get.dart';
import 'package:khedme/Controllers/RegisterController.dart';

class RegisterBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RegisterController>(() => RegisterController());
  }
}
