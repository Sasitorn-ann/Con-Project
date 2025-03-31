import 'package:flutter/material.dart';
import 'package:Concert/models/conss.dart';
import 'package:dio/dio.dart';
import 'package:Concert/page/home/concert_details_page.dart'; // import ConcertDetailsPage

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  List<conss> _cons = [];
  List<conss> _searchResults = [];
  TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadCons();
  }

  void _loadCons() async {
    try {
      var dio = Dio();
      var response = await dio.get('https://7a4baf24-7309-4937-a8e0-9b18b9ffcfc4-00-5y28rs5ribyz.pike.replit.dev/products');

      setState(() {
        var list = response.data as List<dynamic>;
        _cons = list.map((item) => conss.fromJson(item)).toList();
      });
    } catch (error) {
      print('Error loading concerts: $error');
    }
  }

  void _searchConcerts(String query) {
    setState(() {
      _searchResults.clear();
      for (var con in _cons) {
        if (con.concert_name!.toLowerCase().contains(query.toLowerCase()) ||
            con.event_date!.toLowerCase().contains(query.toLowerCase())) {
          _searchResults.add(con);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        title: TextField(
          controller: _searchController,
          onChanged: _searchConcerts,
          style: TextStyle(color: Colors.white),
          decoration: InputDecoration(
            hintText: 'Search...',
            hintStyle: TextStyle(color: Colors.white.withOpacity(0.5)),
            border: InputBorder.none,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () => _searchConcerts(_searchController.text),
            icon: Icon(Icons.search),
          ),
        ],
        centerTitle: true,
      ),
      body: _buildSearchResults(),
      backgroundColor: Color.fromARGB(255, 52, 52, 52),
    );
  }

  Widget _buildSearchResults() {
    return ListView.builder(
      itemCount: _searchResults.length,
      itemBuilder: (context, index) {
        var con = _searchResults[index];
        return ListTile(
          title: Text(
            con.concert_name ?? '',
            style: TextStyle(color: Colors.white),
          ),
          subtitle: Text(
            'Date: ${con.event_date ?? ''}',
            style: TextStyle(color: Colors.white),
          ),
          onTap: () {
            // เมื่อคลิกที่รายการคอนเสิร์ต
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ConcertDetailsPage(concert: con), // ส่งข้อมูล Con ไปยังหน้ารายละเอียดคอนเสิร์ต
              ),
            );
          },
        );
      },
    );
  }

}