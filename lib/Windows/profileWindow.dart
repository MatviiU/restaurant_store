import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:internetmarket/Accounts/Accounts.dart';
import 'package:internetmarket/Accounts/Users.dart';
import 'package:internetmarket/FireBaseConnect.dart';

import '../DataBases/DBConnect.dart';

class profileWindow extends StatefulWidget {
   profileWindow({super.key});

  @override
  State<profileWindow> createState() => _profileWindowState();
}

class _profileWindowState extends State<profileWindow> {
  late Future<List<Users>> _users;

  @override
  void initState() {
    super.initState();
    if(kIsWeb){
      _users = FireBaseConnect().SelectUsers(Users.loggedId!);
    }
    else{
      _users = DBConnect.db.SelectUserByLogin(Accounts.loggedLogin);
    }
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
            "Twoje dane",
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
      body: FutureBuilder<List<Users>>(
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<Users>? snapshotUsers = snapshot.data;
            return Container(
              padding: EdgeInsets.only(top: 30),
              child: ListView.builder(
                itemCount: snapshotUsers?.length,
                itemBuilder: (context, index) {
                return Column(
                  children: [ListTile(
                    title: Text(
                      "Imię",
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        color: Colors.grey,
                        fontSize: 25,
                      ),
                    ),
                    subtitle: Text(
                      snapshotUsers![index].firstName!,
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        color: Colors.black,
                        fontSize: 30,
                      ),
                    ),
                  ),
                    ListTile(
                      title: Text(
                        "Email",
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          color: Colors.grey,
                          fontSize: 25,
                        ),
                      ),
                      subtitle: Text(
                        snapshotUsers![index].email!,
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          color: Colors.black,
                          fontSize: 30,
                        ),
                      ),
                    ),
                    ListTile(
                      title: Text(
                        "Numer telefonu",
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          color: Colors.grey,
                          fontSize: 25,
                        ),
                      ),
                      subtitle: Text(
                        "${snapshotUsers![index].phoneNumber!}",
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          color: Colors.black,
                          fontSize: 30,
                        ),
                      ),
                    ),
                    ListTile(
                      title: Text(
                        "Twoja adresa",
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          color: Colors.grey,
                          fontSize: 25,
                        ),
                      ),
                      subtitle: Text(
                        "${snapshotUsers![index].street!} ${snapshotUsers![index].houseNumber!}/"
                            " ${snapshotUsers![index].apartmentNumber}",
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          color: Colors.black,
                          fontSize: 30,
                        ),
                      ),
                    ),
                    ListTile(
                      title: Text(
                        "Kod pocztowy",
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          color: Colors.grey,
                          fontSize: 25,
                        ),
                      ),
                      subtitle: Text(
                        snapshotUsers![index].zipCode!,
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          color: Colors.black,
                          fontSize: 30,
                        ),
                      ),
                    )
                    ,
                  ],
                );
              },
              ),
            );
          } else if (snapshot.hasError) {
            return Text("Error: ${snapshot.error}");
          } else {
            return CircularProgressIndicator();
          }
        },
        future: _users,
      ),
    );
  }
}

