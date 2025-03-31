import 'package:flutter/material.dart';
import 'package:Concert/page/home/widgets/attendance.dart';
import 'package:Concert/page/home/widgets/notification.dart';
import 'package:Concert/page/home/widgets/time_table.dart';
import 'package:Concert/page/home/search_page.dart';


class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  void _handleClickButton(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        title: Text(
          'FRIEND CON',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Color.fromARGB(255, 255, 247, 1),
            fontSize: 24,
          ),
        ),
        centerTitle: true,
      ),
      body: buildPageBody(),
      backgroundColor: Color.fromARGB(255, 52, 52, 52),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.black,
        elevation: 0,
        currentIndex: _selectedIndex,
        selectedItemColor: Color.fromARGB(255, 237, 238, 241),
        unselectedItemColor: Color.fromARGB(255, 255, 247, 1),
        onTap: _handleClickButton,
        type: BottomNavigationBarType.fixed,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: 'Notice',
          ),
        ],
      ),
    );
  }

  Widget buildPageBody() {
    switch (_selectedIndex) {
      case 0:
        return const TimeTable();
      case 1:
        return SearchPage(); // เรียกใช้งานหน้าค้นหา
      case 2:
        return const AppNotification();
      default:
        return const TimeTable();
    }
  }


}