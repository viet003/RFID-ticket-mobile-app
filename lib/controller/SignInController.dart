import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/SignInModel.dart';
import './Enviroment.dart';

class SignInController {
  Future<SignInModelResponse> SignIn(SignInModelRequest requestModel) async {
    Uri url = Uri.parse('${Environment.apiUrl}/auth/login');

    final response = await http.post(url, body: requestModel.toJson());
    if (response.statusCode == 200 || response.statusCode == 400) {
      return SignInModelResponse.fromJson(
        json.decode(response.body),
      );
    } else {
      throw Exception('Lỗi khi gửi yêu cầu!');
    }
  }

  Future<Map<String, dynamic>> checkTokenExpired(String token) async {
    Uri url = Uri.parse('${Environment.apiUrl}/auth'); // Đảm bảo URL chính xác

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode({
          'token': token,
        }),
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> jsonData = jsonDecode(response.body);
        print(jsonData);
        return jsonData;

      } else {
        print('Error: ${response.body}');
        throw Exception('Failed to load data! Status code: ${response.statusCode}');
      }
    } catch (error) {
      print('Error: $error');
      throw Exception('Failed to load data!');
    }
  }

  Future<Map<String, dynamic>> updateTokenDevice(String ?token, String email) async {
    Uri url = Uri.parse('${Environment.apiUrl}/auth'); // Đảm bảo URL chính xác

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode({
          'email': email,
          'token': token,
        }),
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> jsonData = jsonDecode(response.body);
        print(jsonData);
        return jsonData;

      } else {
        print('Error: ${response.body}');
        throw Exception('Failed to load data! Status code: ${response.statusCode}');
      }
    } catch (error) {
      print('Error: $error');
      throw Exception('Failed to load data!');
    }
  }
}