import 'package:flutter/material.dart';
import 'package:internetmarket/Keys.dart';
import 'package:internetmarket/Windows/personalWindow.dart';

import '../Accounts/Accounts.dart';
import '../DataBases/DBConnect.dart';


class changePasswordWindow extends StatefulWidget {
  changePasswordWindow({super.key});

  @override
  State<changePasswordWindow> createState() => _changePasswordWindowState();
}

class _changePasswordWindowState extends State<changePasswordWindow> {
  late TextEditingController oldPassword;
  late TextEditingController newPassword;
  late TextEditingController changedPassword;
  List<Accounts> accountList = [];


  @override
  void initState() {
    super.initState();
    oldPassword = TextEditingController();
    newPassword = TextEditingController();
    changedPassword = TextEditingController();
  }

  @override
  void dispose() {
    oldPassword.dispose();
    newPassword.dispose();
    changedPassword.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        title: Container(
          width: double.infinity,
          height: 80,
          padding: const EdgeInsets.all(16),
          color: const Color(0xFF334E3B),
          child: const Text(
            "Zmiana hasła",
            style: TextStyle(
              fontFamily: 'Poppins',
              color: Colors.white,
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
      body: Container(
        padding: EdgeInsets.only(top: 30),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(8, 0, 8, 16),
          child: Form(
            key: GlobalKeys.changePasswordKey,
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.only(bottom: 25),
                  child: TextFormField(
                    controller: oldPassword,
                    validator: (password) {
                      isUserInBD(password!);
                       if(accountList.isEmpty){
                         return "Nie istneje danego hasła";
                       }
                       else{
                         return null;
                       }
                    },
                    decoration: InputDecoration(
                      hintText: "Stare hasło",
                      fillColor: Colors.white,
                      filled: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(bottom: 25),
                  child: TextFormField(
                    controller: newPassword,
                    validator: (password) {
                      password = newPassword.text;
                      bool isSamePasswordNewWithOld = newPassword.text == oldPassword.text;
                      return isSamePasswordNewWithOld
                          ? "Nowe hasło nie może być takie same jak stare"
                          : null;
                    },
                    decoration: InputDecoration(
                      hintText: "Nowe hasło",
                      fillColor: Colors.white,
                      filled: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(bottom: 25),
                  child: TextFormField(
                    controller: changedPassword,
                    validator: (password) {
                      bool isSamePasswordChangedWithNew = true;
                      if (changedPassword.text != newPassword.text) {
                        isSamePasswordChangedWithNew = false;
                      } else {
                        isSamePasswordChangedWithNew = true;
                      }
                      return isSamePasswordChangedWithNew
                          ? null
                          : "Hasło ma być takie same jak nowe";
                    },
                    decoration: InputDecoration(
                      hintText: "Powtórz nowe hasło",
                      fillColor: Colors.white,
                      filled: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    if(GlobalKeys.changePasswordKey!.currentState!.validate()){
                      DBConnect.db.UpdatePasswordInAccounts(Accounts.loggedLogin, changedPassword.text);
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => personalWindow()));
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  child: Text(
                    "Zmień hasło",
                    style: TextStyle(color: Colors.black),
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
    accountList = await DBConnect.db.SelectUsersByLogin(password: text);
  }
}
