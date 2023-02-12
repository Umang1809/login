import 'package:flutter/material.dart';
import 'package:flutter_password_strength/flutter_password_strength.dart';
import 'package:login/dbclass.dart';
import 'package:login/main.dart';
import 'package:sqflite/sqflite.dart';

class reg extends StatefulWidget {
  const reg({Key? key}) : super(key: key);

  @override
  State<reg> createState() => _regState();
}

class _regState extends State<reg> {
  TextEditingController cname = TextEditingController();
  TextEditingController cnumber = TextEditingController();
  TextEditingController cemail = TextEditingController();
  TextEditingController cpassword = TextEditingController();
  TextEditingController ccorrectpassword = TextEditingController();
  String? nameer;
  String? numberer;
  String? emailer;
  String? passworder;
  String? correctpassworder;
  String? password;
  bool sname = false;
  bool snumber = false;
  bool semail = false;
  bool spassword = false;
  bool scorrectpassword = false;
  bool passvisible = true;
  bool cpassvisible = true;
  String ps = "";
  int isnum = 1;
  String gender = "";
  Database? db;

  @override
  void initState() {
    // TODO: implement initState
    isnum = 1;
    forDataBase();
  }

  void forDataBase() {
    dbclass().getdb().then((value) {
      db = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xFF65647C),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.transparent,
        appBar: AppBar(
            title: Text("Wel-Come"),
            centerTitle: true,
            backgroundColor: Color(0xFFBA94D1)),
        body: Card(
          color: Colors.transparent,
          elevation: 50,
          child: Container(
            margin: EdgeInsets.all(30),
            decoration: BoxDecoration(
                border: Border.all(
                  width: 1,
                  style: BorderStyle.solid,
                ),
                borderRadius: BorderRadius.circular(25),
                color: Color(0xFF8B7E74)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  height: 30,
                ),
                // Container(
                //   margin: EdgeInsets.fromLTRB(0, 50, 0, 0),
                //   // color: Colors.red,
                //   height: 100,
                //   width: 100,
                //   decoration: ShapeDecoration(
                //       color: Colors.red,
                //       shape: CircleBorder(side: BorderSide(width: 1)),
                //       image: DecorationImage(image: AssetImage("Imagee/dp.png"))),
                // ),
                Expanded(
                  child: Container(
                    margin: EdgeInsets.all(20),
                    child: TextField(
                      onTap: () {
                        setState(() {
                          sname = false;
                        });
                      },
                      controller: cname,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                          Radius.circular(50),
                        )),
                        labelText: "Enter Your Name ",
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Color(0xFFBA94D1), width: 3.0),
                        ),
                        labelStyle: TextStyle(color: Colors.black),
                        prefixIcon: Icon(Icons.person_outline),
                        errorText: sname ? nameer : null,
                      ),
                      keyboardType: TextInputType.text,
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    margin: EdgeInsets.all(20),
                    child: TextField(
                      onTap: () {
                        setState(() {
                          snumber = false;
                        });
                      },
                      controller: cnumber,
                      maxLength: 10,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(50))),
                        labelText: "Enter Mobile Number",
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Color(0xFFBA94D1), width: 3.0),
                        ),
                        labelStyle: TextStyle(
                          color: Colors.black,
                        ),
                        prefixIcon: Icon(Icons.phone),
                        errorText: snumber ? numberer : null,
                      ),
                      keyboardType: TextInputType.phone,
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    margin: EdgeInsets.all(20),
                    child: TextField(
                      onTap: () {
                        setState(() {
                          semail = false;
                        });
                      },
                      controller: cemail,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(50))),
                        labelText: "Enter Email ID",
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Color(0xFFBA94D1), width: 3.0),
                        ),
                        labelStyle: TextStyle(color: Colors.black),
                        prefixIcon: Icon(Icons.email_outlined),
                        errorText: semail ? emailer : null,
                      ),
                      keyboardType: TextInputType.emailAddress,
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    margin: EdgeInsets.all(20),
                    child: TextField(
                      obscureText: passvisible,
                      onTap: () {
                        setState(() {
                          spassword = false;
                        });
                      },
                      onChanged: (value) {
                        setState(() {
                          ps = value;
                          password = value;
                        });
                      },
                      controller: cpassword,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(50))),
                        labelText: "Enter Password",
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Color(0xFFBA94D1), width: 3.0),
                        ),
                        labelStyle: TextStyle(color: Colors.black),
                        prefixIcon: Icon(Icons.vpn_key_outlined),
                        suffixIcon: InkWell(
                            onTap: () {
                              setState(() {
                                passvisible = !passvisible;
                              });
                            },
                            child: Icon(passvisible
                                ? Icons.visibility_off_outlined
                                : Icons.visibility_outlined)),
                        errorText: spassword ? passworder : null,
                        errorMaxLines: 2,
                      ),
                      keyboardType: TextInputType.text,
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(70, 0, 70, 0),
                  child: StatefulBuilder(
                    builder: (context, setState) {
                      return FlutterPasswordStrength(
                          password: ps,
                          strengthCallback: (strength) {
                            debugPrint(strength.toString());
                          });
                    },
                  ),
                ),
                Expanded(
                  child: Container(
                    margin: EdgeInsets.all(20),
                    child: TextField(
                      onTap: () {
                        setState(() {
                          scorrectpassword = false;
                        });
                      },
                      obscureText: cpassvisible,
                      controller: ccorrectpassword,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(50))),
                        labelText: "Enter Confirm Password",
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Color(0xFFBA94D1), width: 3.0),
                        ),
                        labelStyle: TextStyle(color: Colors.black),
                        prefixIcon: Icon(Icons.vpn_key_outlined),
                        suffixIcon: InkWell(
                            onTap: () {
                              setState(() {
                                cpassvisible = !cpassvisible;
                              });
                            },
                            child: Icon(cpassvisible
                                ? Icons.visibility_off_outlined
                                : Icons.visibility_outlined)),
                        errorText: scorrectpassword ? correctpassworder : null,
                      ),
                      keyboardType: TextInputType.text,
                    ),
                  ),
                ),

                Expanded(
                  child: Container(
                    margin: EdgeInsets.all(20),
                    child: Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(child: Text("Male")),
                          Expanded(
                            child: Radio(
                              value: gender,
                              groupValue: "Male",
                              onChanged: (value) {
                                setState(() {
                                  gender = "Male";
                                });
                              },
                            ),
                          ),
                          SizedBox(
                            width: 25,
                          ),
                          Expanded(child: Text("Female")),
                          Expanded(
                            child: Radio(
                              value: gender,
                              groupValue: "Female",
                              onChanged: (value) {
                                setState(() {
                                  gender = "Female";
                                });
                              },
                            ),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Expanded(child: Text("Others")),
                          Expanded(
                            child: Radio(
                              value: gender,
                              groupValue: "Others",
                              onChanged: (value) {
                                setState(() {
                                  gender = "Others";
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                      margin: EdgeInsets.fromLTRB(10, 0, 0, 10),
                      padding: EdgeInsets.all(20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Expanded(
                            child: ElevatedButton(
                                style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all(
                                        Color(0xFFBA94D1)),
                                    padding: MaterialStateProperty.all(
                                        EdgeInsets.all(5)),
                                    shape: MaterialStateProperty.all<
                                            RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(18.0),
                                            side: BorderSide(
                                                color: Colors.black)))),
                                onPressed: () {
                                  Navigator.pushReplacement(context,
                                      MaterialPageRoute(
                                    builder: (context) {
                                      return login();
                                    },
                                  ));
                                },
                                child: Center(
                                    child: Text(
                                  "GO BACK TO LOGIN",
                                  style: TextStyle(color: Colors.black),
                                ))),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: ElevatedButton(
                                style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all(
                                        Color(0xFFBA94D1)),
                                    padding: MaterialStateProperty.all(
                                        EdgeInsets.all(5)),
                                    shape: MaterialStateProperty.all<
                                            RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(18.0),
                                            side: BorderSide(
                                                color: Colors.black)))),
                                onPressed: () {
                                  setState(() {
                                    String name = cname.text;
                                    String number = cnumber.text;
                                    String email = cemail.text;
                                    // String password = cpassword.text;
                                    String correctpassword =
                                        ccorrectpassword.text;

                                    if (name.isEmpty) {
                                      sname = true;
                                      nameer = "Please Enter Name";
                                    } else if (!RegExp('[a-zA-Z]')
                                        .hasMatch(name)) {
                                      sname = true;
                                      nameer =
                                          "First Character Must be Alphabet";
                                    } else if (name.length < 5) {
                                      sname = true;
                                      nameer = "Name Must be 5 character long";
                                    } else {
                                      sname = false;
                                    }

                                    if (number.isEmpty) {
                                      snumber = true;
                                      numberer = "Please Enter Number";
                                    } else if (number.length != 10) {
                                      snumber = true;
                                      numberer = "Please Enter Valid Number";
                                    } else if (!number.isEmpty &&
                                        number.length == 10) {
                                      dbclass()
                                          .getNumber(number, db!)
                                          .then((value) {
                                        setState(() {
                                          if (value.length != 0) {
                                            snumber = true;
                                            numberer =
                                                "This Number is Alredy Registered with Us.";
                                            isnum = 1;
                                          } else {
                                            snumber = false;
                                            isnum = 0;
                                          }
                                        });
                                      });
                                    } else {
                                      snumber = false;
                                    }

                                    if (email.isEmpty) {
                                      semail = true;
                                      emailer = "Please Enter Email";
                                    } else if (!RegExp(
                                            r'^.+@[a-zA-Z]+\.{1}[a-zA-Z]+(\.{0,1}[a-zA-Z]+)$')
                                        .hasMatch(email)) {
                                      semail = true;
                                      emailer = "Please Enter Valid Email";
                                    } else {
                                      semail = false;
                                    }

                                    if (ps.isEmpty) {
                                      spassword = true;
                                      passworder = "Please Enter Password";
                                    } else if (ps.length < 8) {
                                      spassword = true;
                                      passworder =
                                          "Password Must be 8 character long.";
                                    } else if (!RegExp(
                                            r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$')
                                        .hasMatch(ps)) {
                                      spassword = true;
                                      passworder =
                                          "Pleas Enter Minimum 1 Upper case, 1 lowercase, 1 Numeric Number, 1 Special Character";
                                    } else {
                                      spassword = false;
                                    }
                                    if (correctpassword.isEmpty) {
                                      scorrectpassword = true;
                                      correctpassworder =
                                          "Please Enter Confirm Password";
                                    } else if (password != correctpassword) {
                                      scorrectpassword = true;
                                      correctpassworder =
                                          "Both Password are not same";
                                    } else {
                                      scorrectpassword = false;
                                    }
                                    if (sname == false &&
                                        snumber == false &&
                                        semail == false &&
                                        spassword == false &&
                                        scorrectpassword == false &&
                                        gender != "" &&
                                        isnum == 0) {
                                      setState(() {
                                        dbclass()
                                            .InsertData(
                                                name, number, email, ps, db)
                                            .then((value) {
                                          Navigator.pushReplacement(context,
                                              MaterialPageRoute(
                                            builder: (context) {
                                              return login();
                                            },
                                          ));
                                        });
                                      });
                                    }

                                    // RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                    //     .hasMatch(email);
                                  });
                                },
                                child: Center(
                                    child: Text(
                                  "REGISTER",
                                  style: TextStyle(color: Colors.black),
                                ))),
                          ),
                        ],
                      )),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
