import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:internetmarket/Accounts/Accounts.dart';

import '../Accounts/Users.dart';
import '../Cards/Cards.dart';
import '../DataBases/DBConnect.dart';
import '../Products/Products.dart';

class orderEndingWindow extends StatefulWidget {
  double? price;
  String? selectedCurrency;

  orderEndingWindow({super.key, this.price, this.selectedCurrency});

  @override
  State<orderEndingWindow> createState() => _orderEndingWindowState();
}

class _orderEndingWindowState extends State<orderEndingWindow> {
  List<Cards> cards = [];
  List<Users> user = [];

  @override
  void initState() {
    super.initState();
    LoadUser();
    LoadCards();
  }

  void LoadCards() async {
    var loadedCards = await DBConnect.db.SelectCards(Accounts.loggedLogin);
    setState(() {
      cards = loadedCards;
    });
  }

  void LoadUser() async {
    var loadedUser = await DBConnect.db.SelectUserByLogin(Accounts.loggedLogin);
    setState(() {
      user = loadedUser;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (user.isEmpty || cards.isEmpty) {
      return Scaffold(
        appBar: AppBar(
          titleSpacing: 0,
          title: Container(
            width: double.infinity,
            height: 80,
            padding: const EdgeInsets.all(16),
            color: const Color(0xFF334E3B),
            child: const Text(
              "Płatność",
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
        body: Center(child: CircularProgressIndicator()),
      );
    }

    final orderingUser = user.first;
    final card = cards.first;
    final cardNumber = card.cardNumber.toString();
    final lastFourDigits = cardNumber.substring(cardNumber.length - 4);

    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        title: Container(
          width: double.infinity,
          height: 80,
          padding: const EdgeInsets.all(16),
          color: const Color(0xFF334E3B),
          child: const Text(
            "Płatność",
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
      body: Padding(
        padding: EdgeInsets.all(8),
        child: Card(
          elevation: 4,
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              children: [
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Numer telefonu: ${orderingUser.phoneNumber}",
                      style: TextStyle(fontFamily: 'Poppins', fontSize: 18),
                    ),
                    Text(
                      "Adresa dostawy: ${orderingUser.street} ${orderingUser.houseNumber}/${orderingUser.apartmentNumber}",
                      style: TextStyle(fontFamily: 'Poppins', fontSize: 18),
                    ),
                    Text(
                      "Karta płatnicza: **** **** **** ${lastFourDigits}",
                      style: TextStyle(fontFamily: 'Poppins', fontSize: 18),
                    ),
                    Text(
                      "Suma zamówenia: ${widget.price} ${widget.selectedCurrency}",
                      style: TextStyle(fontFamily: 'Poppins', fontSize: 18),
                    ),
                  ],
                ),
                ElevatedButton(
                  onPressed: () {
                    Products.clearProductList();
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text("Opłacone"),
                      ),
                    );
                  },
                  child: Text("Zapłacić"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


