import 'package:flutter/material.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final notifications = [
      {
        'type': 'exit',
        'title': 'Xe ra cổng',
        'timestamp': '2024-11-15 12:11:27',
        'shortTime': '12:11 - 15/11/2024',
      },
      {
        'type': 'entry',
        'title': 'Xe vào cổng',
        'timestamp': '2024-11-15 09:28:41',
        'shortTime': '09:28 - 15/11/2024',
      },
      {
        'type': 'exit',
        'title': 'Xe ra cổng',
        'timestamp': '2024-11-11 15:46:03',
        'shortTime': '15:46 - 11/11/2024',
      },
      {
        'type': 'entry',
        'title': 'Xe vào cổng',
        'timestamp': '2024-11-11 13:10:32',
        'shortTime': '13:10 - 11/11/2024',
      },
      {
        'type': 'exit',
        'title': 'Xe ra cổng',
        'timestamp': '2024-11-08 12:18:07',
        'shortTime': '12:18 - 08/11/2024',
      },
      {
        'type': 'entry',
        'title': 'Xe vào cổng',
        'timestamp': '2024-11-08 09:09:52',
        'shortTime': '09:09 - 08/11/2024',
      },
      {
        'type': 'exit',
        'title': 'Xe ra cổng',
        'timestamp': '2024-11-04 15:57:14',
        'shortTime': '15:57 - 04/11/2024',
      },
      {
        'type': 'entry',
        'title': 'Xe vào cổng',
        'timestamp': '2024-11-04 12:59:00',
        'shortTime': '12:59 - 04/11/2024',
      },
    ];

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
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: notifications.length,
        separatorBuilder: (context, index) => const Divider(height: 1),
        itemBuilder: (context, index) {
          final notification = notifications[index];
          final isExit = notification['type'] == 'exit';

          return ListTile(
            contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 0),
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
              notification['title']!,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            subtitle: Text(
              '${notification['timestamp']!}:${notification['title']}',
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
                  notification['shortTime']!,
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
    );
  }
}