import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:login/contect.dart';
import 'package:login/dbclass.dart';
import 'package:login/main.dart';
import 'package:login/updatecontact.dart';
import 'package:shrink_sidemenu/shrink_sidemenu.dart';
import 'package:sqflite/sqflite.dart';

class homepage extends StatefulWidget {
  homepage(
    int? this.ID,
    String? this.NAME,
    String? this.NUMBER,
    String? this.EMAIL,
    String? this.PASSWORD,
  );

  int? ID;
  String? NAME;
  String? NUMBER;
  String? EMAIL;
  String? PASSWORD;

  @override
  State<homepage> createState() => _homepageState();
}

class _homepageState extends State<homepage> {
  Database? db;
  List<Map> contacts = [];

  @override
  void initState() {
    // TODO: implement initState

    forDataBase();
    //forContectList();
  }

  forDataBase() {
    dbclass().getdb().then((value) {
      setState(() {
        db = value;
        dbclass().contectlist(widget.ID, db!).then((value) {
          setState(() {
            contacts = value;
          });
        });
      });
    });
  }

  int _counter = 0;
  bool isOpened = false;

  final GlobalKey<SideMenuState> _sideMenuKey = GlobalKey<SideMenuState>();
  final GlobalKey<SideMenuState> _endSideMenuKey = GlobalKey<SideMenuState>();

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  toggleMenu([bool end = false]) {
    if (end) {
      final _state = _endSideMenuKey.currentState!;
      if (_state.isOpened) {
        _state.closeSideMenu();
      } else {
        _state.openSideMenu();
      }
    } else {
      final _state = _sideMenuKey.currentState!;
      if (_state.isOpened) {
        _state.closeSideMenu();
      } else {
        _state.openSideMenu();
      }
    }
  }

  late String title;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: onWillPop,
      child: SideMenu(
          background: Color(0xFF3F979B).withOpacity(.4),
          key: _sideMenuKey,
          type: SideMenuType.slideNRotate,
          onChange: (_isOpened) {
            setState(() => isOpened = _isOpened);
          },
          menu: buildMenu(),
          child: IgnorePointer(
            ignoring: isOpened,
            child: Scaffold(
                floatingActionButton: FloatingActionButton(
                  elevation: 20,
                  onPressed: () {
                    Navigator.pushReplacement(context, MaterialPageRoute(
                      builder: (context) {
                        return contect();
                      },
                    ));
                  },
                  child: Icon(Icons.add),
                ),
                // drawer: Drawer(
                //     backgroundColor: Colors.transparent,
                //     child: Container(
                //       margin: EdgeInsets.all(20),
                //       decoration: BoxDecoration(
                //           border: Border.all(
                //             width: 1,
                //             style: BorderStyle.solid,
                //           ),
                //           borderRadius: BorderRadius.circular(20),
                //           image: DecorationImage(
                //               image: AssetImage("Imagee/bg22.jpg"),
                //               fit: BoxFit.fill)),
                //       child: Column(
                //         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                //         children: [
                //           ListTile(
                //             leading: Icon(Icons.perm_identity),
                //             title: Text("${widget.ID}"),
                //           ),
                //           ListTile(
                //             leading: Icon(Icons.person),
                //             title: Text("${widget.NAME}"),
                //           ),
                //           ListTile(
                //             leading: Icon(Icons.phone),
                //             title: Text("${widget.NUMBER}"),
                //           ),
                //           ListTile(
                //             leading: Icon(Icons.email_outlined),
                //             title: Text("${widget.EMAIL}"),
                //           ),
                //           ListTile(
                //             leading: Icon(Icons.vpn_key_outlined),
                //             title: Text("${widget.PASSWORD}"),
                //           ),
                //           ElevatedButton(
                //               onPressed: () {
                //                 setState(() {
                //                   login.pref!.setBool("loginstatus", false);
                //                 });
                //                 Navigator.pushReplacement(context,
                //                     MaterialPageRoute(
                //                   builder: (context) {
                //                     return login();
                //                   },
                //                 ));
                //               },
                //               child: Text("LogOut"))
                //         ],
                //       ),
                //     )),
                resizeToAvoidBottomInset: false,
                backgroundColor: Color(0xFF65647C),
                // backgroundColor: Colors.transparent,
                appBar: AppBar(
                    title: Row(
                      children: [
                        IconButton(
                            onPressed: () {
                              setState(() {
                                toggleMenu();
                              });
                            },
                            icon: Icon(Icons.menu)),
                        SizedBox(
                          width: 100,
                        ),
                        Text("Cotacts"),
                      ],
                    ),
                    centerTitle: true,
                    backgroundColor: Color(0xFFBA94D1)),
                // body: Center(
                //   child: Container(
                //     child: Text("${contacts[0]}"),
                //   ),
                // ),
                body: ListView.builder(
                  itemCount: contacts.length,
                  itemBuilder: (context, index) {
                    return Card(
                      margin: EdgeInsets.all(10),
                      elevation: 40,
                      color: Colors.transparent,
                      // color: Colors.black,
                      child: ListTile(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25)),
                        tileColor: Color(0xFF1B2430),
                        trailing: PopupMenuButton(
                          color: Colors.white,
                          onSelected: (value) {
                            print("???????????$value");
                            if (value == 1) {
                              Navigator.pushReplacement(context,
                                  MaterialPageRoute(
                                builder: (context) {
                                  return updatecontact(contacts[index]);
                                },
                              ));
                            }
                          },
                          itemBuilder: (context) {
                            return [
                              PopupMenuItem(value: 1, child: Text("Update")),
                              PopupMenuItem(
                                value: 2,
                                child: Text("Delete"),
                                onTap: () {
                                  dbclass()
                                      .deleteContect(contacts[index]["ID"], db!)
                                      .then((value) {
                                    forDataBase();
                                  });
                                },
                              ),
                              PopupMenuItem(
                                value: 3,
                                child: Text("Copy"),
                                onTap: () {
                                  setState(() {
                                    FlutterClipboard.copy(
                                            "${"Name : " + contacts[index]["NAME"]},\n${"Number : " + contacts[index]["NUMBER"]}")
                                        .then((value) {
                                      Fluttertoast.showToast(
                                          msg: "Note Copied",
                                          toastLength: Toast.LENGTH_SHORT,
                                          gravity: ToastGravity.CENTER,
                                          timeInSecForIosWeb: 3,
                                          backgroundColor: Colors.yellow,
                                          textColor: Colors.black,
                                          fontSize: 16.0);
                                    });
                                  });
                                },
                              ),
                            ];
                          },
                        ),
                        title: Text("${contacts[index]["NAME"]}",
                            style: TextStyle(
                                letterSpacing: 3, fontWeight: FontWeight.bold)),
                        subtitle: Text("${contacts[index]["NUMBER"]}",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                                letterSpacing: 3)),
                        // textColor: Color(0xFFDA0841),
                        textColor: Colors.white,
                      ),
                    );
                  },
                )),
          )),
    );
    //     ),
    //   ),
    // ));
  }

  Widget buildMenu() {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(vertical: 50.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                CircleAvatar(
                  backgroundImage: AssetImage("Imagee/profile.jpg"),
                  radius: 22.0,
                ),
                SizedBox(height: 16.0),
                Text(
                  "Hello",
                  style: TextStyle(color: Colors.white),
                ),
                SizedBox(height: 20.0),
              ],
            ),
          ),
          ListTile(
            onTap: () {},
            leading: const Icon(Icons.person_outline,
                size: 20.0, color: Colors.white),
            title: Text("${widget.ID}"),
            textColor: Colors.white,
            dense: true,
          ),
          ListTile(
            onTap: () {},
            leading: const Icon(Icons.nature, size: 20.0, color: Colors.white),
            title: Text("${widget.NAME}"),
            textColor: Colors.white,
            dense: true,

            // padding: EdgeInsets.zero,
          ),
          ListTile(
            onTap: () {},
            leading: const Icon(Icons.phone, size: 20.0, color: Colors.white),
            title: Text("${widget.NUMBER}"),
            textColor: Colors.white,
            dense: true,

            // padding: EdgeInsets.zero,
          ),
          ListTile(
            onTap: () {},
            leading: const Icon(Icons.email, size: 20.0, color: Colors.white),
            title: Text("${widget.EMAIL}"),
            textColor: Colors.white,
            dense: true,

            // padding: EdgeInsets.zero,
          ),
          ListTile(
            onTap: () {},
            leading: const Icon(Icons.vpn_key_outlined,
                size: 20.0, color: Colors.white),
            title: Text("${widget.PASSWORD}"),
            textColor: Colors.white,
            dense: true,

            // padding: EdgeInsets.zero,
          ),
          ListTile(
            onTap: () {
              setState(() {
                login.pref!.setBool("loginstatus", false);
              });
              Navigator.pushReplacement(context, MaterialPageRoute(
                builder: (context) {
                  return login();
                },
              ));
            },
            leading: const Icon(Icons.exit_to_app_rounded,
                size: 20.0, color: Colors.white),
            title: Text("LOG-OUT"),
            textColor: Colors.white,
            dense: true,

            // padding: EdgeInsets.zero,
          ),
        ],
      ),
    );
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
}
