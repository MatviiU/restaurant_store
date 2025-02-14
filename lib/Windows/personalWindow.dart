import 'package:flutter/material.dart';
import 'package:internetmarket/Accounts/Accounts.dart';
import 'package:internetmarket/DataBases/DBConnect.dart';
import 'package:internetmarket/Products/Products.dart';
import 'package:internetmarket/Windows/changePasswordWindow.dart';
import 'package:internetmarket/Windows/loginWindow.dart';
import 'package:internetmarket/Windows/paymentsWindow.dart';
import 'package:internetmarket/Windows/profileWindow.dart';

class personalWindow extends StatelessWidget {
  personalWindow({super.key});

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
            "Moje konto",
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
        child: ListView(
          children: [
            ListTile(
              leading: Icon(
                Icons.person,
                size: 30,
                color: Colors.black,
              ),
              trailing: IconButton(
                iconSize: 30,
                icon: Icon(Icons.arrow_forward_ios),
                onPressed: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => profileWindow()));
                },
              ),
              title: Text(
                "Twoje dane",
                style: TextStyle(
                  fontFamily: 'Poppins',
                  color: Colors.black,
                  fontSize: 25,
                ),
              ),
            ),
            ListTile(
              leading: Icon(
                Icons.key,
                size: 30,
                color: Colors.black,
              ),
              trailing: IconButton(
                iconSize: 30,
                icon: Icon(Icons.arrow_forward_ios),
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => changePasswordWindow()));
                },
              ),
              title: Text(
                "Zmiana hasła",
                style: TextStyle(
                  fontFamily: 'Poppins',
                  color: Colors.black,
                  fontSize: 25,
                ),
              ),
            ),
            ListTile(
              leading: Icon(
                Icons.payment,
                size: 30,
                color: Colors.black,
              ),
              trailing: IconButton(
                iconSize: 30,
                icon: Icon(Icons.arrow_forward_ios),
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => paymentsWindow()));
                },
              ),
              title: Text(
                "Metody płatności",
                style: TextStyle(
                  fontFamily: 'Poppins',
                  color: Colors.black,
                  fontSize: 25,
                ),
              ),
            ),
            ListTile(
              leading: Icon(
                Icons.restore_from_trash,
                size: 30,
                color: Colors.black,
              ),
              trailing: IconButton(
                iconSize: 30,
                icon: Icon(Icons.arrow_forward_ios),
                onPressed: () {
                  DBConnect.db.DeleteAccount(login: Accounts.loggedLogin);
                  DBConnect.db.DeleteUser(login: Accounts.loggedLogin);
                  DBConnect.db.DeleteCards(login: Accounts.loggedLogin);
                  Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) => loginWindow()),
                    (route) => false,
                  );
                },
              ),
              title: Text(
                "Usuń konto",
                style: TextStyle(
                  fontFamily: 'Poppins',
                  color: Colors.black,
                  fontSize: 25,
                ),
              ),
            ),
            ListTile(
              leading: Icon(
                Icons.logout,
                size: 30,
                color: Colors.black,
              ),
              trailing: IconButton(
                iconSize: 30,
                icon: Icon(Icons.arrow_forward_ios),
                onPressed: () {
                  Products.clearProductList();
                  Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) => loginWindow()),
                    (route) => false,
                  );
                },
              ),
              title: Text(
                "Wyłoguj się",
                style: TextStyle(
                  fontFamily: 'Poppins',
                  color: Colors.black,
                  fontSize: 25,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

