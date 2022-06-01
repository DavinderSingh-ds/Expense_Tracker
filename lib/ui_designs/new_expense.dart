// ignore_for_file: prefer_typing_uninitialized_variables

import 'dart:developer';

import 'package:expense_tracker/database/database.dart';
import 'package:expense_tracker/model/model.dart';
import 'package:expense_tracker/model/transactionModel.dart';
import 'package:flutter/material.dart';

class NewExpense extends StatefulWidget {
  const NewExpense({
    Key? key,
    required this.title,
    this.newexpenseModel,
    this.buttonName,
  }) : super(key: key);
  final String title;
  final TransactionModel? newexpenseModel;
  final String? buttonName;

  @override
  _NewExpenseState createState() => _NewExpenseState();
}

class _NewExpenseState extends State<NewExpense> {
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  final GlobalKey _formKey = GlobalKey();
  String? dropdownValue;

  final _databaseProvider = Databaseprovider.instance;
  late Future<List<Categorymodel>> expensedList;

  DateTime selectedDate = DateTime.now();
  var pickedDate;
  var typeOfTransaction = 'Expense';

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {});
    refreshhData();
  }

  refreshhData() {
    log('Inside of the refresData Function');
    setState(() {
      getCategories();
    });
  }

  getCategories() {
    log('Inside of the getCategories Function');
    setState(() {
      expensedList = _databaseProvider.retriveTransactionCategoriesbyExpense();
      log('Expesne List Data ${expensedList.toString()}');
    });
  }

  _selectedDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2040),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        pickedDate =
            "${picked.toLocal().day}/${picked.toLocal().month}/${picked.toLocal().year}";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        decoration: BoxDecoration(
          color: Colors.grey[200],
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.only(top: 29, left: 14, right: 14),
            child: Expanded(
              child: Container(
                height: 480,
                width: 350,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: const [
                    BoxShadow(
                      blurRadius: 10,
                      color: Colors.blueAccent,
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(
                        top: 25,
                        bottom: 10,
                      ),
                      child: Text(
                        'ADD NEW EXPENSE HERE',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          // fontFamily: 'Times New Roman',
                          shadows: [
                            Shadow(
                              blurRadius: 1,
                            ),
                          ],
                        ),
                      ),
                    ),
                    Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          const SizedBox(
                            height: 2,
                          ),
                          Row(
                            children: [
                              const SizedBox(width: 6),
                              Icon(
                                Icons.category_outlined,
                                color: Colors.grey[600],
                              ),
                              const SizedBox(width: 18),
                              Container(
                                color: Colors.white,
                                height: 50,
                                width: 275,
                                child: FutureBuilder(
                                  future: expensedList,
                                  builder: (BuildContext context,
                                      AsyncSnapshot<List<Categorymodel>>
                                          expenseSnapshot) {
                                    if (expenseSnapshot.hasData) {
                                      log('${expenseSnapshot.data}');
                                      return DropdownButton(
                                        value: dropdownValue,
                                        elevation: 12,
                                        isExpanded: true,
                                        hint: const Text('Select Category'),
                                        underline: Container(
                                          height: 2,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .secondary,
                                        ),
                                        onChanged: (String? newValue) {
                                          setState(() {
                                            dropdownValue = newValue!;
                                          });
                                        },
                                        items:
                                            expenseSnapshot.data!.map((value) {
                                          return DropdownMenuItem<String>(
                                            value: value.categoryname,
                                            child: Text(value.categoryname),
                                          );
                                        }).toList(),
                                      );
                                    } else {
                                      return const Text('No Data');
                                    }
                                  },
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 8, right: 8, bottom: 8),
                            child: GestureDetector(
                              onTap: () => _selectedDate(context),
                              child: AbsorbPointer(
                                child: TextFormField(
                                  onSaved: (d) {
                                    d = selectedDate as String?;
                                  },
                                  controller: _dateController,
                                  decoration: InputDecoration(
                                    labelText: (pickedDate == null)
                                        ? '${selectedDate.day}-${selectedDate.month}-${selectedDate.year}'
                                        : pickedDate,
                                    icon: const Icon(
                                        Icons.calendar_today_rounded),
                                  ),
                                  // validator: (value) {
                                  //   if (value!.isEmpty) {
                                  //     return 'Please Select date first';
                                  //   }
                                  //   return null;
                                  // },
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextFormField(
                              controller: _amountController,
                              validator: (s) {
                                if (s!.isEmpty) {
                                  return 'Enter the above field First';
                                }
                                return null;
                              },
                              keyboardType: TextInputType.number,
                              decoration: const InputDecoration(
                                labelText: 'Amount',
                                hintText: 'Enter Amount',
                                icon:
                                    Icon(Icons.account_balance_wallet_rounded),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextFormField(
                              controller: _descriptionController,
                              validator: (des) {
                                if (des!.isEmpty) {
                                  return 'Enter the above field First';
                                }
                                return null;
                              },
                              decoration: const InputDecoration(
                                labelText: 'Description',
                                hintText: '',
                                icon: Icon(Icons.description_outlined),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: MaterialButton(
                              color: Theme.of(context).colorScheme.secondary,
                              child: Text(
                                widget.buttonName != null
                                    ? widget.buttonName!
                                    : 'Save',
                                style: const TextStyle(color: Colors.white),
                              ),
                              onPressed: () {
                                final FormState? formm =
                                    _formKey.currentState as FormState?;
                                if (formm!.validate()) {
                                  log('Expense is ${_amountController.text.toString()}');
                                  final newexpensess = TransactionModel(
                                    amount: _amountController.text.toString(),
                                    description:
                                        _descriptionController.text.toString(),
                                    categoryType: dropdownValue.toString(),
                                    date: pickedDate,
                                    transactionType: typeOfTransaction,
                                  );

                                  if (_amountController.text
                                      .toString()
                                      .isNotEmpty) {
                                    var catId = _databaseProvider
                                        .addTransaction(newexpensess);
                                    log(catId.toString());
                                  }
                                  if (widget.newexpenseModel != null) {
                                    newexpensess.id =
                                        widget.newexpenseModel!.id;
                                    _databaseProvider
                                        .updateTransaction(newexpensess);
                                  }
                                  Navigator.pop(context);
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
