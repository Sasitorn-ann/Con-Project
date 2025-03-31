import 'package:flutter/material.dart';
import 'package:Concert/models/conss.dart';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:Concert/page/home/concert_details_page.dart';


class TimeTable extends StatefulWidget {
  const TimeTable({Key? key}) : super(key: key);

  @override
  State<TimeTable> createState() => _TimeTableState();
}

class _TimeTableState extends State<TimeTable> {
  List<conss> cons = [];
  List<conss> likedCons = [];

  @override
  void initState() {
    super.initState();
    fetchCons();
  }

  Future<void> fetchCons() async {
    try {
      var dio = Dio(BaseOptions(responseType: ResponseType.plain));
      var response = await dio.get('https://7a4baf24-7309-4937-a8e0-9b18b9ffcfc4-00-5y28rs5ribyz.pike.replit.dev/products');

      setState(() {
        var list = jsonDecode(response.data.toString()) as List<dynamic>;
        cons = list.map((item) => conss.fromJson(item)).toList();
      });
    } catch (error) {
      print('Error fetching cons: $error');
    }
  }

  void toggleLikeStatus(conss con) {
    setState(() {
      if (likedCons.contains(con)) {
        likedCons.remove(con);
      } else {
        likedCons.add(con);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: cons.isEmpty
              ? const Center(child: CircularProgressIndicator())
              : ListView.builder(
            itemCount: cons.length,
            itemBuilder: (context, index) {
              var con = cons[index];
              var imageURL = con.image ?? '';
              return ListTile(
                title: Text(con.concert_name ?? '', style: TextStyle(color: Colors.white)),
                subtitle: Text(con.event_date != null ? 'Date: ${con.event_date}' : '', style: TextStyle(color: Colors.white)),
                trailing: imageURL.isNotEmpty
                    ? SizedBox(
                  height: 100,
                  width: 100,
                  child: Image.network(
                    imageURL,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => const Icon(Icons.error, color: Colors.red),
                  ),
                )
                    : const SizedBox.shrink(),
                onTap: () => showDialog(
                  context: context,
                  builder: (context) => ConDetailDialog(con: con, onLikeToggle: toggleLikeStatus),
                ),
              );
            },
          ),
        ),
        ElevatedButton(
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => LikedPage(likedCons: likedCons)),
          ),
          child: Text('LIKED (${likedCons.length})'),
        ),
      ],
    );
  }
}

class ConDetailDialog extends StatefulWidget {
  final conss con;
  final Function(conss) onLikeToggle;

  const ConDetailDialog({Key? key, required this.con, required this.onLikeToggle}) : super(key: key);

  @override
  _ConDetailDialogState createState() => _ConDetailDialogState();
}

class _ConDetailDialogState extends State<ConDetailDialog> {
  bool isLiked = false;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(widget.con.concert_name ?? '', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black)),
            const SizedBox(height: 8),
            Text('Date: ${widget.con.event_date ?? ''}', style: TextStyle(color: Colors.black)),
            Text('Time: ${widget.con.event_time ?? ''}', style: TextStyle(color: Colors.black)),
            Text('Price: ${widget.con.price_ticket ?? ''}', style: TextStyle(color: Colors.black)),
            Text('Ticket: ${widget.con.ticket ?? ''}', style: TextStyle(color: Colors.black)),
            Text('Venue: ${widget.con.venue ?? ''}', style: TextStyle(color: Colors.black)),
            Text('Artists: ${widget.con.name_art ?? ''}', style: TextStyle(color: Colors.black)),
            const SizedBox(height: 8),
            Image.network(
              widget.con.image ?? '',
              height: 350,
              width: 350,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => const Icon(Icons.error, color: Colors.red),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                IconButton(
                  onPressed: () {
                    setState(() {
                      isLiked = !isLiked;
                    });
                    widget.onLikeToggle(widget.con);
                  },
                  icon: Icon(
                    isLiked ? Icons.favorite : Icons.favorite_border,
                    color: isLiked ? Colors.red : null,
                  ),
                ),
                ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Close'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class LikedPage extends StatelessWidget {
  final List<conss> likedCons;

  const LikedPage({Key? key, required this.likedCons}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Liked Concerts')),
      body: ListView.builder(
        itemCount: likedCons.length,
        itemBuilder: (context, index) {
          var con = likedCons[index];
          return ListTile(
            title: Text(con.concert_name ?? ''),
            subtitle: Text(con.event_date ?? ''),
            trailing: Icon(Icons.favorite, color: Colors.red),
          );
        },
      ),
    );
  }
}
