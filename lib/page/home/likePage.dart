import 'package:flutter/material.dart';
import 'package:Concert/models/conss.dart';

class LikePage extends StatelessWidget {
  final conss con;

  const LikePage({Key? key, required this.con}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Liked Concert',
          style: TextStyle(color: Theme.of(context).colorScheme.secondary), // ใช้สีที่ถูกกำหนดในธีมเพื่อให้สอดคล้องกับธีมของแอพพลิเคชั่น
        ),
        backgroundColor: Colors.black, // กำหนดสีพื้นหลังของแทบบาร์เป็นสีดำ
        iconTheme: IconThemeData(color: Theme.of(context).colorScheme.secondary), // ใช้สีของ Icon ใน AppBar ที่ถูกกำหนดในธีม
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              con.concert_name ?? '',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(color: Colors.white),

            ),
            const SizedBox(height: 8),
            Text('Date: ${con.event_date ?? ''}', style: TextStyle(color: Colors.white)),
            const SizedBox(height: 8),
            Text('Time: ${con.event_time ?? ''}', style: TextStyle(color: Colors.white)),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}