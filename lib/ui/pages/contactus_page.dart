import 'package:flutter/material.dart';
import 'package:buy_natural/models/contact_model.dart';
import 'package:scoped_model/scoped_model.dart';

class ContactUsPage extends StatefulWidget {
  @override
  _ContactUsPageState createState() => _ContactUsPageState();
}

class _ContactUsPageState extends State<ContactUsPage> {
  final _nameController = TextEditingController();

  final _emailController = TextEditingController();

  final _phoneController = TextEditingController();

  final _messageController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: Text("FALE CONOSCO"),
          centerTitle: true,
        ),
        body: ScopedModel<ContactModel>(
            model: ContactModel(),
            child: ScopedModelDescendant<ContactModel>(
                builder: (context, child, model) {
              if (model.isLoading)
                return Center(
                  child: CircularProgressIndicator(),
                );
              return Form(
                  key: _formKey,
                  child: ListView(
                    padding: EdgeInsets.all(16.0),
                    children: <Widget>[
                      TextFormField(
                        controller: _nameController,
                        decoration: InputDecoration(hintText: "Nome"),
                      ),
                      SizedBox(
                        height: 16.0,
                      ),
                      TextFormField(
                        controller: _emailController,
                        decoration: InputDecoration(hintText: "E-mail"),
                        keyboardType: TextInputType.emailAddress,
                      ),
                      SizedBox(
                        height: 16.0,
                      ),
                      TextFormField(
                        controller: _phoneController,
                        decoration: InputDecoration(hintText: "Telefone"),
                        keyboardType: TextInputType.phone,
                      ),
                      SizedBox(
                        height: 16.0,
                      ),
                      TextFormField(
                        controller: _messageController,
                        maxLines: 4,
                        decoration: InputDecoration(hintText: "Mensagem*"),
                        validator: (text) {
                          if (text.isEmpty) return "Informe a mensagem!";
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 16.0,
                      ),
                      SizedBox(
                        height: 44.0,
                        child: RaisedButton(
                          child: Text(
                            "ENVIAR",
                            style: TextStyle(fontSize: 18.0),
                          ),
                          textColor: Colors.white,
                          color: Theme.of(context).primaryColor,
                          onPressed: () {
                            if (_formKey.currentState.validate()) {
                              Map<String, dynamic> _data = {
                                "name": _nameController.text,
                                "email": _emailController.text,
                                "phone": _phoneController.text,
                                "message": _messageController.text
                              };

                              model.send(
                                  data: _data,
                                  onSuccess: _onSuccess,
                                  onFail: _onFail);
                            }
                          },
                        ),
                      )
                    ],
                  ));
            })));
  }

  void _onSuccess() {
    _scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text("Mensagem enviada com sucesso!"),
      backgroundColor: Colors.green,
      duration: Duration(seconds: 2),
    ));

    Future.delayed(Duration(seconds: 2)).then((_) {
      Navigator.of(context).pop();
    });
  }

  void _onFail() {
    _scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text("Falha ao enviar a mensagem!"),
      backgroundColor: Colors.redAccent,
      duration: Duration(seconds: 2),
    ));
  }
}
