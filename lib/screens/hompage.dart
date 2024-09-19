import 'package:flutter/material.dart';
import 'package:notebook/utils/bottom_card.dart';

import 'tabs/category_tab.dart';

import 'tabs/home_tab.dart';
import 'tabs/order_tab.dart';
import 'tabs/profile_tab.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    HomeTab(),
    CategoriesTab(),
    OrdersTab(),
    ProfileTab(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        iconTheme: IconThemeData(
          color: Color(0xff1A95BE),
        ),
        title: const Center(
            child: Text(
          'Your notebook',
          style: TextStyle(
            fontSize: 16,
            color: Color(0xff1A95BE),
            fontWeight: FontWeight.w500,
          ),
        )),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_none),
            onPressed: () {},
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Color(0xff1A95BE),
              ),
              child: Text(
                'Drawer Header',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: Text('Home'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      body: Stack(
        children: [
          _pages[_selectedIndex],
          bottomCardView(context, MRP: 20, discountMrp: 20),
        ],
      ),

      // bottomSheet: BottomSheet(

      //   onClosing: () {},
      //   builder: (context) {
      //     return Container(
      //       height: 200,
      //       color: Colors.green,
      //     );
      //   },
      // ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.view_carousel_rounded),
            label: 'Categories',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.local_shipping),
            label: 'Orders',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        unselectedItemColor: Colors.grey,
        selectedItemColor: Color(0xff1A95BE),
        onTap: _onItemTapped,
      ),
    );
  }
}
