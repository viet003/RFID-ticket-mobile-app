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
}