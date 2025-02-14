import 'package:flutter/material.dart';
import 'package:internetmarket/Accounts/Accounts.dart';
import 'package:internetmarket/Cards/Cards.dart';
import 'package:internetmarket/Cards/addCreditCard.dart';
import 'package:internetmarket/DataBases/DBConnect.dart';


class paymentsWindow extends StatefulWidget {
  const paymentsWindow({super.key});

  @override
  State<paymentsWindow> createState() => _paymentsWindow();
}

class _paymentsWindow extends State<paymentsWindow> {

  List<Cards> cards = [];


  @override
  void initState() {
    super.initState();
    LoadCards();
  }

  void LoadCards() async{
    var loadedCards = await DBConnect.db.SelectCards(Accounts.loggedLogin);
    setState(() {
      cards = loadedCards;
    });
  }

  void addCard(String cardNumber, String cardHolderName) {
    setState(() {
      LoadCards();
    });
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
            "Płatności",
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
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(top: 30),
          ),
          ListTile(
            leading: Icon(
              Icons.payment,
              color: Colors.black,
              size: 30,
            ),
            title: Text(
              "Dodaj kartę",
              style: TextStyle(
                fontFamily: 'Poppins',
                color: Colors.black,
                fontSize: 25,
              ),
            ),
            trailing: IconButton(
              iconSize: 30,
              icon: Icon(Icons.arrow_forward_ios),
              onPressed: () async{
                final result = await Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) =>
                        addCreditCard(onAddedCard: addCard),
                  ),
                );
                if(result == true){
                  LoadCards();
                }
              },
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: cards.length,
              itemBuilder: (context, index) {
                final card = cards[index];
                final cardNumber = card.cardNumber.toString();
                final cardHolderName = card.cardUserName;
                final lastFourDigits =
                    cardNumber.substring(cardNumber.length - 4);
                return ListTile(
                  leading: Icon(Icons.credit_card),
                  title: Text(cardHolderName!),
                  subtitle: Text("Ostatnie 4 cyfry karty: $lastFourDigits"),
                );
              },
            ),
          ),
        ],
      ),
    );
  }


}
