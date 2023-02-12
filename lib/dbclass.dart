import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class dbclass {
  Future<Database> getdb() async {
    // Get a location using getDatabasesPath
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'demo.db');
    // open the database
    Database database = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      // When creating the db, create the table
      await db.execute(
          'CREATE TABLE UserData (ID INTEGER PRIMARY KEY AUTOINCREMENT, NAME TEXT, NUMBER TEXT, EMAIL TEXT,PASSWORD TEXT)');
      await db.execute(
          'CREATE TABLE Contect (ID INTEGER PRIMARY KEY AUTOINCREMENT, NAME TEXT, NUMBER TEXT,UID TEXT)');
    });
    return database;
  }

  Future<int> InsertData(
      String name, String number, String email, String ps, Database? db) {
    String insert =
        "insert into UserData (NAME,NUMBER,EMAIL,PASSWORD)  values('$name','$number','$email','$ps')";
    Future<int>? aa = db!.rawInsert(insert);
    return aa;
  }

  Future<List<Map>> userlogin(
      String number, String password, Database db) async {
    String login =
        "select * from UserData where NUMBER='$number' and PASSWORD='$password'";
    List<Map> data = await db.rawQuery(login);
    return data;
  }

  Future<List<Map>> getNumber(String number, Database db) async {
    String getNumber = "select * from UserData where NUMBER='$number'";
    List<Map> num = await db.rawQuery(getNumber);
    return num;
  }

  void InsertContect(String name, String number, int? id, Database? db) {
    String Ins =
        "insert into Contect (NAME,NUMBER,UID)  values('$name','$number','$id')";

    db!.rawInsert(Ins);
  }

  Future<List<Map>> getNumber1(String number, Database db) async {
    String getNumber = "select * from Contect where NUMBER='$number'";
    List<Map> num = await db.rawQuery(getNumber);
    return num;
  }

  Future<List<Map>> contectlist(int? uid, Database db) async {
    String login = "select * from Contect where UID = '$uid'";
    List<Map> data = await db.rawQuery(login);
    return data;
  }

  void updateContect(String name, String number, idd, Database database) {
    String upd =
        "update Contect set NAME='$name' , NUMBER='$number' where ID='$idd'";
    database.rawUpdate(upd);
  }

  Future<void> deleteContect(idd, Database db) async {
    String dlt = "Delete from Contect where ID = '$idd'";
    int aa = await db.rawDelete(dlt);
  }
}
