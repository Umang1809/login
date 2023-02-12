import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:login/SplashScreen.dart';
import 'package:login/dbclass.dart';
import 'package:login/homepage.dart';
import 'package:login/register.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';

void main() {
  runApp(MaterialApp(
    home: SplashScreen(),
    debugShowCheckedModeBanner: false,
  ));
}

class login extends StatefulWidget {
  static SharedPreferences? pref;

  @override
  State<login> createState() => _loginState();
}

class _loginState extends State<login> {
  TextEditingController cnumber = TextEditingController();
  TextEditingController cpassword = TextEditingController();
  String number = "";
  String password = "";
  String? numberer;
  String? passworder;
  bool snumber = false;
  bool spassword = false;
  bool passvisible = true;
  Database? db;
  bool idLogin = false;

  @override
  void initState() {
    // TODO: implement initState
    forDataBase();
  }

  Future<void> forDataBase() async {
    // Obtain shared preferences.
    login.pref = await SharedPreferences.getInstance();

    idLogin = login.pref!.getBool("loginstatus") ?? false;
    if (idLogin) {
      Navigator.pushReplacement(context, MaterialPageRoute(
        builder: (context) {
          return homepage(
            login.pref!.getInt("ID"),
            login.pref!.getString("NAME"),
            login.pref!.getString("NUMBER"),
            login.pref!.getString("EMAIL"),
            login.pref!.getString("PASSWORD"),
          );
        },
      ));
    } else {
      // Navigator.pushReplacement(context, MaterialPageRoute(
      //   builder: (context) {
      //     return login();
      //   },
      // ));
    }

    dbclass().getdb().then((value) {
      setState(() {
        db = value;
      });
    });
  }

  Future<bool> onWillPop() async {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Confirm Exit ?"),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text("NO")),
            TextButton(
                onPressed: () {
                  SystemNavigator.pop();
                },
                child: Text("Yes"))
          ],
        );
      },
    );

    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xFF65647C),
      child: WillPopScope(
        onWillPop: onWillPop,
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Colors.transparent,
          appBar: AppBar(
              title: Text("Wel-Come"),
              centerTitle: true,
              backgroundColor: Color(0xFFBA94D1)),
          body: SingleChildScrollView(
            child: Card(
              color: Colors.transparent,
              elevation: 50,
              child: Container(
                margin: EdgeInsets.all(30),
                decoration: BoxDecoration(
                    border: Border.all(
                      width: 1,
                      style: BorderStyle.solid,
                    ),
                    borderRadius: BorderRadius.circular(20),
                    color: Color(0xFF8B7E74)),
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.fromLTRB(0, 70, 0, 0),
                      // color: Colors.red,
                      height: 100,
                      width: 100,
                      decoration: ShapeDecoration(
                          color: Colors.red,
                          shape: CircleBorder(side: BorderSide(width: 1)),
                          image: DecorationImage(
                              image: AssetImage("Imagee/dp.png"))),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(50, 70, 50, 20),
                      child: TextField(
                        controller: cnumber,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                            Radius.circular(50),
                          )),
                          labelText: "Mobile Number",
                          labelStyle: TextStyle(color: Colors.black),
                          prefixIcon: Icon(Icons.phone),
                          prefixText: "+91",
                          errorText: snumber ? numberer : null,
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Color(0xFFBA94D1), width: 3.0),
                          ),
                        ),
                        maxLength: 10,
                        keyboardType: TextInputType.phone,
                        onTap: () {
                          setState(() {
                            snumber = false;
                          });
                        },
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(50, 30, 50, 20),
                      child: TextField(
                        obscureText: passvisible,
                        onTap: () {
                          setState(() {
                            spassword = false;
                          });
                        },
                        controller: cpassword,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(50))),
                          labelText: "Password",
                          labelStyle: TextStyle(color: Colors.black),
                          prefixIcon: Icon(Icons.vpn_key_outlined),
                          suffixIcon: InkWell(
                              onTap: () {
                                setState(() {
                                  passvisible = !passvisible;
                                });
                              },
                              child: Icon(passvisible
                                  ? Icons.visibility_off
                                  : Icons.visibility_outlined)),
                          errorText: spassword ? passworder : null,
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Color(0xFFBA94D1), width: 3.0),
                          ),
                        ),
                        keyboardType: TextInputType.text,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(150, 10, 30, 0),
                      child: TextButton(
                          onPressed: () {},
                          child: Center(
                              child: Text(
                            "Forgot Your Password ?",
                            style: TextStyle(color: Colors.black),
                          ))),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(100, 50, 100, 20),
                      child: ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Color(0xFFBA94D1)),
                              padding:
                                  MaterialStateProperty.all(EdgeInsets.all(5)),
                              shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(18.0),
                                      side: BorderSide(color: Colors.black)))),
                          onPressed: () {
                            setState(() {
                              number = cnumber.text;
                              password = cpassword.text;
                              if (number.isEmpty) {
                                snumber = true;
                                numberer = "Please Enter Number";
                              } else if (number.length != 10) {
                                snumber = true;
                                numberer = "Please Enter Valid Number";
                              } else if (password.isEmpty) {
                                spassword = true;
                                passworder = "Please Enter Password";
                              } else {
                                dbclass()
                                    .userlogin(number, password, db!)
                                    .then((value) {
                                  if (value.length == 1) {
                                    login.pref!.setBool("loginstatus", true);
                                    login.pref!.setInt("ID", value[0]['ID']);
                                    login.pref!
                                        .setString("NAME", value[0]['NAME']);
                                    login.pref!.setString(
                                        "NUMBER", value[0]['NUMBER']);
                                    login.pref!
                                        .setString("EMAIL", value[0]['EMAIL']);
                                    login.pref!.setString(
                                        "PASSWORD", value[0]['PASSWORD']);

                                    ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                            content:
                                                Text("Login SuccessFully")));

                                    Navigator.pushReplacement(context,
                                        MaterialPageRoute(
                                      builder: (context) {
                                        return homepage(
                                          login.pref!.getInt("ID"),
                                          login.pref!.getString("NAME"),
                                          login.pref!.getString("NUMBER"),
                                          login.pref!.getString("EMAIL"),
                                          login.pref!.getString("PASSWORD"),
                                        );
                                      },
                                    ));
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                            content: Text(
                                                "User Not Founded.!,Pleas Enter Correct Details")));
                                  }
                                });
                              }
                            });
                          },
                          child: Center(
                              child: Text(
                            "LOG-IN",
                            style: TextStyle(color: Colors.black),
                          ))),
                    ),
                    Container(
                      child: TextButton(
                          onPressed: () {
                            Navigator.push(context, MaterialPageRoute(
                              builder: (context) {
                                return reg();
                              },
                            ));
                          },
                          child: Center(
                              child: Text("New User ? Click Here For Register ",
                                  style: TextStyle(color: Colors.black)))),
                    )
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
