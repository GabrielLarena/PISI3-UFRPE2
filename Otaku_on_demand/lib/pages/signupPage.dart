import 'package:otaku_on_demand/pages/signinPage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final _firebase = FirebaseAuth.instance;

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController _senha = TextEditingController();
  final TextEditingController _confirmarsenha =
      TextEditingController(); // PasswordValidation

  var _salvarnome = '';
  var _salvaremail = '';
  var _salvarsenha = '';

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
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
              child: Form(
                key: _formKey,
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
                        "Otaku on Demand",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 20),
                      const Text('Cadastro',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                          )),
                      const Divider(),
                      TextFormField(
                        autofocus: true,
                        keyboardType: TextInputType.text,
                        decoration: const InputDecoration(
                            labelText: "Nome Completo",
                            labelStyle: TextStyle(
                                color: Color.fromRGBO(30, 30, 30, 100),
                                fontSize: 15)),
                        validator: (value) {
                          if (value != null && value.isEmpty) {
                            return "O nome é obrigatório";
                          } else if (value != null && value.length > 18) {
                            return "O nome pode ter no máximo 18 caracteres";
                          }

                          _salvarnome = value!;

                          return null;
                        }, // FormValidation
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        autofocus: true,
                        keyboardType: TextInputType.emailAddress,
                        decoration: const InputDecoration(
                            labelText: "Email",
                            labelStyle: TextStyle(
                                color: Color.fromRGBO(30, 30, 30, 100),
                                fontSize: 15)),
                        validator: (value) {
                          if (value != null && value.isEmpty) {
                            return "O email é obrigatório";
                          } else if (value != null &&
                              !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                  .hasMatch(value)) {
                            return "Insira um email valido";
                          }

                          _salvaremail = value!;

                          return null;
                        }, // FormValidation
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        controller: _senha,
                        autofocus: true,
                        keyboardType: TextInputType.text,
                        obscureText: true,
                        decoration: const InputDecoration(
                            labelText: "Senha",
                            labelStyle: TextStyle(
                                color: Color.fromRGBO(30, 30, 30, 100),
                                fontSize: 15)),
                        validator: (value) {
                          if (value != null && value.isEmpty) {
                            return "A senha é obrigatória";
                          } else if (value != null && value.length < 6) {
                            return "A senha precisa ter no mínimo 6 caracteres";
                          }

                          _salvarsenha = value!;

                          return null;
                        }, // FormValidation ,
                      ),
                      const SizedBox(height: 10),
                      TextFormField(
                        controller: _confirmarsenha,
                        autofocus: true,
                        keyboardType: TextInputType.text,
                        obscureText: true,
                        decoration: const InputDecoration(
                            labelText: "Confirmar Senha",
                            labelStyle: TextStyle(
                                color: Color.fromRGBO(30, 30, 30, 100),
                                fontSize: 15)),
                        validator: (value) {
                          if (value != null && value.isEmpty) {
                            return "Reinsira a senha";
                          } else if (_senha.text != _confirmarsenha.text) {
                            return "A confirmação de senha não confere";
                          }

                          return null;
                        }, // FormValidation ,
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
                          onPressed: () {
                            //validação do que foi inserido pelo usuario
                            if (!_formKey.currentState!.validate()) {
                              return;
                            }

                            //firebase salvando email e senha, procurar como salvar nome do usuario depois
                            signUp(_salvaremail, _salvarsenha, _salvarnome);

                            try {
                              _firebase.createUserWithEmailAndPassword(
                                  email: _salvaremail, password: _salvarsenha);
                            } on FirebaseAuthException catch (error) {
                              ScaffoldMessenger.of(context).clearSnackBars();
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content:
                                      Text(error.message ?? 'Falha ao salvar.'),
                                ),
                              );
                            } // FormValidation

                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const SignInPage()));
                          },
                          child: const Text('Cadastrar'),
                        ),
                      ),
                    ]),
              ),
            ),
          ),
        ));
  }

  void signUp(String salvaremail, String salvarsenha, String salvarnome) async {
    try {
      // Create a new user account
      UserCredential userCredential =
          await _firebase.createUserWithEmailAndPassword(
        email: salvaremail,
        password: salvarsenha,
      );

      // Access the user and user ID
      User? user = userCredential.user;

      if (user != null) {
        String userId = user.uid;

        // Add user information to Firestore "users" collection
        await FirebaseFirestore.instance.collection('users').doc(userId).set({
          'email': salvaremail,
          'displayName': salvarnome,
          'favoritos': [], // Initial empty list for favoritos
          'assistir_depois': [], // Initial empty list for assistir_depois
        });

        // The user document is now created in the "users" collection
        print('User account created with ID: $userId');
      } else {
        print('User is null');
      }
    } catch (e) {
      print('Error creating account: $e');
    }
  }
}
