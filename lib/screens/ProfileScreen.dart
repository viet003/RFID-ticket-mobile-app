import 'package:clientguest/components/progressAPI.dart';
import 'package:flutter/material.dart';
import 'package:jwt_decode/jwt_decode.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../components/app_routes.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String? token;
  String email = '';
  String userName = '';
  Map<String, dynamic>? decodedToken;
  bool isApiCallProcess = true;

  @override
  void initState() {
    super.initState();
    _loadToken();
  }

  Future<void> logout(BuildContext context) async {
    try {
      // Xóa thông tin lưu trữ từ SharedPreferences
      final prefs = await SharedPreferences.getInstance();
      // Xóa các trường cụ thể
      await prefs.remove('token'); // Xóa trường token
      await prefs.remove('email'); // Xóa một trường khác
      print('User logged out successfully.');

      // Điều hướng về màn hình đăng nhập
      Navigator.pushNamedAndRemoveUntil(
          context, Routes.welcome, (route) => false);
    } catch (e) {
      print('Error during logout: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Đã xảy ra lỗi trong quá trình đăng xuất.')),
      );
    }
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
          email = decodedToken['email'] ?? "admin@gmail.com";
        });
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ProgressAPI(
        inAsyncCall: isApiCallProcess,
        opacity: 0.3,
        child: Column(
          children: [
            Container(
              color: const Color(0xFF1a237e),
              // Nền màu AppBar
              padding: const EdgeInsets.only(top: 40, bottom: 10),
              // Đệm cho status bar
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.white60),
                    onPressed: () {
                      // Handle back action
                    },
                  ),
                  const Text(
                    'Đăng xuất',
                    style: TextStyle(
                      color: Colors.white60,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.logout, color: Colors.white60),
                    onPressed: () {
                      logout(context);
                    },
                  ),
                ],
              ),
            ),
            Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  height: 180,
                  decoration: const BoxDecoration(
                    color: Color(0xFF1a237e),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20),
                    ),
                  ),
                ),
                Positioned(
                  top: 120,
                  left: 0,
                  right: 0,
                  child: Center(
                    child: Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                        border: Border.all(color: Colors.white, width: 4),
                      ),
                      child: const Icon(
                        Icons.person,
                        size: 60,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 190,
                  right: MediaQuery.of(context).size.width / 2 - 40,
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.black54,
                    ),
                    child: const Icon(
                      Icons.camera_alt,
                      size: 20,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 60),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Thông tin người dùng:',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1a237e)
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            UserInfoTile(
              icon: Icons.person,
              label: userName!,
            ),
            UserInfoTile(
              icon: Icons.phone,
              label: 'Không có dữ liệu',
            ),
            UserInfoTile(
              icon: Icons.email,
              label: email!,
            ),
          ],
        ),
      ),
    );
  }
}

class UserInfoTile extends StatelessWidget {
  final IconData icon;
  final String label;

  const UserInfoTile({Key? key, required this.icon, required this.label})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            Icon(icon, color: Colors.grey[600]),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                label,
                style: const TextStyle(fontSize: 14),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
