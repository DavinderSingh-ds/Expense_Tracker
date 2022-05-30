import 'dart:async';
import 'dart:developer';
import 'package:expense_tracker/ui_designs/myhomepage.dart';
import 'package:flutter/material.dart';
import 'package:progress_indicators/progress_indicators.dart';

import 'LoginScreen.dart';
import 'database/Database2.dart';

class SplashhScreen extends StatefulWidget {
  const SplashhScreen({Key? key}) : super(key: key);

  @override
  _SplashhScreenState createState() => _SplashhScreenState();
}

class _SplashhScreenState extends State<SplashhScreen> {
  var _databaseprovider;

  @override
  void initState() {
    super.initState();
    _databaseprovider = Databaseprovider.instance;
    Timer(
      Duration(seconds: 2),
      () => autoLogin(),
    );
  }

  void autoLogin() async {
    var currentUser = await _databaseprovider.checkCurrentSession();
    log('curent user: $currentUser');
    if (currentUser != Null) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => MyHomePage(title: 'Expense_Tracker'),
        ),
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => LoginScreen(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: new AssetImage("images/Logo.jpg"),
            fit: BoxFit.fill,
          ),
        ),
        child: Center(
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Welcome',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Times New Roman',
                    fontSize: 55.0,
                    shadows: [
                      Shadow(
                        blurRadius: 2,
                        offset: Offset(5, 5),
                        color: Colors.blueAccent,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 100,
                ),
                CollectionScaleTransition(
                  children: <Widget>[
                    Icon(Icons.wallet_membership, color: Colors.white),
                    SizedBox(width: 3),
                    Icon(Icons.ondemand_video, color: Colors.white),
                    SizedBox(width: 3),
                    Icon(Icons.workspaces_outline, color: Colors.white),
                  ],
                ),
                SizedBox(
                  height: 25,
                ),
                ScalingText(
                  'Loading Please Wait....',
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'Times New Roman',
                    fontSize: 25.0,
                    shadows: [
                      Shadow(
                        blurRadius: 2,
                        offset: Offset(3, 2),
                        color: Colors.blueAccent,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
