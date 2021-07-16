import 'package:flutter/material.dart';
import 'package:task1/screens/mainpage.dart';
import 'package:task1/screens/news.dart';
import 'package:task1/screens/signin.dart';
import 'package:task1/screens/signup.dart';
import 'package:task1/services/localData.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  LocalData localData = LocalData();
  bool isLoggedIn = false;

  autoLogin() async{
    print("Logged1 $isLoggedIn");
    if(await localData.getUserEmail() != null){
      setState(() {
        localData.saveUserLoggedIn(true);
        isLoggedIn = true;

      });
      //print("Logged2 $isLoggedIn");
    }
  }

  @override
  void initState() {
    autoLogin();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      home: isLoggedIn ? Signup() : MainPage(),
    );
  }
}
