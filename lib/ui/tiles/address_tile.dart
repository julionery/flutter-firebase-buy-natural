import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:buy_natural/ui/views/add_address_page.dart';

class AddressTile extends StatelessWidget {
  final DocumentSnapshot snapshot;

  const AddressTile(this.snapshot);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => AddAddressPage(snapshot)));
      },
      child: Card(
        margin: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    snapshot.data["name"],
                    textAlign: TextAlign.start,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 8.0,
                  ),
                  Text(
                    snapshot.data["cpf"],
                    textAlign: TextAlign.start,
                  ),
                  SizedBox(
                    height: 4.0,
                  ),
                  Text(
                    snapshot.data["fone"],
                    textAlign: TextAlign.start,
                  ),
                  SizedBox(
                    height: 4.0,
                  ),
                  Text(
                    snapshot.data["address"] + ", " + snapshot.data["district"],
                    textAlign: TextAlign.start,
                  ),
                  SizedBox(
                    height: 4.0,
                  ),
                  Text(
                    _buildProductsText(snapshot),
                    textAlign: TextAlign.start,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _buildProductsText(DocumentSnapshot snapshot) {
    String text = "";

    text = snapshot.data["city"] +
        ", " +
        snapshot.data["state"] +
        ", " +
        snapshot.data["country"];

    if (snapshot.data["CEP"] != null) text += " - " + snapshot.data["CEP"];

    return text;
  }
}
