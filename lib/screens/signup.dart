import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:task1/screens/mainpage.dart';
import 'package:task1/screens/news.dart';
import 'package:task1/screens/signin.dart';
import 'package:task1/services/localData.dart';
import 'package:task1/utilities.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';

class Signup extends StatefulWidget {
  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  var emailController = TextEditingController();
  var pwdController = TextEditingController();
  var confpwdController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  bool isLoading = false;
  LocalData localData = LocalData();

  signup() async {
    if (formKey.currentState.validate()) {
      print("validateddddddd");
      setState(() {
        isLoading = true;
      });

      var jsonData;
      final data = jsonEncode({
        'email': emailController.text.trim(),
        'password': pwdController.text.trim(),
      });

      final response = await http.post(
          Uri.parse('https://www.getpostman.com/collections/299632c9a18ed457ba78'),
          body: data
      );
      print("response :${response.statusCode}");
      if (response.statusCode == 200) {
        jsonData = json.decode(response.body);
        setState(() {
          isLoading = true;
          Fluttertoast.showToast(
              msg: "Successfully Signed up",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.grey,
              textColor: Colors.white,
              fontSize: 16.0
          );
        });
        await localData.saveUserEmail(emailController.text.trim());
        await localData.saveUserPassword(pwdController.text.trim());
        await localData.saveUserLoggedIn(true);

        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => MainPage()));
      }
      else {
        print("error");
        print(response.statusCode);
      }
    }
    else {
      setState(() {
        isLoading = false;
        Fluttertoast.showToast(
            msg: "Check your credentials",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.grey,
            textColor: Colors.white,
            fontSize: 16.0
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.grey,
        body: isLoading ? Container(
          child: Center(child: CircularProgressIndicator()),
        ) : AnnotatedRegion<SystemUiOverlayStyle>(
          value: SystemUiOverlayStyle.light,
          child: Stack(
            children: <Widget>[
              Container(
                height: MediaQuery.of(context).size.height * 0.5,
                color: Colors.grey,
                child: Center(child: Text('Welcome!!', style: TextStyle(color: Colors.white, fontSize: 30, fontWeight: FontWeight.bold),)),
              ),
              Container(
                margin: const EdgeInsets.only(top: 400),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(110),
                      topRight: Radius.circular(110),
                    ),
                    color: Colors.white
                ),
                child: Column(
                  children: <Widget>[
                    Center(
                        child: Text(
                          "Sign up",
                          style: headStyle,
                        )),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.04,),
                    Form(
                      key: formKey,
                      child: Column(
                        children: <Widget>[
                          Container(
                            width: MediaQuery.of(context).size.width * 0.7,
                            height: MediaQuery.of(context).size.height * 0.05,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Color(0xFFBD9A7A),
                            ),

                            child: TextFormField(
                                controller: emailController,
                                validator: (val) {
                                  return val.isEmpty
                                      ? 'Above value is required'
                                      : null;
                                },
                                style: TextStyle(color: Colors.white),
                                decoration: InputDecoration(
                                    hintText: 'Email:',
                                    hintStyle: TextStyle(color: Colors.white),
                                    border: InputBorder.none
                                )
                            ),
                          ),
                          SizedBox(height: MediaQuery.of(context).size.height * 0.01,),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.7,
                            height: MediaQuery.of(context).size.height * 0.05,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Color(0xFFBD9A7A),
                            ),
                            child: TextFormField(
                                controller: pwdController,
                                obscureText: true,
                                validator: (val) {
                                  return val.length < 6 || val.isEmpty
                                      ? "Enter Password 6+ characters"
                                      : null;
                                },
                                style: TextStyle(color: Colors.white),
                                decoration: InputDecoration(
                                    hintText: 'Password:',
                                    hintStyle: TextStyle(color: Colors.white),
                                    border: InputBorder.none
                                )),
                          ),
                          SizedBox(height: MediaQuery.of(context).size.height * 0.01,),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.7,
                            height: MediaQuery.of(context).size.height * 0.05,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Color(0xFFBD9A7A),
                            ),

                            child: Container(
                              child: TextFormField(
                                  controller: confpwdController,
                                  obscureText: true,
                                  validator: (val) {
                                    return val.isEmpty || val != pwdController.text
                                        ? 'Password is not matching'
                                        : null;
                                  },
                                  style: TextStyle(color: Colors.white),
                                  decoration: InputDecoration(
                                      hintText: 'Re-enter Password:',
                                      hintStyle: TextStyle(color: Colors.white),
                                      border: InputBorder.none
                                  )
                              ),
                            ),
                          ),

                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 20),
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.4,
                              height: 40,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: Colors.blue),
                              child: FlatButton(
                                child: Text("Sign up",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 20)),
                                 onPressed: () => signup(),
                              ),
                            ),
                          ),
                          Row(
                            children: <Widget>[
                              Expanded(
                                child: Divider(color: Colors.grey,),
                              ),
                              Text(
                                'Or Sign Up With',
                                style: TextStyle(fontSize: 15),
                              ),
                              Expanded(child: Divider(color: Colors.grey, ))
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                child: Image(
                                  image: AssetImage(
                                    'assets/images/google.png',
                                  ),
                                  height: MediaQuery.of(context).size.height * 0.05,
                                  width: MediaQuery.of(context).size.height * 0.05,
                                ),
                              ),
                              Container(
                                child: Image(
                                  image: AssetImage(
                                    'assets/images/facebook.png',
                                  ),
                                  height: MediaQuery.of(context).size.height * 0.07,
                                  width: MediaQuery.of(context).size.height * 0.07,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                "Have an account?",
                                style: TextStyle(fontSize: 15),
                              ),
                              FlatButton(
                                  child: Text("Sign In",
                                      style: TextStyle(
                                          color: Colors.orange, fontSize: 15)),
                                  onPressed: () => Navigator.pushReplacement(
                                      context, MaterialPageRoute(
                                    builder: (context) => Signin(),
                                  )
                                  ))
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        )
    );
  }
}
