import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PaymentController extends GetxController {
  // Form input controllers
  final cardNumber = TextEditingController();
  final expirationDate = TextEditingController();
  final cvv = TextEditingController();

  // Error message variables
  var cardNumberError = ''.obs;
  var cvvError = ''.obs;
  var expirationDateError = ''.obs;

  // Method to process the payment (always successful)
  Future<void> processPayment() async {
    String cardNum = cardNumber.text;
    String expDate = expirationDate.text;
    String cvvCode = cvv.text;

    // Validate inputs before proceeding
    if (_validateInputs()) {
      // Simulate an asynchronous payment process (e.g., network call)
      await Future.delayed(Duration(seconds: 2)); // Mock delay for payment processing
      _showSuccessPopup();
    } else {
      // Inform the user about invalid inputs
      Get.snackbar("Payment Failed", "Please check your payment details.");
    }
  }

  // Method to validate inputs
  bool _validateInputs() {
    bool isValid = true;

    // Validate card number (15 or 16 digits)
    if (cardNumber.text.isEmpty || cardNumber.text.length < 15 || cardNumber.text.length > 16) {
      cardNumberError.value = 'Card number must be 15 or 16 digits.';
      isValid = false;
    } else {
      cardNumberError.value = '';
    }

    // Validate CVV (3 digits)
    if (cvv.text.isEmpty || cvv.text.length != 3) {
      cvvError.value = 'CVV must be 3 digits.';
      isValid = false;
    } else {
      cvvError.value = '';
    }

    // Validate expiration date (format MM/YY and check if in the future)
    if (expirationDate.text.isEmpty || !RegExp(r'^\d{2}/\d{2}$').hasMatch(expirationDate.text)) {
      expirationDateError.value = 'Enter a valid expiration date (MM/YY).';
      isValid = false;
    } else {
      expirationDateError.value = '';
      DateTime now = DateTime.now();
      List<String> dateParts = expirationDate.text.split('/');
      int month = int.parse(dateParts[0]);
      int year = int.parse(dateParts[1]);

      if (year < now.year || (year == now.year && month < now.month)) {
        expirationDateError.value = 'Expiration date must be in the future.';
        isValid = false;
      } else {
        expirationDateError.value = '';
      }
    }

    return isValid;
  }

  // Method to show success pop-up
  void _showSuccessPopup() {
    Get.defaultDialog(
      title: "Payment Successful",
      middleText: "Your payment has been successfully processed.",
      onConfirm: () {
        // Return to the home page after successful payment
        Get.offAllNamed('/home');
      },
      textConfirm: "Go to Home",
      barrierDismissible: false,
    );
  }

  @override
  void onClose() {
    // Dispose controllers when done
    cardNumber.dispose();
    expirationDate.dispose();
    cvv.dispose();
    super.onClose();
  }
}
