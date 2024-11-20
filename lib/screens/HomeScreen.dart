import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
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
                      children: const [
                        Text(
                          'Xin chào,',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey,
                          ),
                        ),
                        Text(
                          'Đinh Bá Việt Anh',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue,
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
                    ),
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
                    ),
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
                        ListTile(
                          title: const Text('Xe máy'),
                          trailing: const Icon(Icons.chevron_right),
                          contentPadding: EdgeInsets.zero,
                        ),
                        const Divider(),
                        const ListTile(
                          title: Text('Biển kiểm soát'),
                          trailing: Text('-'),
                          contentPadding: EdgeInsets.zero,
                        ),
                        const Divider(),
                        const ListTile(
                          title: Text('Mã thẻ'),
                          trailing: Text('a70d4143'),
                          contentPadding: EdgeInsets.zero,
                        ),
                        const Divider(),
                        ListTile(
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
                    child: const ListTile(
                      contentPadding: EdgeInsets.zero,
                      title: Text(
                        'Thanh toán hóa đơn',
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                      trailing: Icon(Icons.chevron_right),
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
                        const ListTile(
                          title: Text('Mã thẻ'),
                          trailing: Text('a70d4143'),
                          contentPadding: EdgeInsets.zero,
                        ),
                        const Divider(),
                        ListTile(
                          title: const Text('Dư nợ'),
                          trailing: Text(
                            '79.000đ',
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
