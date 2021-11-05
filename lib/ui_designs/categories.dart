import 'package:flutter/material.dart';

import 'expense.dart';
import 'income.dart';
import 'add_category.dart';

class Categories extends StatefulWidget {
  const Categories({Key? key}) : super(key: key);

  @override
  _CategoriesState createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          body: Column(
            children: [
              Stack(
                children: [
                  Container(
                    height: 90,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.indigoAccent,
                          Colors.greenAccent,
                        ],
                      ),
                    ),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 38,
                        ),
                        Text(
                          ' 🛍💰  Categories    🕵️‍♀️',
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
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.indigoAccent,
                          Colors.greenAccent,
                        ],
                      ),
                    ),
                  ),
                  Container(
                    height: 65,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(colors: [
                        Colors.cyanAccent,
                        Colors.indigoAccent,
                      ]),
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(70),
                        topLeft: Radius.circular(70),
                      ),
                    ),
                    child: TabBar(
                      labelStyle: TextStyle(
                        color: Colors.black,
                        fontSize: 19,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Times New Roman',
                        shadows: [
                          Shadow(
                            offset: Offset(2, 0),
                          ),
                        ],
                      ),
                      tabs: [
                        Tab(
                            icon: Icon(
                              Icons.account_balance_wallet_outlined,
                            ),
                            text: "Expense"),
                        Tab(
                          icon: Icon(
                            Icons.attach_money_outlined,
                          ),
                          text: "Income",
                        )
                      ],
                    ),
                  ),
                ],
              ),
              Expanded(
                child: Stack(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.blue,
                      ),
                      child: Container(
                        child: TabBarView(
                          children: [
                            Expense(),
                            Income(),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          floatingActionButton: FloatingActionButton.extended(
            backgroundColor: const Color(0xff03dac6),
            foregroundColor: Colors.black,
            icon: Icon(Icons.add, size: 24),
            label: Text(
              'Add Category',
              style: TextStyle(
                fontSize: 10,
                fontFamily: 'Times New Roman',
                fontWeight: FontWeight.bold,
              ),
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Addcategory(
                    title: '',
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
