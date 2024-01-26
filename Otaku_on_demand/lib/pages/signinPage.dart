import 'package:otaku_on_demand/pages/signupPage.dart';
import 'package:otaku_on_demand/pages/feedPage.dart';
import 'package:otaku_on_demand/pages/forgotPassword.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:otaku_on_demand/model/animemodel.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final _emailController = TextEditingController();
  final _senhaController = TextEditingController();
  final _firebaseAuth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xfff2f2f2),
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            color: Colors.black,
            onPressed: () => Navigator.of(context).pop(),
          ),
          backgroundColor: Colors.white,
        ),
        body: Padding(
          padding: const EdgeInsets.all(50),
          child: Center(
            child: SingleChildScrollView(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                  Container(
                    height: 60,
                    width: 60,
                    decoration: const BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage(
                              "assets/images/logotipo.png",
                            ),
                            fit: BoxFit.fill)),
                  ),
                  const Text(
                    "Otaku on \n demand",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 45.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text('Login',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                      )),
                  const Divider(),
                  TextFormField(
                    autofocus: true,
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                        labelText: "Email",
                        labelStyle: TextStyle(
                            color: Color.fromRGBO(30, 30, 30, 100),
                            fontSize: 20)),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    autofocus: true,
                    controller: _senhaController,
                    keyboardType: TextInputType.text,
                    obscureText: true,
                    decoration: const InputDecoration(
                        labelText: "Senha",
                        labelStyle: TextStyle(
                            color: Color.fromRGBO(30, 30, 30, 100),
                            fontSize: 20)),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const ForgotPassword()));
                    },
                    child: const Text("Esqueceu a senha?",
                        style: TextStyle(color: Color(0xffcc4b00))),
                  ),
                  const SizedBox(height: 30),
                  SizedBox(
                    height: 50.0,
                    width: 230.0,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30)),
                          backgroundColor: const Color(0xffcc4b00),
                          foregroundColor: Colors.white,
                          textStyle: const TextStyle(
                              fontStyle: FontStyle.normal,
                              fontWeight: FontWeight.bold)),
                      //resultado do butão login
                      onPressed: () {
                        login();
                      },
                      child: const Text('Login'),
                    ),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    height: 40,
                    width: 150,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                          backgroundColor: const Color(0xff9029fb),
                          foregroundColor: Colors.white,
                          textStyle: const TextStyle(
                              fontStyle: FontStyle.normal,
                              fontWeight: FontWeight.bold)),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const SignUpPage()));
                      },
                      child: const Text('Cadastre-se'),
                    ),
                  )
                ])),
          ),
        ));
  }

  login() async {
    try {
      UserCredential userCredential =
          await _firebaseAuth.signInWithEmailAndPassword(
              email: _emailController.text, password: _senhaController.text);
      // ignore: unnecessary_null_comparison
      if (userCredential != null) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const FeedPage()),
        );
      }
    } on FirebaseAuthException {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Email ou senha invalida'),
        backgroundColor: Colors.red,
        duration: Duration(seconds: 4),
      ));
    }
  }
}
