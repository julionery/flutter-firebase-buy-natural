import 'package:carousel_pro/carousel_pro.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:buy_natural/models/cart_item_model.dart';
import 'package:buy_natural/models/cart_model.dart';
import 'package:buy_natural/models/product_model.dart';
import 'package:buy_natural/models/user_model.dart';
import 'package:buy_natural/ui/pages/cart_page.dart';

import 'login_page.dart';

class ProductPage extends StatefulWidget {
  final ProductModel product;

  ProductPage(this.product);

  @override
  _ProductPageState createState() => _ProductPageState(product);
}

class _ProductPageState extends State<ProductPage> {
  final ProductModel product;

  String size;
  String color;
  int qtd = 0;
  final _qtd = TextEditingController();
  bool _validate = false;

  _ProductPageState(this.product);

  @override
  void dispose() {
    _qtd.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Color primaryColor = Theme.of(context).primaryColor;

    return Scaffold(
      appBar: AppBar(
        title: Text(product.title),
        centerTitle: true,
      ),
      body: ListView(
        children: <Widget>[
          AspectRatio(
            aspectRatio: 0.9,
            child: Carousel(
              images: product.images.map((url) {
                return NetworkImage(url);
              }).toList(),
              dotSize: 4.0,
              dotSpacing: 15.0,
              dotBgColor: Colors.transparent,
              dotColor: primaryColor,
              autoplay: true,
            ),
          ),
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Text(
                  product.title,
                  style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w500),
                  maxLines: 3,
                ),
                SizedBox(
                  height: 16.0,
                ),
                Text(
                  "Descrição:",
                  style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500),
                ),
                SizedBox(
                  height: 4.0,
                ),
                Text(
                  product.description != null ? product.description : "",
                  style: TextStyle(
                    fontSize: 16.0,
                  ),
                ),
                SizedBox(
                  height: 16.0,
                ),
                Text(
                  "Quantidade:",
                  style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500),
                ),
                TextField(
                  controller: _qtd,
                  decoration: new InputDecoration(
                    labelText: "Informe a quantidade...",
                    errorText:
                        _validate ? 'Este campo não deve ficar vazio!' : null,
                  ),
                  keyboardType: TextInputType.number,
                  onChanged: (text) {
                    setState(() {
                      if (_qtd.text.isEmpty || int.parse(_qtd.text) == 0) {
                        _validate = true;
                      } else {
                        _validate = false;
                        qtd = int.parse(_qtd.text);
                      }
                    });
                    return null;
                  },
                ),
                SizedBox(
                  height: 16.0,
                ),
                Text(
                  "Frequência:",
                  style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500),
                ),
                SizedBox(
                  height: 50.0,
                  child: FutureBuilder<QuerySnapshot>(
                      future: Firestore.instance
                          .collection("products")
                          .document(product.category)
                          .collection("items")
                          .document(product.id)
                          .collection("frequency")
                          .getDocuments(),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData)
                          return Center(child: CircularProgressIndicator());
                        else {
                          return GridView.builder(
                              scrollDirection: Axis.horizontal,
                              padding: EdgeInsets.symmetric(vertical: 4.0),
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 1,
                                mainAxisSpacing: 8.0,
                                childAspectRatio: 0.5,
                              ),
                              itemCount: snapshot.data.documents.length,
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      color = null;
                                      size = snapshot
                                          .data.documents[index].data["title"];
                                    });
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(4.0)),
                                        border: Border.all(
                                            color: snapshot
                                                        .data
                                                        .documents[index]
                                                        .data["title"] ==
                                                    size
                                                ? primaryColor
                                                : Colors.grey[500],
                                            width: 3.0)),
                                    width: 50.0,
                                    alignment: Alignment.center,
                                    child: Text(
                                      snapshot
                                          .data.documents[index].data["title"],
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                );
                              });
                        }
                      }),
                ),
                SizedBox(
                  height: 16.0,
                ),
                SizedBox(
                  height: 44.0,
                  child: RaisedButton(
                      child: Text(
                        UserModel.of(context).isLoggedIn()
                            ? "Adicionar ao Carrinho"
                            : "Entre para Comprar",
                        style: TextStyle(fontSize: 18.0),
                      ),
                      color: primaryColor,
                      textColor: Colors.white,
                      onPressed: _qtd.text.isNotEmpty &&
                              int.parse(_qtd.text) != 0 &&
                              size != null
                          ? () {
                              if (UserModel.of(context).isLoggedIn()) {
                                CartItemModel cartProduct = CartItemModel();
                                cartProduct.size = size;
                                cartProduct.color = color;
                                cartProduct.quantity = qtd;
                                cartProduct.productId = product.id;
                                cartProduct.category = product.category;
                                cartProduct.productData = product;

                                CartModel.of(context).addCartItem(cartProduct);
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => CartPage()));
                              } else {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => LoginPage()));
                              }
                            }
                          : null),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
