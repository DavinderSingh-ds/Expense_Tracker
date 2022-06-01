import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:expense_tracker/ui_designs/categories.dart';
import 'package:expense_tracker/ui_designs/dashboard.dart';
import 'package:expense_tracker/ui_designs/transactions.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;
  static const List<Widget> _widgetoptions = <Widget>[
    Dashboard(),
    Transactions(),
    Categories(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(
        child: _widgetoptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: CurvedNavigationBar(
          backgroundColor: Colors.blueAccent,
          height: 58,
          color: Colors.white,
          buttonBackgroundColor: Colors.white,
          animationCurve: Curves.easeInOut,
          animationDuration: const Duration(milliseconds: 600),
          items: const <Widget>[
            Icon(Icons.home, size: 28),
            Icon(Icons.account_balance_wallet, size: 28),
            Icon(Icons.category_sharp, size: 28),
          ],
          onTap: (index) {
            setState(() {
              _selectedIndex = index;
            });
          }),
    );
  }
}
