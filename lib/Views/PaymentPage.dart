import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:khedme/Controllers/PaymentController.dart';
import 'package:khedme/Models/Worker.dart';

class PaymentPage extends GetView<PaymentController> {
  final KhedmeWorker worker;

  const PaymentPage({Key? key, required this.worker}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Get.back(),
        ),
      ),
      extendBodyBehindAppBar: true,
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Background image
          Image.asset(
            'assets/images/background.png',
            fit: BoxFit.cover,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Logo at the top
              Padding(
                padding: const EdgeInsets.only(top: 50),
                child: Container(
                  height: 150,
                  width: 150,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/logo.png'),
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                "Payment Details",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFF5F5F5),
                ),
              ),
              const SizedBox(height: 20),
              Text(
                'Booking with: ${worker.firstName} ${worker.lastName}',
                style: const TextStyle(
                  fontSize: 18,
                  color: Color(0xFFEEEEEE),
                ),
              ),
              const SizedBox(height: 30),
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        _buildTextField(
                          controller: controller.cardNumber,
                          label: "Card Number",
                          hintText: "Enter your card number",
                          keyboardType: TextInputType.number,
                          errorText: controller.cardNumberError.value,
                          backgroundImage: 'assets/images/card_background.png',
                        ),
                        const SizedBox(height: 20),
                        _buildTextField(
                          controller: controller.expirationDate,
                          label: "Expiration Date",
                          hintText: "MM/YY",
                          keyboardType: TextInputType.datetime,
                          onTap: () async {
                            FocusScope.of(context).requestFocus(FocusNode());
                            DateTime? selectedDate = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(2000),
                              lastDate: DateTime(2101),
                            );
                            if (selectedDate != null) {
                              controller.expirationDate.text =
                                  DateFormat('MM/yy').format(selectedDate);
                            }
                          },
                          errorText: controller.expirationDateError.value,
                          backgroundImage: 'assets/images/card_background.png',
                        ),
                        const SizedBox(height: 20),
                        _buildTextField(
                          controller: controller.cvv,
                          label: "CVV",
                          hintText: "Enter CVV",
                          keyboardType: TextInputType.number,
                          obscureText: true,
                          errorText: controller.cvvError.value,
                          backgroundImage: 'assets/images/card_background.png',
                        ),
                        const SizedBox(height: 30),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 50, vertical: 15),
                            backgroundColor: Colors.blueGrey,
                          ),
                          onPressed: () async {
                            if (!_validateForm()) return;

                            await controller.processPayment();
                            Get.defaultDialog(
                              title: "Payment Successful",
                              middleText:
                                  "Your payment has been successfully processed.",
                              onConfirm: () {
                                Get.offAllNamed('/home');
                              },
                              textConfirm: "Go to Home",
                              barrierDismissible: false,
                            );
                          },
                          child: const Text(
                            'Pay Now',
                            style: TextStyle(fontSize: 18, color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  bool _validateForm() {
    bool isValid = true;

    if (controller.cardNumber.text.length != 16) {
      controller.cardNumberError.value = 'Card number must be 16 digits.';
      isValid = false;
    } else {
      controller.cardNumberError.value = '';
    }

    if (controller.cvv.text.length != 3) {
      controller.cvvError.value = 'CVV must be 3 digits.';
      isValid = false;
    } else {
      controller.cvvError.value = '';
    }

    if (controller.expirationDate.text.isEmpty ||
        !RegExp(r'^\d{2}/\d{2}$').hasMatch(controller.expirationDate.text)) {
      controller.expirationDateError.value =
          'Enter a valid expiration date (MM/YY).';
      isValid = false;
    } else {
      controller.expirationDateError.value = '';
    }

    return isValid;
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hintText,
    TextInputType keyboardType = TextInputType.text,
    bool obscureText = false,
    String? errorText,
    Function()? onTap,
    required String backgroundImage,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Color(0xFFEEEEEE),
          ),
        ),
        const SizedBox(height: 10),
        Stack(
          children: [
            // Background image behind the input field
            Positioned.fill(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.asset(
                  backgroundImage,
                  fit: BoxFit.cover,
                  opacity: const AlwaysStoppedAnimation(0.2), // Slight transparency for the image
                ),
              ),
            ),
            TextField(
              controller: controller,
              keyboardType: keyboardType,
              obscureText: obscureText,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white.withOpacity(0.9), // Slight transparency for text field background
                hintText: hintText,
                hintStyle: TextStyle(color: Colors.grey[600]),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: const BorderSide(color: Colors.grey, width: 1),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: const BorderSide(color: Colors.grey, width: 1),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: const BorderSide(color: Colors.blueAccent, width: 2),
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: const BorderSide(color: Colors.redAccent, width: 2),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: const BorderSide(color: Colors.red, width: 2),
                ),
              ),
              onTap: onTap,
            ),
          ],
        ),
      ],
    );
  }
}
