import 'package:flutter/material.dart';
import 'package:internetmarket/Accounts/Accounts.dart';
import 'package:internetmarket/Windows/menuWindow.dart';
import 'package:internetmarket/Windows/orderWindow.dart';
import 'package:internetmarket/Windows/personalWindow.dart';

import '../Products/Products.dart';

class mainWindow extends StatelessWidget {
   mainWindow({super.key});

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
            "Sushi jam",
            style: TextStyle(
              fontFamily: 'Poppins',
              color: Colors.white,
              fontSize: 35,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        leading: Builder(
          builder: (context) {
            return IconButton(
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
              icon: const Icon(
                Icons.menu,
                size: 40,
              ),
            );
          },
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => personalWindow()));
            },
            icon: const Icon(
              Icons.person,
              color: Colors.black,
              size: 40,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Transform.rotate(
              angle: 3.14,
              child: Padding(
                padding: EdgeInsets.only(right: 12),
                child: Image.asset('assets/sushiHand.png'),
              ),
            ),
            Center(
              child: Container(
                width: 300,
                height: 300,
                decoration:
                    BoxDecoration(color: Colors.red, shape: BoxShape.circle),
              ),
            ),
            Image.asset('assets/sushiMain.png'),
          ],
        ),
      ),
      drawer: Drawer(
        backgroundColor: const Color(0xFFC8CBC0),
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Color(0xFFBD7423),
              ),
              child: Text(
                "Menu",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Poppins',
                  color: Color(0xFF072F38),
                  fontSize: 50,
                ),
              ),
            ),
            ListTile(
              title: const Text(
                "Strona główna",
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text(
                "Menu",
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
              onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => menuWindow()));
              },
            ),
            ListTile(
              title: const Text(
                "Zamówienia",
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => orderWindow()));
              },
            ),
            ListTile(
              title: const Text(
                "Dostawa",
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}

