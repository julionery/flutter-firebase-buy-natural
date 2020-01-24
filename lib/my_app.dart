import 'package:flutter/material.dart';
import 'package:buy_natural/models/cart_model.dart';
import 'package:buy_natural/models/user_model.dart';
import 'package:buy_natural/ui/pages/home_page.dart';
import 'package:scoped_model/scoped_model.dart';

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScopedModel<UserModel>(
        model: UserModel(),
        child:
            ScopedModelDescendant<UserModel>(builder: (context, child, model) {
          return ScopedModel<CartModel>(
            model: CartModel(model),
            child: MaterialApp(
                title: 'Buy Natural',
                theme: ThemeData(
                  brightness: Brightness.light,
                  primarySwatch: Colors.green,
                ),
                debugShowCheckedModeBanner: false,
                home: HomePage()),
          );
        }));
  }
}
