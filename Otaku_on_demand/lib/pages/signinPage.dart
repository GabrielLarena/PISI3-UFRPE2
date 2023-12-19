import 'dart:io';

import 'package:otaku_on_demand/pages/signupPage.dart';
import 'package:otaku_on_demand/pages/feedPage.dart';
import 'package:otaku_on_demand/pages/forgotPassword.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

final _firebase = FirebaseAuth.instance;

class SignInPage extends StatefulWidget {
  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  void _submit() {}

  final emailController = TextEditingController();
  var senhaController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xfff2f2f2),
        appBar: AppBar(
          leading: new IconButton(
            icon: new Icon(Icons.arrow_back),
            color: Colors.black,
            onPressed: () => Navigator.of(context).pop(),
          ),
          backgroundColor: Colors.white,
        ),
        body: Padding(
          child: Center(
            child: SingleChildScrollView(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                  Container(
                    height: 60,
                    width: 60,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage(
                              "assets/images/logotipo.png",
                            ),
                            fit: BoxFit.fill)),
                  ),
                  Text(
                    "Otaku on \n demand",
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 45.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 20),
                  Text('Login',
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                      )),
                  Divider(),
                  TextFormField(
                    autofocus: true,
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                        labelText: "Email",
                        labelStyle: TextStyle(
                            color: Color.fromRGBO(30, 30, 30, 100),
                            fontSize: 20)),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    autofocus: true,
                    controller: senhaController,
                    keyboardType: TextInputType.text,
                    obscureText: true,
                    decoration: InputDecoration(
                        labelText: "Senha",
                        labelStyle: TextStyle(
                            color: Color.fromRGBO(30, 30, 30, 100),
                            fontSize: 20)),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  new GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ForgotPassword()));
                    },
                    child: Text("Esqueceu a senha?",
                        style: const TextStyle(color: Color(0xffcc4b00))),
                  ),
                  SizedBox(height: 30),
                  Container(
                    height: 50.0,
                    width: 230.0,
                    child: ElevatedButton(
                      child: Text('Login'),
                      style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30)),
                          backgroundColor: Color(0xffcc4b00),
                          textStyle: const TextStyle(
                              color: Colors.white,
                              fontStyle: FontStyle.normal,
                              fontWeight: FontWeight.bold)),
                      //resultado do butão login
                      onPressed: () {
                        try {
                          _firebase.signInWithEmailAndPassword(
                              email: emailController.text,
                              password: senhaController.text);
                        } on FirebaseAuthException catch (error) {
                          ScaffoldMessenger.of(context).clearSnackBars();
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                  error.message ?? 'Falha ao fazer o login.'),
                            ),
                          );
                        }
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => FeedPage()));
                      },
                    ),
                  ),
                  SizedBox(height: 20),
                  Container(
                    height: 40,
                    width: 150,
                    child: ElevatedButton(
                      child: Text('Cadastre-se'),
                      style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                          backgroundColor: Color(0xff9029fb),
                          textStyle: const TextStyle(
                              color: Color(0xff156f43),
                              fontStyle: FontStyle.normal,
                              fontWeight: FontWeight.bold)),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SignUpPage()));
                      },
                    ),
                  )
                ])),
          ),
          padding: EdgeInsets.all(50),
        ));
  }
}
