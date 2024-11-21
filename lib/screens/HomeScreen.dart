import 'dart:ffi';

import 'package:clientguest/components/app_routes.dart';
import 'package:clientguest/components/progressAPI.dart';
import 'package:clientguest/controller/BillController.dart';
import 'package:clientguest/controller/ConvertController.dart';
import 'package:flutter/material.dart';
import 'package:jwt_decode/jwt_decode.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? token;
  String? id;
  String? email;
  String? userName;
  int? type;
  String? cardId;
  int? vehicleType;
  int bill = 0;
  Map<String, dynamic>? decodedToken;
  bool isApiCallProcess = true;
  BillController billController = BillController();

  @override
  void initState() {
    super.initState();
    _loadToken();
  }

  Future<void> _loadToken() async {
    final prefs = await SharedPreferences.getInstance();
    token = prefs.getString('token');

    if (token != null) {
      print(token);
      try {
        Map<String, dynamic> decodedToken = Jwt.parseJwt(token!);
        setState(() {
          userName = decodedToken['user_name'] ?? 'Unknown User';
          email = decodedToken['email'];
          type = decodedToken['type'];
          cardId = decodedToken['card_id'];
          vehicleType = decodedToken['vehicle_type'];
        });
        _loadBill(decodedToken['card_id']);
      } catch (e) {
        print('Error decoding token: $e');
        setState(() {
          userName = 'Unknown User';
        });
      }
    }

    setState(() {
      isApiCallProcess = false;
    });
  }

  Future<void> _loadBill(String id) async {
    try {
      final val = await billController.getBill(id);
      if (val != null && val["data"] != null && val["data"]["total"] != null) {
        setState(() {
          bill = val["data"]["total"] ?? 0;
        });
      } else {
        setState(() {
          bill = 0;
        });
      }
    } catch (e) {
      print('Error loading bill: $e');
      setState(() {
        bill = 0; // Đặt giá trị mặc định
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ProgressAPI(
        inAsyncCall: isApiCallProcess,
        opacity: 0.3,
        child: Column(
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 25,
                    backgroundColor: Colors.blue[100],
                    child: const Icon(Icons.person, color: Colors.blue),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Xin chào,',
                          style: TextStyle(
                            fontSize: 16,
                            color: Color(0xFF1a237e),
                          ),
                        ),
                        token == null
                            ? const CircularProgressIndicator()
                            : Text(
                                userName!,
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF1a237e),
                                ),
                              ),
                      ],
                    ),
                  ),
                  Icon(Icons.qr_code, color: Colors.orange[400], size: 30),
                ],
              ),
            ),

            // Main Content
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  // Study Section
                  const Text(
                    'Học tập',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1a237e)),
                  ),
                  const SizedBox(height: 16),
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: GridView.count(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      crossAxisCount: 3,
                      mainAxisSpacing: 20,
                      crossAxisSpacing: 20,
                      children: const [
                        MenuIcon(
                          icon: Icons.library_books,
                          label: 'Thư viện',
                          color: Colors.orange,
                        ),
                        MenuIcon(
                          icon: Icons.school,
                          label: 'Công tác sinh viên',
                          color: Colors.blue,
                        ),
                        MenuIcon(
                          icon: Icons.calendar_today,
                          label: 'Thời khóa biểu',
                          color: Colors.purple,
                        ),
                        MenuIcon(
                          icon: Icons.favorite,
                          label: 'Thể dục online',
                          color: Colors.red,
                        ),
                        MenuIcon(
                          icon: Icons.star,
                          label: 'Điểm ngoại khóa',
                          color: Colors.blue,
                        ),
                      ],
                    ),
                  ),

                  // Transportation Section
                  const SizedBox(height: 15),
                  const Text(
                    'Phương tiện',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1a237e)),
                  ),
                  const SizedBox(height: 16),
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.3),
                          spreadRadius: 4,
                          blurRadius: 6,
                          offset: const Offset(0, 3), // Shadow position
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        token == null
                            ? const CircularProgressIndicator()
                            : ListTile(
                                title:
                                    Text(vehicleType == 0 ? "Xe máy" : "Ô tô"),
                                trailing: const Icon(Icons.chevron_right),
                                contentPadding: EdgeInsets.zero,
                              ),
                        const Divider(),
                        token == null
                            ? const CircularProgressIndicator()
                            : const ListTile(
                                title: Text('Biển kiểm soát'),
                                trailing: Text('-'),
                                contentPadding: EdgeInsets.zero,
                              ),
                        const Divider(),
                        token == null
                            ? const CircularProgressIndicator()
                            : ListTile(
                                title: const Text('Mã thẻ'),
                                trailing: Text(cardId ?? ""),
                                contentPadding: EdgeInsets.zero,
                              ),
                        const Divider(),
                        token == null
                            ? const CircularProgressIndicator()
                            : ListTile(
                                title: const Text('Trạng thái'),
                                trailing: Text(
                                  'Ngoài trường',
                                  style: TextStyle(color: Colors.red[400]),
                                ),
                                contentPadding: EdgeInsets.zero,
                              ),
                      ],
                    ),
                  ),

                  // Payment Section
                  const SizedBox(height: 16),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: ListTile(
                      contentPadding: EdgeInsets.zero,
                      title: const Text(
                        'Thanh toán hóa đơn',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Color(0xFF1a237e)),
                      ),
                      trailing: IconButton(
                        icon: const Icon(Icons.chevron_right),
                        onPressed: () {
                          Navigator.pushNamed(context, Routes.payment);
                        },
                      ),
                    ),
                  ),

                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.3),
                          spreadRadius: 4,
                          blurRadius: 6,
                          offset: const Offset(0, 3), // Shadow position
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        ListTile(
                          title: Text('Mã thẻ'),
                          trailing: Text(cardId ?? ""),
                          contentPadding: EdgeInsets.zero,
                        ),
                        const Divider(),
                        ListTile(
                          title: const Text('Dư nợ'),
                          trailing: Text(
                            currencyFormatter.format(bill ?? 0),
                            // Hiển thị số tiền đã định dạng
                            style: TextStyle(color: Colors.red[400]),
                          ),
                          contentPadding: EdgeInsets.zero,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MenuIcon extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;

  const MenuIcon({
    Key? key,
    required this.icon,
    required this.label,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(
            icon,
            color: color,
            size: 24,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
