import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';
import './Enviroment.dart';

class BillController {
  Future<Map<String, dynamic>> getBill(String id) async {
    Uri url = Uri.parse('${Environment.apiUrl}/bill'); // Đảm bảo URL chính xác

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode({
          'card_id': id,
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

  Future<Map<String, dynamic>> payBill(String id) async {
    Uri url = Uri.parse('${Environment.apiUrl}/bill/pay'); // Đảm bảo URL chính xác
    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode({
          'card_id': id,
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
