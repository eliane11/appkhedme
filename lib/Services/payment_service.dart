import 'dart:convert';
import 'package:http/http.dart' as http;
import 'api_service.dart';

class PaymentService extends ApiService {
  Future<http.Response> addPayment(String token, Map<String, dynamic> paymentData) async {
    final url = buildUrl("/add_payment");

    final response = await http.post(
      url,
      headers: getHeaders(token),
      body: jsonEncode(paymentData),
    );

    return response;
  }
}
