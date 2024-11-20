import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';
import './Enviroment.dart';

class HistoriesController {
  Future<List<Map<String, dynamic>>> getHistories(String id) async {
    Uri url = Uri.parse('${Environment.apiUrl}/history/id'); // Đảm bảo URL chính xác

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
        var jsonData = jsonDecode(response.body);

        if (jsonData is Map<String, dynamic> && jsonData.containsKey('data')) {
          List<Map<String, dynamic>> historyList = [];

          for (var productJson in jsonData['data']) {
            if (productJson is Map<String, dynamic>) {
              historyList.add(productJson);
            }
          }

          print(historyList); // Debug
          return historyList;
        } else {
          throw Exception('Invalid JSON format: Missing "data" field.');
        }
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
