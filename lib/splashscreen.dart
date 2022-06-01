// ignore_for_file: prefer_typing_uninitialized_variables

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
      const Duration(seconds: 3),
      () => autoLogin(),
    );
  }

  void autoLogin() async {
    var currentUser = await _databaseprovider.checkCurrentSession();
    log('curent user: $currentUser');
    if (currentUser != Null) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => const MyHomePage(title: 'Expense_Tracker'),
        ),
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const LoginScreen(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("images/splash.jpeg"),
            fit: BoxFit.fill,
          ),
        ),
        child: Center(
          child: Container(
            color: Colors.transparent,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
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
                const SizedBox(
                  height: 100,
                ),
                CollectionScaleTransition(
                  children: const <Widget>[
                    Icon(Icons.wallet_membership, color: Colors.white),
                    SizedBox(width: 3),
                    Icon(Icons.ondemand_video, color: Colors.white),
                    SizedBox(width: 3),
                    Icon(Icons.workspaces_outline, color: Colors.white),
                  ],
                ),
                const SizedBox(
                  height: 25,
                ),
                ScalingText(
                  'To Expense Tracker',
                  style: const TextStyle(
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
