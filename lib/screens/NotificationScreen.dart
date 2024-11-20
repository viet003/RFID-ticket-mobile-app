import 'package:clientguest/components/progressAPI.dart';
import 'package:clientguest/controller/HistoriesController.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:jwt_decode/jwt_decode.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  String? token;
  HistoriesController historyController = HistoriesController();
  List<Map<String, dynamic>> listHistory = <Map<String, dynamic>>[];
  bool isApiCallProcess = true;

  @override
  void initState() {
    super.initState();
    _loadProduct();
  }

  Future<void> _loadProduct() async {
    final prefs = await SharedPreferences.getInstance();
    token = prefs.getString('token');

    if (token != null) {
      try {
        Map<String, dynamic> decodedToken = Jwt.parseJwt(token!);
        historyController.getHistories(decodedToken['card_id']).then((history) {
          setState(() {
            listHistory = history;
          });
        }).catchError((error) {
          throw error;
        });
      } catch (e) {
        print('Error decoding token: $e');
      }
    }

    setState(() {
      isApiCallProcess = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Thông báo',
          style: TextStyle(
            color: Color(0xFF1a237e),
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: ProgressAPI(
        inAsyncCall: isApiCallProcess,
        opacity: 0.3,
        child: ListView.separated(
          padding: const EdgeInsets.all(16),
          itemCount: listHistory.length,
          separatorBuilder: (context, index) => const Divider(height: 1),
          itemBuilder: (context, index) {
            final notification = listHistory[index];
            final isExit = notification['status'] == 1 ? true : false;

            return ListTile(
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 8, horizontal: 0),
              leading: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: isExit ? Colors.pink[100] : Colors.green[100],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  isExit ? Icons.logout : Icons.login,
                  color: isExit ? Colors.pink : Colors.green,
                  size: 24,
                ),
              ),
              title: Text(
                notification['status'] == 0 ? "Xe vào cổng" : "Xe ra cổng",
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              subtitle: Text(
                '${DateFormat('dd/MM/yyyy HH:mm').format(DateTime.parse(notification['time']))}: Mã thẻ ${notification['card_id']}',
                style: TextStyle(
                  color: Colors.grey[600],
                  fontSize: 14,
                ),
              ),
              trailing: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    DateFormat('HH:mm')
                        .format(DateTime.parse(notification['time'])),
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 12,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Container(
                    width: 4,
                    height: 4,
                    decoration: BoxDecoration(
                      color: Colors.blue[900],
                      shape: BoxShape.circle,
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
