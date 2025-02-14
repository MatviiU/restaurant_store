import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:internetmarket/Accounts/Accounts.dart';
import 'package:internetmarket/Accounts/Users.dart';
import 'package:internetmarket/DataBases/DBConnect.dart';
import 'package:internetmarket/FireBaseConnect.dart';
import 'package:internetmarket/Keys.dart';
import 'package:internetmarket/Windows/loginWindow.dart';

class createAccountWindow extends StatefulWidget {
  String? login;
  createAccountWindow({super.key, this.login});

  @override
  State<createAccountWindow> createState() => _createAccountWindow();
}

class _createAccountWindow extends State<createAccountWindow> {
  late TextEditingController nameController;
  late TextEditingController emailController;
  late TextEditingController phoneNumberController;
  late TextEditingController streetController;
  late TextEditingController houseNumberController;
  late TextEditingController apartmentNumberController;
  late TextEditingController indexController;
  RegExp regexEmail = RegExp("^[a-zA-Z0-9]+@[a-zA-Z]+\.[a-z]+");


  @override
  void initState() {
    super.initState();
    nameController = TextEditingController();
    emailController = TextEditingController();
    phoneNumberController = TextEditingController();
    streetController = TextEditingController();
    houseNumberController = TextEditingController();
    apartmentNumberController = TextEditingController();
    indexController = TextEditingController();
    GlobalKeys.resetKeys();
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    phoneNumberController.dispose();
    streetController.dispose();
    houseNumberController.dispose();
    apartmentNumberController.dispose();
    indexController.dispose();
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
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.fromLTRB(8, 16, 8, 16),
          child: Form(
            key: GlobalKeys.createAccountWindowKey,
            child: Column(
              children: [
                Container(
                  child: TextFormField(
                    controller: nameController,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.account_circle_rounded),
                      hintText: "Imię",
                      fillColor: Colors.white,
                      filled: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                    ),
                    validator: (name){
                      if(name == null || name!.isEmpty){
                        return "Napisz imię";
                      }
                      else{
                        return null;
                      }
                    },
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(top: 16),
                  child: TextFormField(
                    controller: emailController,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.email_rounded),
                      hintText: "Email",
                      fillColor: Colors.white,
                      filled: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                    ),
                    validator: (email) {
                      if (!regexEmail.hasMatch(email!)) {
                        return "Niepoprawny zapis email";
                      } else {
                        return null;
                      }
                    },
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(top: 16),
                  child: TextFormField(
                    controller: phoneNumberController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.phone_android_rounded),
                      hintText: "Numer telefonu",
                      fillColor: Colors.white,
                      filled: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                    ),
                    validator: (phone) {
                      if (phone!.length < 9 || phone!.length > 9) {
                        return "Numer telefonu zawiera 9 cyfr";
                      }
                    },
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(top: 16),
                  child: TextFormField(
                    controller: streetController,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.house_rounded),
                      hintText: "Ulica",
                      fillColor: Colors.white,
                      filled: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                    ),
                    validator: (street){
                      if(street == null || street!.isEmpty){
                        return "Napisz ulicę";
                      }
                      else{
                        return null;
                      }
                    },
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.only(top: 16),
                        child: TextFormField(
                          controller: houseNumberController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.house_rounded),
                            hintText: "Numer domu",
                            fillColor: Colors.white,
                            filled: true,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                          ),
                          validator: (houseNumber){
                            if(houseNumber == null || houseNumber!.isEmpty){
                              return "Napisz numer domu";
                            }
                            else{
                              return null;
                            }
                          }
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.only(top: 16),
                        child: TextFormField(
                          controller: apartmentNumberController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.house_rounded),
                            hintText: "Numer mieszkania",
                            fillColor: Colors.white,
                            filled: true,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                          ),
                          validator: (apartmentNumber){
                            if(apartmentNumber == null || apartmentNumber!.isEmpty){
                              return "Napisz numer mieszkania";
                            }
                            else{
                              return null;
                            }
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                Container(
                  padding: EdgeInsets.only(top: 16),
                  child: TextFormField(
                    controller: indexController,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.post_add_rounded),
                      hintText: "Kod pocztowy",
                      fillColor: Colors.white,
                      filled: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                    ),
                    validator: (index) {
                      if(index == null || index!.isEmpty){
                        return "Napisz imię";
                      }
                      else{
                        return null;
                      }
                    },
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(top: 16),
                  child: ElevatedButton(
                    onPressed: () {
                      if (GlobalKeys.createAccountWindowKey!.currentState!
                          .validate()) {
                        if(kIsWeb){
                          FireBaseConnect().referenceFromUsers.child('${widget.login}/FirstName').set(nameController.text);
                          FireBaseConnect().referenceFromUsers.child('${widget.login}/Email').set(emailController.text);
                          FireBaseConnect().referenceFromUsers.child('${widget.login}/Phone').set(int.parse(phoneNumberController.text));
                          FireBaseConnect().referenceFromUsers.child('${widget.login}/Street').set(streetController.text);
                          FireBaseConnect().referenceFromUsers.child('${widget.login}/HouseNumber').set(int.parse(houseNumberController.text));
                          FireBaseConnect().referenceFromUsers.child('${widget.login}/ApartmentNumber').set(int.parse(apartmentNumberController.text));
                          FireBaseConnect().referenceFromUsers.child('${widget.login}/ZIPCode').set(indexController.text);
                          FireBaseConnect().referenceFromUsers.child('${nameController.text}/Login').set(widget.login);
                        }
                        else{
                          DBConnect.db.InsertIntoUsers(Users(
                              login: Accounts.loggedLogin,
                              firstName: nameController.text,
                              email: emailController.text,
                              phoneNumber: int.parse(phoneNumberController.text),
                              street: streetController.text,
                              houseNumber: int.parse(houseNumberController.text),
                              apartmentNumber:
                              int.parse(apartmentNumberController.text),
                              zipCode: indexController.text));
                        }
                        Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(
                              builder: (context) => loginWindow()),
                              (route) => false,
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    child: Text(
                      "Zarejestruj się",
                      style: TextStyle(color: Colors.black),
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
}
