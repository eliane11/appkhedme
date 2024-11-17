import 'package:http/http.dart' as http;
import 'api_service.dart';

class UserService extends ApiService {
  // Future<http.Response> getUsers(String token) async {
  //   final url = buildUrl("/users");
  //   final response = await http.get(
  //     url,
  //     headers: getHeaders(token),
  //   );

  //   return response;
  // }

  Future<http.Response> getUserById(String token, int userId) async {
    final url = buildUrl("/users/$userId");
    final response = await http.get(
      url,
      headers: getHeaders(token),
    );

    return response;
  }
}
