import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:internetmarket/Accounts/Accounts.dart';
import 'package:internetmarket/DataBases/DBConnect.dart';
import 'package:internetmarket/FireBaseConnect.dart';
import 'package:internetmarket/Keys.dart';
import 'package:internetmarket/Windows/addAccountWindow.dart';
import 'package:internetmarket/Windows/mainWindow.dart';

import '../Accounts/Users.dart';
import '../main.dart';

class loginWindow extends StatefulWidget {
  const loginWindow({super.key});

  @override
  State<loginWindow> createState() => _loginWindowState();
}

class _loginWindowState extends State<loginWindow> {
  late TextEditingController controllerLogin;
  late TextEditingController controllerPassword;
  RegExp regex = RegExp("^[A-Za-z0-9]+");
  List<Accounts> accountList = [];
  List<Accounts> fbAccountList = [];

  @override
  void initState() {
    super.initState();
    controllerPassword = TextEditingController();
    controllerLogin = TextEditingController();
    GlobalKeys.resetKeys();
  }

  @override
  void dispose() {
    controllerPassword.dispose();
    controllerLogin.dispose();
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
            "Login Form",
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
        alignment: Alignment.center,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF4258D0), Color(0xFFC450C0)],
            begin: Alignment.bottomLeft,
            end: Alignment.topRight,
          ),
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black54.withOpacity(0.5),
                spreadRadius: 2,
                blurRadius: 4,
                offset: Offset(0, 0), // changes position of shadow
              ),
            ],
          ),
          alignment: Alignment.center,
          width: isBigScreen ? 500 : double.infinity,
          height: 520,
          padding: const EdgeInsets.fromLTRB(8, 16, 8, 16),
          child: Form(
            key: GlobalKeys.loginWindowKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  child: TextFormField(
                      controller: controllerLogin,
                      onFieldSubmitted: (text) {
                        if(kIsWeb){
                          isUserInFB(text);
                        }else{
                          isUserInBD(text);
                        }
                      },
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.account_circle_rounded),
                        hintText: "Login",
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
                          if(fbAccountList.length == 0){
                            return "Nie istnieje danego logina";
                          }
                        }
                        else{
                          if (accountList.length == 0) {
                            return "Nie istnieje danego logina";
                          }
                        }
                        return null;
                      }),
                ),
                Container(
                  child: TextFormField(
                    obscureText: true,
                    obscuringCharacter: "*",
                    controller: controllerPassword,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.password_rounded),
                      hintText: "Hasło",
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
                      bool isCorrectPassword = true;
                      if(kIsWeb){
                        for(int i = 0; i < fbAccountList.length; i++){
                          if(fbAccountList[i].password != controllerPassword.text){
                            isCorrectPassword = false;
                          } else{
                            isCorrectPassword = true;
                            break;
                          }
                        }
                      } else {
                        for (int i = 0; i < accountList.length; i++) {
                          if (accountList[i].password !=
                              controllerPassword.text) {
                            isCorrectPassword = false;
                          } else {
                            isCorrectPassword = true;
                            break;
                          }
                        }
                      }
                      return isCorrectPassword
                          ? null
                          : "Nie istnieje danego hasła";
                    },
                  ),
                ),
                Container(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {},
                    child: Text("Zapomniałeś hasło?"),
                  ),
                ),
                Container(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => addAccountWindow()));
                    },
                    child: Text("Zarejestruj się"),
                  ),
                ),
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Color(0xFF4258D0), Color(0xFFC450C0)],
                      begin: Alignment.bottomLeft,
                      end: Alignment.topRight,
                    ),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: ElevatedButton(
                    onPressed: () {
                      if (GlobalKeys.loginWindowKey!.currentState!.validate()) {
                        bool isAndroid = Theme.of(context).platform == TargetPlatform.android;
                        if(isAndroid){
                          Accounts.loggedLogin = accountList.last.login;
                          DBConnect.db.UpdateLoginInUsers(Accounts.loggedLogin!);
                        }
                        if(kIsWeb){
                          Users.loggedId = controllerLogin.text;
                        }
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (context) => mainWindow(
                            ),
                          ),
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      shadowColor: Colors.transparent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    child: Text(
                      "Login",
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void isUserInBD(String text) async {
    accountList = await DBConnect.db.SelectUsersByLogin(login: text);
  }

  void isUserInFB(String text) async{
    fbAccountList = await FireBaseConnect().SelectAccounts(text);
  }

}
