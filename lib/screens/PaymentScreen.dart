import 'package:clientguest/components/progressAPI.dart';
import 'package:clientguest/controller/BillController.dart';
import 'package:clientguest/controller/ConvertController.dart';
import 'package:flutter/material.dart';
import 'package:jwt_decode/jwt_decode.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({Key? key}) : super(key: key);

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  bool isAllSelected = false; // Trạng thái của "Chọn tất cả"
  bool isServiceSelected = false; // Trạng thái của "Dịch vụ gửi xe"
  String? token;
  String email = '';
  String userName = '';
  String cardId = '';
  int bill = 0;
  Map<String, dynamic>? decodedToken;
  BillController billController = BillController();
  bool isApiCallProcess = true;

  @override
  void initState() {
    super.initState();
    _loadToken();
  }

  Future<void> _loadToken() async {
    final prefs = await SharedPreferences.getInstance();
    token = prefs.getString('token');

    if (token != null) {
      try {
        Map<String, dynamic> decodedToken = Jwt.parseJwt(token!);
        setState(() {
          userName = decodedToken['user_name'] ?? 'Unknown User';
          email = decodedToken['email'] ?? "admin@gmail.com";
          cardId = decodedToken['card_id'];
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

  Future<void> _loadBill(id) async {
    billController.getBill(id).then((val) {
      // print(val["data"]["total"]);
      setState(() {
        bill = val["data"]["total"] ?? 0;
      });
    });
  }

  Future<void> payment() async {
    if (!isServiceSelected && !isAllSelected) {
      _showPopupMessage(
        context,
        "Thông báo",
        "Vui lòng lựa chọn hóa đơn muốn thanh toán.",
      );
      return;
    }

    setState(() {
      isApiCallProcess = true; // Hiển thị trạng thái đang xử lý
    });
    try {
      billController.payBill(cardId).then((val) {
        setState(() {
          isApiCallProcess = false; // Tắt trạng thái xử lý
        });

        if (val != null && val['err'] == 0) {
          _showPopupMessage(
            context,
            "Thông báo",
            val['msg'] ?? "Hóa đơn của bạn đã được thanh toán.",
          );
        } else {
          _showPopupMessage(
            context,
            "Thông báo",
            val['msg'] ??
                "Đã xảy ra lỗi khi xử lý thanh toán. Vui lòng thử lại.",
          );
        }
      }).catchError((error) {
        setState(() {
          isApiCallProcess = false;
        });
        _showPopupMessage(
          context,
          "Lỗi",
          "Đã xảy ra sự cố khi kết nối máy chủ. Vui lòng thử lại sau.",
        );
      });
      _loadBill(cardId);
    } catch (e) {
      setState(() {
        isApiCallProcess = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF1a237e)),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Thanh toán',
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Thông tin người dùng
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                children: [
                  Container(
                    width: 60, // Kích thước chiều rộng
                    height: 60, // Kích thước chiều cao
                    decoration: BoxDecoration(
                      shape: BoxShape.circle, // Định dạng hình tròn
                      border: Border.all(
                        color: Colors.grey, // Màu viền
                        width: 2, // Độ dày viền
                      ),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(30),
                      // Bo góc để hình tròn
                      child: Image.asset(
                        'assets/images/user.jpg',
                        // Thay bằng đường dẫn hình ảnh trong assets
                        fit: BoxFit.cover, // Để hình ảnh phù hợp với khung tròn
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        userName,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        email,
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const Divider(),
            // Tab bar
            const Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      children: const [
                        Text(
                          'Thanh toán dư nợ',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF1a237e),
                          ),
                        ),
                        SizedBox(height: 4),
                        Divider(
                          thickness: 2,
                          color: Color(0xFF1a237e),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: const [
                        Text(
                          'Lịch sử thanh toán',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: Colors.grey,
                          ),
                        ),
                        SizedBox(height: 4),
                        Divider(
                          thickness: 2,
                          color: Colors.transparent,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const Divider(),
            // Chọn tất cả
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  Checkbox(
                    value: isAllSelected,
                    activeColor: Colors.orange,
                    onChanged: (value) {
                      setState(() {
                        isAllSelected = value ?? false;
                        isServiceSelected = isAllSelected;
                      });
                    },
                  ),
                  const Text(
                    'Chọn tất cả',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            // Dịch vụ gửi xe
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFF7E6), // Màu nền vàng nhạt
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    Checkbox(
                      value: isServiceSelected,
                      activeColor: Colors.orange,
                      onChanged: (value) {
                        setState(() {
                          isServiceSelected = value ?? false;
                          if (!isServiceSelected) {
                            isAllSelected = false;
                          }
                        });
                      },
                    ),
                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            'Dịch vụ gửi xe',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            'Tổng dư nợ',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Text(
                      currencyFormatter.format(bill ?? 0),
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1a237e),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const Spacer(),
            // Nút thanh toán
            Padding(
              padding: const EdgeInsets.all(16),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  minimumSize: const Size(double.infinity, 50),
                ),
                onPressed: () => payment(),
                child: const Text(
                  'Thanh toán',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void _showPopupMessage(BuildContext context, String title, String message) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.blue,
          ),
        ),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text("OK"),
          ),
        ],
      );
    },
  );
}
