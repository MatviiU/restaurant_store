
import 'dart:core';

import 'package:firebase_database/firebase_database.dart';
import 'package:internetmarket/Accounts/Accounts.dart';
import 'package:internetmarket/Accounts/Users.dart';

class FireBaseConnect {

  final database = FirebaseDatabase.instance;
  List<Accounts> accountList = [];
  List<Users> userList = [];

  DatabaseReference referenceFromAccounts = FirebaseDatabase.instance.ref("Accounts");
  DatabaseReference referenceFromUsers = FirebaseDatabase.instance.ref("Users");

  Future<List<Accounts>> SelectAccounts(String text) async{
    DataSnapshot snapshot = await referenceFromAccounts.get();
    dynamic list = snapshot.value;
    if(list != null){
      for(int i = 0; i < list!.length; i++){
        Accounts account = Accounts().parseFirebaseModel(list["$text"], "$text");
        accountList.add(account);
      }
    }
    return accountList;
  }

  Future<List<Users>> SelectUsers(String id) async{
    DataSnapshot snapshot = await referenceFromUsers.get();
    dynamic list = snapshot.value;
    if(list != null){
      for(int i = 0; i < list!.length; i++){
        Users user = Users().parseFirebaseModel(list["$id"], "$id");
        userList.add(user);
      }
    }
    return userList;
  }
}