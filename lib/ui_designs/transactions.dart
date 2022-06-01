// ignore_for_file: prefer_typing_uninitialized_variables

import 'dart:developer';

import 'package:expense_tracker/database/database.dart';
import 'package:expense_tracker/model/transactionModel.dart';
import 'package:flutter/material.dart';

import 'new_expense.dart';

class Transactions extends StatefulWidget {
  const Transactions({Key? key}) : super(key: key);

  @override
  _TransactionsState createState() => _TransactionsState();
}

class _TransactionsState extends State<Transactions> {
  var _databaseprovider;

  late Future<List<TransactionModel>> transactionsList;

  @override
  void initState() {
    super.initState();
    _databaseprovider = Databaseprovider.instance;
    refreshData();
  }

  refreshData() {
    setState(() {
      getTransaction();
    });
  }

  getTransaction() {
    setState(() {
      transactionsList = _databaseprovider.getAllTransactions();
      log('Data from categoryList $transactionsList');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                      Colors.greenAccent,
                      Colors.indigoAccent,
                    ],
                  ),
                ),
                child: Column(
                  children: const [
                    SizedBox(
                      height: 38,
                    ),
                    Text(
                      ' 🛍💰  Transactions    🕵️‍♀️',
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
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
                      Colors.greenAccent,
                      Colors.indigoAccent,
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
                    SizedBox(height: 22),
                    Text('💰 All Transactions Below  🕵️‍♀️'),
                  ],
                ),
              ),
            ],
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 460,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [
                      Colors.greenAccent,
                      Colors.cyanAccent,
                    ],
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: FutureBuilder(
                  future: transactionsList,
                  builder: (BuildContext context,
                      AsyncSnapshot<List<TransactionModel>> snapshot) {
                    if (snapshot.hasData) {
                      log('Length of transaction $snapshot.data?.length');
                      return ListView.builder(
                        itemCount: snapshot.data?.length,
                        itemBuilder: (BuildContext context, int index) {
                          TransactionModel transactionModel =
                              snapshot.data![index];
                          log(' Date $transactionModel.datenow');
                          return Card(
                            elevation: 0.8,
                            child: Column(
                              children: [
                                const SizedBox(
                                  height: 2,
                                ),
                                Row(
                                  children: [
                                    const SizedBox(width: 7),
                                    Text(
                                      transactionModel.date,
                                      style: const TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'Times New Roman',
                                      ),
                                    ),
                                    const SizedBox(width: 170),
                                    Text(
                                      transactionModel.transactionType,
                                      style: const TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'Times New Roman',
                                      ),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 6, right: 6, bottom: 1),
                                  child: Container(
                                    color: Colors.white,
                                    child: Row(
                                      children: [
                                        Container(
                                          color: Colors.white,
                                          width: 210,
                                          child: Text(
                                            transactionModel.categoryType,
                                            style: const TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,
                                              fontFamily: 'Times New Roman',
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 27,
                                        ),
                                        Container(
                                          color: Colors.white,
                                          width: 70,
                                          child: Text(
                                            '₹ ${transactionModel.amount}',
                                            style: const TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.green,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.only(left: 7.0, top: 2),
                                  child: Row(
                                    children: [
                                      Container(
                                        color: Colors.white,
                                        width: 230,
                                        // color: Colors.amber,
                                        child: Text(
                                          transactionModel.description,
                                          style: const TextStyle(
                                            fontSize: 11,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: 'Times New Roman',
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 8, right: 10, bottom: 6, top: 5),
                                  child: Container(
                                    color: Colors.white,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          color: Colors.white,
                                          height: 25,
                                          width: 100,
                                          child: MaterialButton(
                                            color: Colors.grey[200],
                                            onPressed: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      NewExpense(
                                                    title: 'Update Category',
                                                    newexpenseModel:
                                                        transactionModel,
                                                    buttonName: 'Update',
                                                  ),
                                                ),
                                              );
                                            },
                                            child: const Icon(
                                              Icons.update,
                                              color: Colors.blue,
                                            ),
                                          ),
                                        ),
                                        Container(
                                          color: Colors.white,
                                          height: 25,
                                          width: 100,
                                          child: MaterialButton(
                                            color: Colors.grey[200],
                                            onPressed: () {
                                              _databaseprovider
                                                  .deleteTransaction(
                                                      transactionModel.id);
                                              refreshData();
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                                const SnackBar(
                                                  content:
                                                      Text('Category Deleted'),
                                                  duration:
                                                      Duration(seconds: 1),
                                                ),
                                              );
                                            },
                                            child: const Icon(
                                              Icons.delete,
                                              color: Colors.red,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    } else {
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
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
        ],
      ),
    );
  }
}
