import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:buy_natural/models/product_model.dart';

class CartItemModel {
  String cid;

  String category;
  String productId;

  int quantity;
  String size;
  String color;

  ProductModel productData;

  CartItemModel();

  CartItemModel.fromDocument(DocumentSnapshot document) {
    cid = document.documentID;
    category = document.data["category"];
    productId = document.data["productId"];
    quantity = document.data["quantity"];
    size = document.data["size"];
    color = document.data["color"];
  }

  Map<String, dynamic> toMap() {
    return {
      "category": category,
      "productId": productId,
      "quantity": quantity,
      "size": size,
      "color": color,
      "product": productData.toResumedMap()
    };
  }
}
