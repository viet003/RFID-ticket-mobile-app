import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: const Color(0xFF1A237E),
        scaffoldBackgroundColor: Colors.white,
      ),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Status Bar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('13:51'),
                  Row(
                    children: const [
                      Icon(Icons.signal_cellular_alt, size: 16),
                      SizedBox(width: 4),
                      Icon(Icons.wifi, size: 16),
                      SizedBox(width: 4),
                      Text('58%'),
                    ],
                  ),
                ],
              ),
            ),

            // Profile Section
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFF1A237E),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundColor: Colors.white,
                    child: ClipOval(
                      child: Image.asset('assets/profile.png'),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Đinh Bá Việt Anh',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Text(
                        'Mã sinh viên: 21013232',
                        style: TextStyle(color: Colors.white70),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 4),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Text(
                          'Sinh viên',
                          style: TextStyle(color: Color(0xFF1A237E)),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  // Study Section
                  _buildSection(
                    'Học tập',
                    [
                      MenuItem(icon: Icons.calendar_today, title: 'Thời khóa biểu'),
                      MenuItem(icon: Icons.assignment, title: 'Bảng điểm'),
                      MenuItem(icon: Icons.sports, title: 'Thể dục'),
                      MenuItem(icon: Icons.health_and_safety, title: 'Bảo hiểm y tế'),
                      MenuItem(icon: Icons.star, title: 'Điểm rèn luyện'),
                      MenuItem(icon: Icons.more_horiz, title: 'Xem thêm'),
                    ],
                  ),

                  const SizedBox(height: 16),

                  // Services Section
                  _buildSection(
                    'Dịch vụ',
                    [
                      MenuItem(icon: Icons.payment, title: 'Thanh toán'),
                      MenuItem(icon: Icons.credit_card, title: 'Thẻ'),
                      MenuItem(icon: Icons.directions_car, title: 'Phương tiện'),
                      MenuItem(icon: Icons.people, title: 'Kí túc xá'),
                      MenuItem(icon: Icons.library_books, title: 'Thư viện'),
                    ],
                  ),
                ],
              ),
            ),

            // Bottom Navigation
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10,
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildNavItem(Icons.home, 'Home', true),
                    _buildNavItem(Icons.chat_bubble_outline, 'Chat', false),
                    _buildNavItem(Icons.qr_code_scanner, 'Quét QR', false),
                    _buildNavItem(Icons.notifications_none, 'Thông báo', false),
                    _buildNavItem(Icons.person_outline, 'Cá nhân', false),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(String title, List<MenuItem> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1A237E),
              ),
            ),
            TextButton(
              onPressed: () {},
              child: Row(
                children: const [
                  Text(
                    'Xem thêm',
                    style: TextStyle(color: Colors.orange),
                  ),
                  Icon(Icons.chevron_right, color: Colors.orange),
                ],
              ),
            ),
          ],
        ),
        GridView.count(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: 3,
          childAspectRatio: 1.1,
          mainAxisSpacing: 16,
          crossAxisSpacing: 16,
          children: items.map((item) => _buildMenuItem(item)).toList(),
        ),
      ],
    );
  }

  Widget _buildMenuItem(MenuItem item) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.blue.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(
            item.icon,
            color: Colors.blue,
            size: 24,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          item.title,
          style: const TextStyle(fontSize: 12),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildNavItem(IconData icon, String label, bool isSelected) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          icon,
          color: isSelected ? const Color(0xFF1A237E) : Colors.grey,
        ),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: isSelected ? const Color(0xFF1A237E) : Colors.grey,
          ),
        ),
      ],
    );
  }
}

class MenuItem {
  final IconData icon;
  final String title;

  MenuItem({required this.icon, required this.title});
}