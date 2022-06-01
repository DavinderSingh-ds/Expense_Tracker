// ignore_for_file: prefer_typing_uninitialized_variables

import 'dart:developer';

import 'package:expense_tracker/database/database.dart';
import 'package:expense_tracker/model/model.dart';
import 'package:expense_tracker/ui_designs/add_category.dart';
import 'package:flutter/material.dart';

class Expense extends StatefulWidget {
  const Expense({Key? key}) : super(key: key);

  @override
  _ExpenseState createState() => _ExpenseState();
}

class _ExpenseState extends State<Expense> {
  var _databaseprovider;

  late Future<List<Categorymodel>> categoryExpenseList;

  @override
  void initState() {
    super.initState();
    _databaseprovider = Databaseprovider.instance;
    refreshData();
  }

  refreshData() {
    setState(() {
      getCategories();
    });
  }

  getCategories() {
    setState(() {
      categoryExpenseList = _databaseprovider.retriveCategoriesbyExpense();
      log('Data from categoryList $categoryExpenseList');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.only(top: 20, bottom: 70),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 350,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [
                      Colors.cyanAccent,
                      Colors.tealAccent,
                    ],
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: FutureBuilder(
                  future: categoryExpenseList,
                  builder: (BuildContext context,
                      AsyncSnapshot<List<Categorymodel>> snapshot) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                        itemCount: snapshot.data?.length,
                        itemBuilder: (BuildContext context, int index) {
                          Categorymodel categoryModel = snapshot.data![index];
                          return Card(
                            elevation: 2,
                            child: Row(
                              children: [
                                const SizedBox(
                                  width: 4,
                                ),
                                Container(
                                  color: Colors.white,
                                  width: 253,
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        top: 20,
                                        left: 10,
                                        bottom: 20,
                                        right: 4),
                                    child: Text(
                                      snapshot.data![index].categoryname
                                          .toString(),
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontFamily: 'Times New Roman',
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => Addcategory(
                                          title: 'Update Category',
                                          categoryModel: categoryModel,
                                          buttonName: 'Update',
                                        ),
                                      ),
                                    );
                                    refreshData();
                                  },
                                  child: const Icon(
                                    Icons.update,
                                    color: Colors.blue,
                                  ),
                                ),
                                const SizedBox(
                                  width: 13,
                                ),
                                InkWell(
                                  onTap: () {
                                    _databaseprovider
                                        .deleteCategory(categoryModel.id);
                                    refreshData();
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text('Category Deleted'),
                                        duration: Duration(milliseconds: 1),
                                      ),
                                    );
                                  },
                                  child: const Icon(
                                    Icons.delete,
                                    color: Colors.red,
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
        ),
      ),
    );
  }
}
