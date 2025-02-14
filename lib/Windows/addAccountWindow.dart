import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:internetmarket/Accounts/Users.dart';
import 'package:internetmarket/Keys.dart';
import 'package:internetmarket/Windows/createAccountWindow.dart';
import 'package:internetmarket/Windows/loginWindow.dart';

import '../Accounts/Accounts.dart';
import '../DataBases/DBConnect.dart';
import '../FireBaseConnect.dart';

class addAccountWindow extends StatefulWidget {
  const addAccountWindow({super.key});

  @override
  State<addAccountWindow> createState() => _addAccountWindowState();
}

class _addAccountWindowState extends State<addAccountWindow> {
  late TextEditingController newPasswordController;
  late TextEditingController newLoginController;
  late String login;
  List<Accounts> accountList = [];
  List<Accounts> fbAccountList = [];

  RegExp regex = RegExp("^[A-Za-z0-9]+");

  @override
  void initState() {
    super.initState();
    newPasswordController = TextEditingController();
    newLoginController = TextEditingController();
    GlobalKeys.resetKeys();
  }

  @override
  void dispose() {
    newPasswordController.dispose();
    newLoginController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        title: Container(
          width: double.infinity,
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF4258D0), Color(0xFFC450C0)],
              begin: Alignment.bottomLeft,
              end: Alignment.topRight,
            ),
          ),
          child: Text(
            "Registration",
            style: TextStyle(
              fontFamily: 'Poppins',
              color: Colors.white,
              fontSize: 35,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
      body: Container(
        height: 520,
        padding: const EdgeInsets.fromLTRB(8, 16, 8, 16),
        child: Form(
          key: GlobalKeys.addAccountWindowKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                child: TextFormField(
                  controller: newLoginController,
                  onFieldSubmitted: (text){
                    //isUserInBD(text);
                  },
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.account_circle_rounded),
                    hintText: "Nowy login",
                    fillColor: Colors.white,
                    filled: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                  ),
                  validator: (login) {
                    if (login!.length < 2 || !regex.hasMatch(login)) {
                      return "Niepoprawny login";
                    }
                    if(kIsWeb){
                      if(fbAccountList.length > 0){
                        return "Login już istnieje";
                      }
                    }
                    else{
                      if(accountList.length > 0){
                        return "Login już istnieje";
                      }
                    }
                    return null;
                  },
                ),
              ),
              Container(
                child: TextFormField(
                  controller: newPasswordController,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.account_circle_rounded),
                    hintText: "Nowe hasło",
                    fillColor: Colors.white,
                    filled: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                  ),
                  validator: (password) {
                    if (password!.length < 8 || !regex.hasMatch(password)) {
                      return "Niepoprawne hasło";
                    }
                  },
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  if (GlobalKeys.addAccountWindowKey!.currentState!.validate()) {
                    if(kIsWeb){
                      login = newLoginController.text;
                      FireBaseConnect().referenceFromAccounts.child('${newLoginController.text}/Password').set(newPasswordController.text);
                    }
                    else{
                      DBConnect.db.InsertIntoAccounts(Accounts(
                          login: newLoginController.text,
                          password: newPasswordController.text));
                    }
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => createAccountWindow(login: login,)));
                  }
                },
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                child: Text(
                  "Contynuj",
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void isUserInBD(String text) async{
    accountList = await DBConnect.db.SelectUsersByLogin(login: text);
  }
  void isUserInFB(String text) async{
    fbAccountList = await FireBaseConnect().SelectAccounts(text);
  }
}
