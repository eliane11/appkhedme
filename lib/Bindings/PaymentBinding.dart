import 'package:get/get.dart';
import 'package:khedme/Controllers/PaymentController.dart';

class PaymentBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PaymentController>(() => PaymentController());
  }
}