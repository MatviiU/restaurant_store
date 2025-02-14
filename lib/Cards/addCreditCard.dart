import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:internetmarket/Cards/Cards.dart';
import 'package:internetmarket/DataBases/DBConnect.dart';
import 'package:internetmarket/Keys.dart';
import 'package:internetmarket/Windows/paymentsWindow.dart';

import '../Accounts/Accounts.dart';


class addCreditCard extends StatefulWidget {
  final Function(String, String) onAddedCard;

  addCreditCard({required this.onAddedCard});

  @override
  State<addCreditCard> createState() => _addCreditCard();
}

class _addCreditCard extends State<addCreditCard> {
  final TextEditingController _cardNumberController = TextEditingController();
  final TextEditingController _expiryDateController = TextEditingController();
  final TextEditingController _cvvController = TextEditingController();
  final TextEditingController _cardHolderNameController = TextEditingController();

  @override
  void dispose() {
    _cardNumberController.dispose();
    _expiryDateController.dispose();
    _cvvController.dispose();
    _cardHolderNameController.dispose();
    super.dispose();
  }

  void saveCard() {
    if (GlobalKeys.addCreditCardKey!.currentState!.validate()) {
      String numberCard = _cardNumberController.text;
      String cardHolderName = _cardHolderNameController.text;

      widget.onAddedCard(numberCard, cardHolderName);

      DBConnect.db.InsertIntoCards(
          Cards(login: Accounts.loggedLogin, cardNumber: int.parse(_cardNumberController.text), expireDate: _expiryDateController.text,
              cvv: int.parse(_cvvController.text), cardUserName: _cardHolderNameController.text));

      Navigator.pop(context, true);
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
            "Dodanie karty",
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
        padding: EdgeInsets.all(30),
        child: Form(
          key: GlobalKeys.addCreditCardKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _cardNumberController,
                decoration: InputDecoration(
                  labelText: "Numer karty",
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Wpisz numer karty";
                  }
                  if (value.length != 16) {
                    return "NUmer karty ma 16 cyfr";
                  }
                  return null;
                },
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: _expiryDateController,
                decoration: InputDecoration(
                  labelText: "MM/YY",
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.datetime,
                inputFormatters: [
                  FilteringTextInputFormatter(RegExp(r'[0-9/]'), allow: true)
                ],
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Wpisz datę ukończenia karty";
                  }
                  if (!RegExp(r'^(0[1-9]|1[0-2])\/?([0-9]{2})$')
                      .hasMatch(value)) {
                    return "Niepoprawny format";
                  }
                  return null;
                },
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: _cvvController,
                decoration: InputDecoration(
                  labelText: "CVV",
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Wpisz numer CVV";
                  }
                  if (value.length != 3) {
                    return "CVV ma 3 cyfry";
                  }
                  return null;
                },
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: _cardHolderNameController,
                decoration: InputDecoration(
                  labelText: "Twoje imię",
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter card holder name";
                  }
                  return null;
                },
              ),
              SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: saveCard,
                child: Text("Zapisz kartę"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
