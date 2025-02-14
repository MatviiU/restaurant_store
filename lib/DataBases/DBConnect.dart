import 'dart:io';
import 'dart:math';

import 'package:flutter/services.dart';
import 'package:internetmarket/Accounts/Accounts.dart';
import 'package:internetmarket/Accounts/Users.dart';
import 'package:internetmarket/Products/Products.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';


import '../Cards/Cards.dart';
class DBConnect{
  var dbPath;
  DBConnect._();
  static final DBConnect db = DBConnect._();
  late Database _database;


  Future<Database> get database async{
    _database = await initDB();
    return _database;
  }


  initDB() async {

    Directory directory = await getApplicationDocumentsDirectory();
    dbPath = join(directory.path, "MarketDB.db");

    if(FileSystemEntity.typeSync(dbPath) == FileSystemEntityType.notFound){
      ByteData data = await rootBundle.load("assets/MarketDB.db");
      WriteToFile(data, dbPath);
    }

    var departuresDatabase = await openDatabase(dbPath);
    return departuresDatabase;
  }

  void WriteToFile(ByteData data, String dbPath){
    final buffer = data.buffer;
    return new File(dbPath).writeAsBytesSync(
        buffer.asUint8List(data.offsetInBytes, data.lengthInBytes));
  }

  Future<List<Accounts>> SelectUsersByLogin({String? login, String? password}) async{
    final db = await database;
    String sqlQuery = 'SELECT * FROM Accounts WHERE Login = \'$login\' OR Password = \'$password\'';
    var result = await db.rawQuery(sqlQuery);

    List<Accounts> accountList = result.map((x) => Accounts.fromMap(x)).toList();
    return accountList;
  }

  Future<List<Products>> SelectProducts() async {
    final db = await database;
    String sqlQuery = 'SELECT * FROM Products';
    var result = await db.rawQuery(sqlQuery);

    List<Products> productList = result.map((x) => Products.fromMap(x)).toList();
    return productList;
  }

  Future<List<Cards>> SelectCards(String? login) async{
    final db = await database;
    String sqlQuery = 'SELECT * FROM Cards WHERE Login = \'$login\'';
    var result = await db.rawQuery(sqlQuery);

    List<Cards> cardList = result.map((x) => Cards.fromMap(x)).toList();
    return cardList;
  }

  Future<List<Users>> SelectUserByLogin(String? login) async{
    final db = await database;
    String sqlQuery = 'SELECT Users.FirstName, Users.Email,  Users.Phone, '
        'Users.Street, Users.HouseNumber, Users.ApartmentNumber, Users.ZIPCode '
        'FROM Accounts INNER JOIN Users ON Accounts.IDAccount = Users.IDUser '
        'WHERE Accounts.Login = \'$login\'';
    var result = await db.rawQuery(sqlQuery);

    List<Users> userList = result.map((x) => Users.fromMap(x)).toList();
    return userList;
  }


  Future<bool> InsertIntoAccounts(Accounts accounts) async{
    final db = await database;
    int result = 0;
    try{
      result = await db.rawInsert(
        'INSERT INTO Accounts(Login, Password)'
            'VALUES(\'${accounts.login}\', \'${accounts.password}\')'
      );
    }
    catch(e){
      print('insertIntoAccounts ${e.toString()}');
    }
    return result != 0;
  }


  Future<int> UpdatePasswordInAccounts(String? login, String password) async{
    final db = await database;
    int result = 0;
    try{
      result = await db.rawUpdate(
        'UPDATE Accounts SET Password = \'$password\' WHERE Login = \'$login\''
      );
    }
    catch(e){
      print('updatePasswordInAccounts ${e.toString()}');
    }
    return result;
  }

  Future<bool> InsertIntoCards(Cards cards) async{
    final db = await database;
    int result = 0;
    try{
      result = await db.rawInsert(
          'INSERT INTO Cards(CardNumber, ExpireDate, CVV, CardUserName, Login)'
              'VALUES(\'${cards.cardNumber}\', \'${cards.expireDate}\', \'${cards.cvv}\',\'${cards.cardUserName}\', \'${cards.login}\')'
      );
    }
    catch(e){
      print('insertIntoCards ${e.toString()}');
    }
    return result != 0;
  }

  Future<bool> InsertIntoUsers(Users users) async{
    final db = await database;
    int result = 0;
    try{
      result = await db.rawInsert(
          'INSERT INTO Users(FirstName, Email, Phone, Street, HouseNumber, ApartmentNumber, ZIPCode, Login)'
              'VALUES(\'${users.firstName}\', \'${users.email}\', \'${users.phoneNumber}\', '
              '\'${users.street}\', \'${users.houseNumber}\', \'${users.apartmentNumber}\', \'${users.zipCode}\', \'${users.login}\')'
      );
    }
    catch(e){
      print('insertIntoUsers ${e.toString()}');
    }
    return result != 0;
  }

  Future<int> UpdateLoginInUsers(String? login) async {
    final db = await database;
      var result = await db.rawUpdate(
          'UPDATE Users '
              'SET Login = \'$login\' '
              'WHERE IDUser IN ( SELECT Users.IDUser '
              ' FROM Users'
              ' INNER JOIN Accounts ON Users.IDUser = Accounts.IDAccount);'
      );
    return result;
  }

  Future<int> DeleteAccount({String? login}) async{
    final db = await database;
    var result = await db.rawDelete('DELETE FROM Accounts WHERE Login = \'$login\';');
    return result;
  }

  Future<int> DeleteUser({String? login}) async{
    final db = await database;
    var result = await db.rawDelete('DELETE FROM Users WHERE Login = \'$login\';');
    return result;
  }

  Future<int> DeleteCards({String? login}) async{
    final db = await database;
    var result = await db.rawDelete('DELETE FROM Cards WHERE Login = \'$login\';');
    return result;
  }
}


