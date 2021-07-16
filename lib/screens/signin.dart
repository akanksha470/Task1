import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:task1/screens/mainpage.dart';
import 'package:task1/screens/signup.dart';
import 'package:task1/services/localData.dart';
import 'package:task1/services/userModel.dart';
import 'package:task1/utilities.dart';
import 'package:http/http.dart' as http;

class Signin extends StatefulWidget {
  @override
  _SigninState createState() => _SigninState();
}

class _SigninState extends State<Signin> {
  var emailController = TextEditingController();
  var pwdController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  bool isLoading = false;
  LocalData localData = LocalData();
  List<User> usersList = List<User>();
 var flag = 0;

  Future<List<User>> fetchUsers() async {
    usersList = List<User>();
    http.Response response =  await http.get(Uri.parse('https://www.getpostman.com/collections/299632c9a18ed457ba78'));
    if (response.statusCode != 200) {
      print(response.body);
      throw Exception();
    }
    var jsonDecoded = await jsonDecode(response.body);
    List<dynamic> jsonlist = jsonDecoded['item'];
    usersList = jsonlist.map((i) => User.fromJson(i)).toList();
    print(usersList);

  }

    signin() async {
      if (formKey.currentState.validate()) {
        print("validateddddddd");
        setState(() {
          isLoading = true;
          flag = 0;
        });
        usersList.forEach((u) async {
          if(u.email == emailController.text.trim() && u.password == pwdController.text.trim()){
            flag = 1;
            setState(() {
              isLoading = true;
              Fluttertoast.showToast(
                  msg: "Successfully Signed in",
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

        });

        if(flag == 0){
          setState(() {
            isLoading = false;
          });
          Fluttertoast.showToast(
              msg: "User not found",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.grey,
              textColor: Colors.white,
              fontSize: 16.0
          );
        }
      }

    }

  @override
  void initState() {
    super.initState();
    fetchUsers();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
        backgroundColor: Colors.grey,
    body: isLoading ? Center(child: CircularProgressIndicator()) :
    AnnotatedRegion<SystemUiOverlayStyle>(
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
                  "Sign in",
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
                      SizedBox(height: MediaQuery.of(context).size.height * 0.02,),
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
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Container(
                            alignment: Alignment.centerRight,
                            child: GestureDetector(
                              child: Text(
                                "Forgot Password",
                                style: TextStyle(
                                    color: Color(0xFF071A3F),
                                    decoration: TextDecoration.underline,
                                    fontSize: 15),
                              ),
                              onTap: () {},
                            )),
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
                            child: Text("Sign In",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 20)),
                            onPressed: () => signin(),
                          ),
                        ),
                      ),
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: Divider(color: Colors.grey,),
                          ),
                          Text(
                            'Or Sign In With',
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
                            "Don't have an account?",
                            style: TextStyle(fontSize: 15),
                          ),
                          FlatButton(
                              child: Text("Sign Up",
                                  style: TextStyle(
                                      color: Colors.orange, fontSize: 15)),
                              onPressed: () => Navigator.pushReplacement(
                              context, MaterialPageRoute(
                            builder: (context) => Signup(),
                          ))
                          )
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
