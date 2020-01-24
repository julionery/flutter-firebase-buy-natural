import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:buy_natural/models/user_model.dart';
import 'package:buy_natural/ui/pages/address_page.dart';
import 'package:buy_natural/ui/pages/contactus_page.dart';
import 'package:buy_natural/ui/pages/login_page.dart';
import 'package:buy_natural/ui/pages/settings_page.dart';
import 'package:buy_natural/ui/pages/user_page.dart';
import 'package:buy_natural/ui/tabs/places_tab.dart';
import 'package:scoped_model/scoped_model.dart';

Color color1 = Colors.green[300];
Color color2 = Colors.green;

class SettingsTab extends StatelessWidget {
  bool isLoggin;

  @override
  Widget build(BuildContext context) {
    isLoggin = UserModel.of(context).isLoggedIn();

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Container(
      width: width,
      height: height,
      child: Stack(
        children: <Widget>[
          Container(
            width: width,
            height: height * .30,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [color1, color2],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          buildHeader(width, height, context),
          buildHeaderData(height, width, context),
          buildHeaderInfoCard(height, width, context),
          buildListPanel(width, height, context),
        ],
      ),
    );
  }

  Widget buildHeader(double width, double height, BuildContext context) {
    return Positioned(
      child: Container(
        width: width,
        height: height * .30,
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(""),
                  isLoggin
                      ? Stack(
                          children: <Widget>[
                            GestureDetector(
                              child: Icon(
                                Icons.exit_to_app,
                                color: Colors.white,
                                size: 30,
                              ),
                              onTap: () {
                                UserModel.of(context).signOut();
                              },
                            )
                          ],
                        )
                      : Text(""),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget buildHeaderData(double height, double width, BuildContext context) {
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('dd MMM yyyy').format(now);

    return ScopedModelDescendant<UserModel>(builder: (context, child, model) {
      return Positioned(
          top: (height * .30) / 2 - 60,
          width: width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                height: 80,
                width: 80,
                child: Text(
                  "Buy\nNatural",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 24),
                ),
              ),
              SizedBox(height: 5),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    isLoggin ? "Olá " + model.userData["name"] : "Olá",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16),
                  ),
                  Text(
                    ", bem vindo.",
                    style: TextStyle(color: Colors.white70, fontSize: 16),
                  ),
                ],
              ),
              Text(
                "Hoje, " + formattedDate,
                style: TextStyle(color: Colors.white70, fontSize: 13),
              ),
            ],
          ));
    });
  }

  Widget buildHeaderInfoCard(
      double height, double width, BuildContext context) {
    if (isLoggin) {
      return Container();
    } else {
      return Positioned(
        top: height * .30 - 25,
        width: width,
        child: Container(
          alignment: Alignment.center,
          child: GestureDetector(
            onTap: () {
              if (isLoggin)
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => UserPage()));
              else
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => LoginPage()));
            },
            child: Container(
              height: 50,
              width: width * .65,
              child: Material(
                  elevation: 3,
                  borderRadius: BorderRadius.circular(30),
                  color: Colors.white,
                  child: buildButtonHeader()),
            ),
          ),
        ),
      );
    }
  }

  Widget buildButtonHeader() {
    if (isLoggin)
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Icon(
            Icons.edit,
            size: 32,
            color: Colors.grey,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 12.0),
            child: Text(
              "EDITAR",
              style: TextStyle(fontSize: 26, color: Colors.grey),
            ),
          )
        ],
      );
    else
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 12.0),
            child: Text(
              "ENTRAR",
              style: TextStyle(fontSize: 26, color: Colors.grey),
            ),
          )
        ],
      );
  }

  Widget buildListItem(
      {IconData icon, String title, String subtitle, Function function}) {
    return Padding(
      padding: const EdgeInsets.only(top: 10, bottom: 10),
      child: ListTile(
        contentPadding: const EdgeInsets.only(left: 10),
        leading: Container(
          height: 60,
          width: 60,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(
              colors: [color1, color2],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Icon(
            icon,
            size: 28,
            color: Colors.white70,
          ),
        ),
        title: Text(
          title,
          style: TextStyle(
            fontSize: 18,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              subtitle,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 16,
              ),
            ),
          ],
        ),
        trailing: Container(
          height: 40,
          width: 40,
          child: Padding(
            padding: const EdgeInsets.only(left: 5),
            child: Row(
              children: <Widget>[
                Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.grey,
                  size: 25,
                ),
              ],
            ),
          ),
        ),
        onTap: function,
      ),
    );
  }

  Widget buildListPanel(double width, double height, BuildContext context) {
    return Positioned(
      width: width,
      height: height * .70 - 40,
      top: height * 0.30 + 34,
      child: Padding(
        padding: const EdgeInsets.only(right: 16, left: 16, top: 10),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Material(
                elevation: 1,
                borderRadius: BorderRadius.circular(20),
                color: Colors.white,
                child: Column(
                  children: <Widget>[
                    buildListItem(
                        icon: Icons.chat,
                        title: "Fale conosco",
                        subtitle: "Mande-nos uma mensagem",
                        function: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => ContactUsPage()));
                        }),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
