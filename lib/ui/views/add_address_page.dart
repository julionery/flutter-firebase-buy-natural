import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:buy_natural/models/user_model.dart';
import 'package:buy_natural/ui/pages/login_page.dart';

class AddAddressPage extends StatelessWidget {
  final DocumentSnapshot snapshot;

  const AddAddressPage(this.snapshot);

  @override
  Widget build(BuildContext context) {
    if (UserModel.of(context).isLoggedIn()) {
      String uid = UserModel.of(context).firebaseUser.uid;

      return Scaffold(
        appBar: AppBar(
          title: Text(snapshot == null
              ? "Adicionar Novo Endereço"
              : "Editar Endereço de Envio"),
          centerTitle: true,
        ),
        body: Container(),
      );
    } else {
      return Scaffold(
        appBar: AppBar(
          title: Text("Endereços"),
          centerTitle: true,
        ),
        body: Container(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(
                Icons.view_list,
                size: 80.0,
                color: Theme.of(context).primaryColor,
              ),
              SizedBox(
                height: 16.0,
              ),
              Text(
                "Faça o login para acompanhar!",
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 16.0,
              ),
              RaisedButton(
                color: Theme.of(context).primaryColor,
                textColor: Colors.white,
                child: Text(
                  "Entrar",
                  style: TextStyle(fontSize: 18.0),
                ),
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => LoginPage()),
                  );
                },
              )
            ],
          ),
        ),
      );
    }
  }
}
