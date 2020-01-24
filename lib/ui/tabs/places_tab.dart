import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:buy_natural/ui/tiles/place_tile.dart';

class PlacesTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Nossas Lojas"),
        centerTitle: true,
      ),
      body: FutureBuilder<QuerySnapshot>(
        future: Firestore.instance.collection("places").getDocuments(),
        builder: (context, snapshot) {
          if (!snapshot.hasData)
            return Center(
              child: CircularProgressIndicator(),
            );
          else {
            return ListView(
              children:
                  snapshot.data.documents.map((doc) => PlaceTile(doc)).toList(),
            );
          }
        },
      ),
    );
  }
}
