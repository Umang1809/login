import 'package:flutter/material.dart';
import 'package:login/dbclass.dart';
import 'package:login/homepage.dart';
import 'package:login/main.dart';
import 'package:sqflite/sqflite.dart';

class updatecontact extends StatefulWidget {
  Map contact;

  updatecontact(Map this.contact);

  @override
  State<updatecontact> createState() => _updatecontactState();
}

class _updatecontactState extends State<updatecontact> {
  bool sname = false;
  bool snumber = false;
  String? nameer;
  String? numberer;
  TextEditingController cname = TextEditingController();
  TextEditingController cnumber = TextEditingController();
  Database? db;
  @override
  void initState() {
    // TODO: implement initState

    forDataBase();
    cname.text = widget.contact["NAME"];
    cnumber.text = widget.contact["NUMBER"];
  }

  forDataBase() {
    dbclass().getdb().then((value) {
      setState(() {
        db = value;
      });
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
            title: Text("Update Cotact"),
            backgroundColor: Color(0xFFBA94D1),
            centerTitle: true),
        body: Container(
          height: 400,
          margin: EdgeInsets.all(50),
          decoration: BoxDecoration(
              border: Border.all(
                width: 1,
                style: BorderStyle.solid,
              ),
              borderRadius: BorderRadius.circular(20),
              color: Color(0xFF8B7E74)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
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
                    labelText: "Enter Full Name ",
                    focusColor: Colors.white,
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Color(0xFFBA94D1), width: 3.0),
                    ),
                    labelStyle: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 2),
                    prefixIcon: Icon(Icons.person_outline),
                    errorText: sname ? nameer : null,
                  ),
                  keyboardType: TextInputType.text,
                ),
              ),
              Container(
                margin: EdgeInsets.all(20),
                child: TextField(
                  onTap: () {
                    setState(() {
                      snumber = false;
                    });
                  },
                  controller: cnumber,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(50))),
                    labelText: "Enter Mobile Number",
                    focusColor: Colors.white,
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Color(0xFFBA94D1), width: 3.0),
                    ),
                    labelStyle: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 2),
                    prefixIcon: Icon(Icons.phone),
                    errorText: snumber ? numberer : null,
                  ),
                  keyboardType: TextInputType.phone,
                ),
              ),
              SizedBox(
                height: 40,
              ),
              ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(Color(0xFFBA94D1)),
                      padding: MaterialStateProperty.all(EdgeInsets.all(0)),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                              side: BorderSide(color: Colors.black)))),
                  onPressed: () {
                    setState(() {
                      String name = cname.text;
                      String number = cnumber.text;
                      if (name.isEmpty) {
                        sname = true;
                        nameer = "Please Enter Name";
                      } else if (!RegExp('[a-zA-Z]').hasMatch(name)) {
                        sname = true;
                        nameer = "First Character Must be Alphabet";
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
                      } else if (number.isNotEmpty && number.length == 10) {
                        setState(() {
                          dbclass().getNumber1(number, db!).then((value) {
                            setState(() {
                              if (value.length != 0) {
                                print(">>>>>>>>>>>>>>>>");
                                snumber = true;
                                numberer =
                                    "This Number is Alredy Registered with Us.";
                                // isnum = 1;
                              } else {
                                snumber = false;
                                // isnum = 0;
                              }
                            });
                          });
                        });
                      } else {
                        snumber = false;
                      }

                      if (sname == false && snumber == false) {
                        dbclass().updateContect(
                            name, number, widget.contact["ID"], db!);
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
                      }
                    });
                  },
                  child: Text(
                    "Save",
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  )),
              SizedBox(
                height: 40,
              ),
              ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(Color(0xFFBA94D1)),
                      padding: MaterialStateProperty.all(EdgeInsets.all(0)),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                              side: BorderSide(color: Colors.black)))),
                  onPressed: () {
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
                  },
                  child: Text(
                    "Back",
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
