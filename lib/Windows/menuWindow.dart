import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:internetmarket/DataBases/DBConnect.dart';
import 'package:internetmarket/Windows/mainWindow.dart';

import '../Products/Products.dart';
import 'orderWindow.dart';

class menuWindow extends StatefulWidget {
  const menuWindow({super.key});

  @override
  State<menuWindow> createState() => _menuWindowState();
}

class _menuWindowState extends State<menuWindow> {
  Future<List<Products>> _products = DBConnect.db.SelectProducts();

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
            "Menu",
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
          Navigator.of(context).push(MaterialPageRoute(builder: (context) => orderWindow()));
        }, icon: Icon(Icons.shopping_cart))],
      ),
      body: FutureBuilder<List<Products>>(
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<Products>? snapshotProducts = snapshot.data;
            return ListView.builder(
              itemCount: snapshotProducts?.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: SizedBox(
                    width: 100,
                    child: Image.asset(
                      "assets/sushi1.png",
                      fit: BoxFit.cover,
                    ),
                  ),
                  title: Text(
                    snapshotProducts![index].productName!,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(
                    snapshotProducts[index].productDescription!,
                    style: TextStyle(fontSize: 14),
                  ),
                  trailing: IconButton(
                    onPressed: () {
                      setState(() {
                        Products.productList.add(snapshotProducts[index]);
                      });
                    },
                    icon: Icon(Icons.add_shopping_cart_outlined),
                  ),
                );
              },
            );
          } else if (snapshot.hasError) {
            return Text("Error: ${snapshot.error}");
          } else {
            return CircularProgressIndicator();
          }
        },
        future: _products,
      ),
    );
  }
}

