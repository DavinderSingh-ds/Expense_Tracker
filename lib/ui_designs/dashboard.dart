// ignore_for_file: prefer_typing_uninitialized_variables

import 'dart:developer';

import 'package:expense_tracker/database/database.dart';
import 'package:expense_tracker/model/transactionModel.dart';
import 'package:expense_tracker/ui_designs/profile.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:simple_speed_dial/simple_speed_dial.dart';
import 'new_expense.dart';
import 'new_income.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  var _databaseprovider;
  late Future<List<TransactionModel>> expenseTransactionsList;
  var totalIncome;
  var totalExpense;

  @override
  void initState() {
    super.initState();
    _databaseprovider = Databaseprovider.instance;
    refreshData();
  }

  refreshData() {
    setState(() {
      getTransactions();
    });
  }

  getTransactions() {
    setState(() {
      expenseTransactionsList = _databaseprovider.gettransactionbyExpense();
      totalIncome = _databaseprovider.getSumofIncome('Income');
      totalExpense = _databaseprovider.getSumofExpense('Expense');
      log('Data from categoryList $expenseTransactionsList');
    });
  }

  var size, width, height, oreintation;
  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    width = size.width;
    height = size.height;
    oreintation = MediaQuery.of(context).orientation;

    log('Size of Screen is $size');
    log('Width of Screen is $width');
    log('Height of Screen is $height');
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(
        children: [
          Stack(
            children: [
              Container(
                height: 90,
                width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.cyanAccent,
                      Colors.green,
                    ],
                  ),
                ),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 38,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        const Text(
                          '🕵️‍♀️ Expense Tracker',
                          style: TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        IconButton(
                          icon: const Icon(
                            Icons.account_circle_sharp,
                            size: 30,
                            color: Colors.black,
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const Profile(),
                              ),
                            );
                          },
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
          Stack(
            children: [
              Container(
                height: 65,
                width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.cyanAccent,
                      Colors.green,
                    ],
                  ),
                ),
              ),
              Container(
                height: 65,
                width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(70),
                    topLeft: Radius.circular(70),
                  ),
                ),
                child: Column(
                  children: const [
                    SizedBox(height: 18),
                    Text('💰 Welcome to Money Manager   🕵️‍♀️'),
                  ],
                ),
              ),
            ],
          ),
          Expanded(
            child: Stack(
              children: [
                Container(
                  color: Colors.amber,
                ),
                Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(88),
                    ),
                  ),
                  child: Column(
                    children: [
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            const SizedBox(
                              width: 10,
                            ),
                            Container(
                              height: 150,
                              width: 140,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                gradient: const LinearGradient(
                                  colors: [
                                    Colors.indigoAccent,
                                    Colors.cyanAccent,
                                  ],
                                ),
                              ),
                              child: Column(
                                children: [
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Container(
                                    height: 50,
                                    width: 50,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(80),
                                      color: Colors.white,
                                      image: const DecorationImage(
                                        image: AssetImage('images/income.png'),
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    color: Colors.transparent,
                                    height: 50,
                                    width: 100,
                                    child: const Center(
                                      child: Text(
                                        'Income',
                                        style: TextStyle(
                                          fontSize: 23,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                          shadows: [
                                            Shadow(
                                              offset: Offset(2, 2),
                                              color: Colors.blueAccent,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 3,
                                  ),
                                  Container(
                                    height: 20,
                                    width: 100,
                                    decoration: const BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(3),
                                      ),
                                      boxShadow: [
                                        BoxShadow(
                                          offset: Offset(2, 2),
                                          blurRadius: 3,
                                          color: Colors.indigoAccent,
                                        ),
                                      ],
                                    ),
                                    child: Center(
                                      child: FutureBuilder(
                                        future: totalIncome,
                                        builder: (BuildContext context,
                                            AsyncSnapshot snapshot) {
                                          if (snapshot.hasData) {
                                            return Text(
                                              '₹ ${snapshot.data}',
                                              style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.green,
                                              ),
                                            );
                                          } else {
                                            return const Center(
                                              child: Text(
                                                '₹ ${0.0}',
                                                style: TextStyle(
                                                  color: Colors.green,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            );
                                          }
                                        },
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Container(
                              height: 150,
                              width: 140,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                gradient: const LinearGradient(
                                  colors: [
                                    Colors.cyanAccent,
                                    Colors.greenAccent,
                                  ],
                                ),
                              ),
                              child: Column(
                                children: [
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Container(
                                    height: 50,
                                    width: 50,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(80),
                                      color: Colors.white,
                                      image: const DecorationImage(
                                        image:
                                            AssetImage('images/expense.jfif'),
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    color: Colors.transparent,
                                    height: 50,
                                    width: 100,
                                    child: const Center(
                                      child: Text(
                                        'Expense',
                                        style: TextStyle(
                                          fontSize: 22,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                          shadows: [
                                            Shadow(
                                              offset: Offset(2, 2),
                                              color: Colors.blueAccent,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 3,
                                  ),
                                  Container(
                                    height: 20,
                                    width: 100,
                                    decoration: const BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(3),
                                      ),
                                      boxShadow: [
                                        BoxShadow(
                                          offset: Offset(2, 2),
                                          blurRadius: 3,
                                          color: Colors.indigoAccent,
                                        ),
                                      ],
                                    ),
                                    child: Center(
                                      child: FutureBuilder(
                                        future: totalExpense,
                                        builder: (BuildContext context,
                                            AsyncSnapshot snapshot) {
                                          if (snapshot.hasData) {
                                            return Text(
                                              '₹ ${snapshot.data}',
                                              style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.green,
                                              ),
                                            );
                                          } else {
                                            return const Center(
                                              child: Text(
                                                '₹ ${0.0}',
                                                style: TextStyle(
                                                  color: Colors.green,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            );
                                          }
                                        },
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Container(
                              height: 150,
                              width: 140,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                gradient: const LinearGradient(
                                  colors: [
                                    Colors.indigoAccent,
                                    Colors.cyanAccent,
                                  ],
                                ),
                              ),
                              child: Column(
                                children: [
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Container(
                                    height: 50,
                                    width: 50,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(80),
                                      color: Colors.white,
                                      image: const DecorationImage(
                                        image: AssetImage('images/balance.png'),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    color: Colors.transparent,
                                    height: 50,
                                    width: 100,
                                    child: const Center(
                                      child: Text(
                                        'Balance',
                                        style: TextStyle(
                                          fontSize: 23,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                          shadows: [
                                            Shadow(
                                                offset: Offset(4, 4),
                                                color: Colors.blueAccent),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 40,
                                  ),
                                  Container(
                                    height: 20,
                                    width: 100,
                                    decoration: const BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(3),
                                      ),
                                      boxShadow: [
                                        BoxShadow(
                                          offset: Offset(2, 2),
                                          blurRadius: 3,
                                          color: Colors.indigoAccent,
                                        ),
                                      ],
                                    ),
                                    child: Center(
                                      child: FutureBuilder(
                                        future: totalIncome,
                                        builder: (BuildContext context,
                                            AsyncSnapshot snapshotIncome) {
                                          return FutureBuilder(
                                            future: totalExpense,
                                            builder: (BuildContext context,
                                                AsyncSnapshot snapshotExpense) {
                                              if (snapshotIncome.hasData &&
                                                  snapshotExpense.hasData) {
                                                return Text(
                                                  "₹ " +
                                                      (snapshotIncome.data -
                                                              snapshotExpense
                                                                  .data)
                                                          .toString(),
                                                  style: const TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.green,
                                                  ),
                                                );
                                              } else {
                                                return const Center(
                                                  child: Text(
                                                    '₹ ${0.0}',
                                                    style: TextStyle(
                                                      color: Colors.green,
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                );
                                              }
                                            },
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 10, right: 10, top: 10, bottom: 5),
                        child: Container(
                          color: Colors.white,
                          child: const Text(
                            'Recent Transactions',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 23,
                              fontFamily: 'Times New Roman',
                              fontWeight: FontWeight.bold,
                              shadows: [
                                Shadow(
                                  blurRadius: 2,
                                  offset: Offset(2, 2),
                                  color: Colors.blueAccent,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            height: MediaQuery.of(context).size.height,
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                colors: [
                                  Colors.white,
                                  Colors.indigoAccent,
                                ],
                              ),
                              borderRadius: BorderRadius.circular(6),
                              boxShadow: const [
                                BoxShadow(
                                  offset: Offset(2, 2),
                                  blurRadius: 2,
                                  color: Colors.grey,
                                ),
                              ],
                            ),
                            child: FutureBuilder(
                              future: expenseTransactionsList,
                              builder: (BuildContext context,
                                  AsyncSnapshot<List<TransactionModel>>
                                      expenseSnapshot) {
                                if (expenseSnapshot.hasData) {
                                  log('Lenght of the data ${expenseSnapshot.data!.length}');
                                  return ListView.builder(
                                    itemCount: expenseSnapshot.data?.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      TransactionModel transactionDetails =
                                          expenseSnapshot.data![index];
                                      return Padding(
                                        padding: const EdgeInsets.only(
                                            left: 6, right: 6, bottom: 2.3),
                                        child: Card(
                                          elevation: 2,
                                          child: Column(
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(2.0),
                                                child: Container(
                                                  color: Colors.white,
                                                  child: Row(
                                                    children: [
                                                      Container(
                                                        color: Colors.white,
                                                        child: Text(
                                                          transactionDetails
                                                              .categoryType,
                                                          style: const TextStyle(
                                                              fontSize: 14,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontFamily:
                                                                  'Times New Roman'),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              // Text(transactionDetails.transactionType),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            2.0),
                                                    child: Text(
                                                      transactionDetails.date,
                                                      style: const TextStyle(
                                                        fontSize: 13,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontFamily:
                                                            'Times New Roman',
                                                      ),
                                                    ),
                                                  ),
                                                  Container(
                                                    color: Colors.white,
                                                    width: 90,
                                                    child: Text(
                                                      '₹ ${transactionDetails.amount}',
                                                      style: const TextStyle(
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontFamily:
                                                            'Times New Roman',
                                                        color: Colors.red,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                } else {
                                  return Center(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: const [
                                        Text('Please Wait.....'),
                                        SizedBox(height: 30),
                                        CircularProgressIndicator(),
                                      ],
                                    ),
                                  );
                                }
                              },
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            color: Colors.white,
            height: 75,
            child: Stack(
              children: [
                Container(
                  color: Colors.white,
                ),
                Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  decoration: const BoxDecoration(
                    color: Colors.amber,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(40),
                      bottomLeft: Radius.circular(40),
                      bottomRight: Radius.circular(40),
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            bottom: 16, left: 10, right: 90),
                        child: Container(
                          height: 45,
                          width: 270,
                          decoration: const BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Colors.greenAccent,
                                Colors.cyan,
                                Colors.indigoAccent,
                              ],
                            ),
                            borderRadius: BorderRadius.all(
                              Radius.circular(10),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  height: 34,
                                  width: 90,
                                  decoration: const BoxDecoration(
                                    gradient: LinearGradient(
                                      colors: [
                                        Colors.cyan,
                                        Colors.indigoAccent,
                                      ],
                                    ),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(5),
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        offset: Offset(1, 1),
                                        blurRadius: 1,
                                        color: Colors.black,
                                      ),
                                    ],
                                  ),
                                  child: MaterialButton(
                                    child: const Text(
                                      'Expense',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 13,
                                        fontWeight: FontWeight.bold,
                                        shadows: [
                                          Shadow(
                                            offset: Offset(2, 2),
                                            color: Colors.blue,
                                          ),
                                        ],
                                      ),
                                    ),
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              const NewExpense(title: ''),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  height: 34,
                                  width: 90,
                                  decoration: const BoxDecoration(
                                    gradient: LinearGradient(
                                      colors: [
                                        Colors.cyan,
                                        Colors.indigoAccent,
                                      ],
                                    ),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(5),
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        offset: Offset(1, 1),
                                        blurRadius: 1,
                                        color: Colors.black,
                                      ),
                                    ],
                                  ),
                                  child: MaterialButton(
                                    child: const Text(
                                      'Income',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 13,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              const Incomepage(
                                            title: '',
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),

      //FAB
      floatingActionButton: SpeedDial(
        child: const Icon(Icons.add),
        speedDialChildren: <SpeedDialChild>[
          SpeedDialChild(
            child: const Icon(Icons.sick_outlined),
            foregroundColor: Colors.white,
            backgroundColor: Colors.red,
            label: 'Let\'s Fun!',
            onPressed: () {
              Fluttertoast.showToast(
                  msg: "Welcome Here!",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.CENTER,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Colors.indigoAccent,
                  textColor: Colors.white,
                  fontSize: 16.0);
            },
          ),
          SpeedDialChild(
            child: const Icon(Icons.splitscreen),
            foregroundColor: Colors.black,
            backgroundColor: Colors.yellow,
            label: 'Let\'s dance!',
            onPressed: () {
              Fluttertoast.showToast(
                  msg: "Welcome Here!",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.CENTER,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Colors.indigoAccent,
                  textColor: Colors.white,
                  fontSize: 16.0);
            },
          ),
          SpeedDialChild(
            child: const Icon(Icons.twenty_mp),
            foregroundColor: Colors.white,
            backgroundColor: Colors.green,
            label: 'Let\'s play!',
            onPressed: () {
              Fluttertoast.showToast(
                  msg: "Welcome Here!",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.CENTER,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Colors.indigoAccent,
                  textColor: Colors.white,
                  fontSize: 16.0);
            },
          ),
        ],
        closedForegroundColor: Colors.black,
        openForegroundColor: Colors.white,
        closedBackgroundColor: Colors.white,
        openBackgroundColor: Colors.black,
      ),
    );
  }
}
