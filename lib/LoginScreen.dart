// ignore_for_file: prefer_typing_uninitialized_variables, file_names

import 'dart:async';
import 'dart:developer';

import 'package:expense_tracker/ui_designs/myhomepage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'SignUpScreen.dart';
import 'Widgets/InputTextWidget.dart';
import 'database/Database2.dart';
import 'database/SessionTable.dart';
import 'database/UsersTable.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<LoginScreen> {
  final TextEditingController _pwdController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final GlobalKey _formKey = GlobalKey<FormState>();

  var _databaseprovider;

  late Future<List<UsersModel>> signUpdetailList;
  late Future<List<SessionModel>> getAllSessionDetail;

  @override
  void initState() {
    super.initState();
    _databaseprovider = Databaseprovider.instance;
  }

  void onLogin() async {
    var email = _emailController.text.toString();
    var password = _pwdController.text.toString();
    var user =
        await _databaseprovider.getUserByEmailAndPassword(email, password);
    log('user details are: $user');

    if (user == Null) {
      Fluttertoast.showToast(
          msg: "Invalid credentials",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.blue,
          textColor: Colors.white,
          fontSize: 16.0);
      return;
    }

    final autoLoginUserData = SessionModel(
      userEmail: user['email'],
      userPassword: user['passwrd'],
      confirmPassword: user['cnfpsswrd'],
      userName: user['name'],
    );

    log('autoLoginUserData: $autoLoginUserData');

    await _databaseprovider.addSessionDetails(autoLoginUserData);
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const MyHomePage(title: 'Dogs_Diary'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    const double r = (175 / 360);
    final coverHeight = screenWidth * r;

    final widgetList = [
      Row(
        children: const [
          SizedBox(
            width: 16,
          ),
          Text(
            'Welcome',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xff000000),
            ),
            textAlign: TextAlign.left,
          ),
        ],
      ),
      const SizedBox(
        height: 16.0,
      ),
      Form(
          key: _formKey,
          child: Column(
            children: [
              InputTextWidget(
                controller: _emailController,
                labelText: "Email Address",
                icon: Icons.email,
                obscureText: false,
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(
                height: 16,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 16, right: 16),
                child: Container(
                  color: Colors.white,
                  child: Material(
                    elevation: 1.0,
                    shadowColor: Colors.black,
                    borderRadius: BorderRadius.circular(15.0),
                    child: Padding(
                      padding: const EdgeInsets.only(right: 20.0, left: 15.0),
                      child: TextFormField(
                          obscureText: true,
                          textInputAction: TextInputAction.done,
                          autofocus: false,
                          keyboardType: TextInputType.text,
                          decoration: const InputDecoration(
                            icon: Icon(
                              Icons.lock,
                              color: Colors.black,
                              size: 24.0,
                            ),
                            labelText: "Enter password",
                            labelStyle: TextStyle(
                                color: Colors.black54, fontSize: 14.0),
                            hintText: '',
                            enabledBorder: InputBorder.none,
                            border: InputBorder.none,
                          ),
                          controller: _pwdController,
                          validator: (val) {
                            if (val!.isEmpty) {
                              return 'type a password';
                            }
                            return null;
                          }),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 16, top: 16),
                child: Align(
                    alignment: Alignment.topRight,
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: () {},
                        child: Text(
                          "Forgot password?",
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey[700]),
                        ),
                      ),
                    )),
              ),
              const SizedBox(
                height: 16,
              ),
              Container(
                color: Colors.white,
                height: 50.0,
                child: ElevatedButton(
                  onPressed: () async {
                    final FormState? formm =
                        _formKey.currentState as FormState?;
                    if (formm!.validate()) {
                      onLogin();
                    }
                    return;
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.white,
                    elevation: 0.0,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(0)),
                    ),
                  ),
                  child: Ink(
                    decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(10.0)),
                    child: Container(
                      alignment: Alignment.center,
                      child: const Text(
                        "Sign in",
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          )),
      const SizedBox(
        height: 16,
      ),
      Container(
        color: Colors.white,
        height: 50.0,
        child: Center(
            child: Wrap(
          children: [
            Text(
              "Don't have an account? ",
              style: TextStyle(
                  color: Colors.grey[600], fontWeight: FontWeight.bold),
            ),
            Material(
                child: InkWell(
              onTap: () => Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const SignUpScreen(),
              )),
              child: Text(
                "Sign Up",
                style: TextStyle(
                  color: Colors.blue[800],
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
            )),
          ],
        )),
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 16, top: 16),
            child: Container(
              decoration: BoxDecoration(
                  boxShadow: const <BoxShadow>[
                    BoxShadow(
                        color: Colors.grey, //Color(0xfff05945),
                        offset: Offset(0, 0),
                        blurRadius: 5.0),
                  ],
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12.0)),
              width: (screenWidth / 2) - 40,
              height: 55,
              child: Material(
                borderRadius: BorderRadius.circular(12.0),
                child: InkWell(
                  onTap: () {
                    log("facebook tapped");
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Image.asset(
                          "images/fb.png",
                          fit: BoxFit.cover,
                        ),
                        const SizedBox(
                          width: 7.0,
                        ),
                        const Text(
                          "Sign in",
                          style: TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 16, top: 16),
            child: Container(
              decoration: BoxDecoration(
                  boxShadow: const <BoxShadow>[
                    BoxShadow(
                        color: Colors.grey,
                        offset: Offset(0, 0),
                        blurRadius: 5.0),
                  ],
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12.0)),
              width: (screenWidth / 2) - 40,
              height: 55,
              child: Material(
                borderRadius: BorderRadius.circular(12.0),
                child: InkWell(
                  onTap: () {
                    log("google tapped");
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Image.asset(
                          "images/google.png",
                          fit: BoxFit.cover,
                        ),
                        const SizedBox(
                          width: 7.0,
                        ),
                        const Text(
                          "Sign in",
                          style: TextStyle(
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      const SizedBox(
        height: 15.0,
      ),
    ];
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            expandedHeight: coverHeight - 25,
            flexibleSpace: FlexibleSpaceBar(
              background: Image.asset(
                "images/covver.jpg",
                fit: BoxFit.cover,
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Container(
                  width: screenWidth,
                  height: 25,
                  color: Colors.grey[100],
                ),
              ],
            ),
          ),
          SliverList(
              delegate:
                  SliverChildBuilderDelegate((BuildContext context, int index) {
            return widgetList[index];
          }, childCount: widgetList.length))
        ],
      ),
    );
  }
}
