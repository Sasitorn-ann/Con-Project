import 'package:flutter/material.dart';
import 'package:Concert/models/conss.dart';

class ConcertDetailsPage extends StatelessWidget {
  final conss concert;

  const ConcertDetailsPage({Key? key, required this.concert}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Concert Details',
          style: TextStyle(color: Color.fromARGB(255, 255, 247, 1)), // เปลี่ยนสีของตัวอักษรใน AppBar
        ),
        backgroundColor: Color.fromARGB(169, 8, 8, 8),
        iconTheme: IconThemeData(color: Color.fromARGB(255, 255, 247, 1)), // เปลี่ยนสีของ Icon ใน AppBar เป็นสีขาว
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              concert.concert_name ?? '',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
            ),
            const SizedBox(height: 8),
            Text('Date: ${concert.event_date ?? ''}', style: TextStyle(color: Colors.white)),
            const SizedBox(height: 8),
            Text('Time: ${concert.event_time ?? ''}', style: TextStyle(color: Colors.white)),
            const SizedBox(height: 8),
            Text('Concert ticket price: ${concert.price_ticket ?? ''}', style: TextStyle(color: Colors.white)),
            const SizedBox(height: 8),
            Text('Ways to buy tickets: ${concert.ticket ?? ''}', style: TextStyle(color: Colors.white)),
            const SizedBox(height: 8),
            Text('Concert venue: ${concert.venue ?? ''}', style: TextStyle(color: Colors.white)),
            const SizedBox(height: 8),
            Text('List of artists: ${concert.name_art ?? ''}', style: TextStyle(color: Colors.white)),
            const SizedBox(height: 8),
            Image.network(
              concert.image ?? '',
              height: 350,
              width: 350,
              fit: BoxFit.cover,
              errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
                return Icon(Icons.error, color: Color.fromARGB(255, 243, 8, 8));
              },
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Close'),
            ),
          ],
        ),
      ),
    );
  }
}
