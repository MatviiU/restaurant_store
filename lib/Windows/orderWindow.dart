import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:internetmarket/Windows/orderEndingWindow.dart';
import 'dart:convert';

import '../Products/Products.dart';


class orderWindow extends StatefulWidget {
    orderWindow({super.key});

  @override
  State<orderWindow> createState() => _orderWindowState();
}

class _orderWindowState extends State<orderWindow> {
  late TextEditingController currencyController;
  String selectedCurrency = "PLN";
  double basePrice = 27;
  Map<String, double> exchangeRates = {
    "PLN": 4.0,
    "USD": 1.0,
  };

  List<double> productPrices = [];

  void addProductPrice(double price, int count){
    double convertedPrice = convertPrice(price * count, "PLN", selectedCurrency);
    productPrices.add(convertedPrice);
  }

  double getTotalPrice() {
    return productPrices.fold(0, (sum, price) => sum + price);
  }

  @override
  void initState() {
    super.initState();
    currencyController = TextEditingController();
    fetchExchangeRates();
  }

  Future<void> fetchExchangeRates() async {
    final response = await http.get(Uri.parse(
        'https://openexchangerates.org/api/latest.json?app_id=32fae365359f496799e81be677f41638'));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      setState(() {
        exchangeRates = {
          "USD": 1.0,
          "PLN": _toDouble(data['rates']['PLN']),
          "EUR": _toDouble(data['rates']['EUR']),
          "UAH": _toDouble(data['rates']['UAH']),
        };
      });
    } else {
      throw Exception("Failed to load exchange rates");
    }
  }

  double _toDouble(dynamic value) {
    if (value is int) {
      return value.toDouble();
    } else if (value is double) {
      return value;
    } else {
      return double.tryParse(value.toString()) ?? 0.0;
    }
  }

  double convertPrice(
      double basePrice, String fromCurrency, String toCurrency) {
    if (exchangeRates.containsKey(fromCurrency) &&
        exchangeRates.containsKey(toCurrency)) {
      double priceInUSD = basePrice / exchangeRates[fromCurrency]!;
      return priceInUSD * exchangeRates[toCurrency]!;
    }
    return basePrice;
  }

  @override
  void dispose() {
    currencyController.dispose();
    super.dispose();
  }

  Map<Products, int> countProducts(List<Products>? products) {
    Map<Products, int> productCounts = {};
    if (products != null) {
      for (var product in products) {
        if (productCounts.containsKey(product)) {
          productCounts[product] = productCounts[product]! + 1;
        } else {
          productCounts[product] = 1;
        }
      }
    }
    return productCounts;
  }

  @override
  Widget build(BuildContext context) {
    final productCounts = countProducts(Products.productList);

    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        title: Container(
          width: double.infinity,
          height: 80,
          padding: const EdgeInsets.all(16),
          color: const Color(0xFF334E3B),
          child: const Text(
            "Zamówienia",
            style: TextStyle(
              fontFamily: 'Poppins',
              color: Colors.white,
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        actions: [IconButton(onPressed: (){
          Navigator.of(context).push(MaterialPageRoute(builder: (context) => orderEndingWindow(price: getTotalPrice(), selectedCurrency: selectedCurrency,)));
        }, icon: Icon(Icons.credit_card))],
      ),
      body: Column(
        children: [
          Container(
            alignment: Alignment.topCenter,
            padding: const EdgeInsets.only(top: 25),
            child: DropdownButton<String>(
              value: selectedCurrency,
              items: exchangeRates.keys.map((String currency) {
                return DropdownMenuItem<String>(
                  value: currency,
                  child: Text(currency),
                );
              }).toList(),
              onChanged: (String? value) {
                setState(() {
                  selectedCurrency = value!;
                });
              },
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height * 0.75,
            padding: const EdgeInsets.only(top: 20),
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: productCounts.length,
              itemBuilder: (context, index) {
                Products product = productCounts.keys.elementAt(index);
                int count = productCounts[product]!;
                double convertedPrice =
                    convertPrice(product.productPrice! * count, "PLN", selectedCurrency);
                addProductPrice(convertedPrice, count);
                return ListTile(
                  leading: Image.asset(
                    "assets/sushi.png",
                    width: 40,
                    height: 40,
                  ),
                  title: Text(
                    product.productName!,
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 20,
                    ),
                  ),
                  subtitle: Text("Ilość: $count"),
                  trailing: Text(
                    "${convertedPrice.toStringAsFixed(2)} $selectedCurrency",
                    style: const TextStyle(
                      fontSize: 17,
                      fontFamily: 'Poppins',
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}


