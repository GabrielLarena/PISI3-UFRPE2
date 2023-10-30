import 'package:flutter/material.dart';

class ForgotPassword extends StatefulWidget {
  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff2f2f2),
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
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      height: 60,
                      width: 60,
                      decoration: const BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage(
                        "assets/images/logotipo.jpg",
                      ))),
                    ),
                    const Text(
                      "Otaku on demand",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 45.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Divider(),
                  ],
                ),
                const Text(
                  'Recuperar senha',
                  style: TextStyle(color: Colors.black, fontSize: 15),
                ),
                const SizedBox(
                  height: 60,
                ),
                TextFormField(
                  autofocus: true,
                  keyboardType: TextInputType.name,
                  decoration: const InputDecoration(
                    labelText: 'Nome Completo',
                    labelStyle: TextStyle(
                      color: Color.fromRGBO(30, 30, 30, 100),
                      fontSize: 20,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                TextFormField(
                  autofocus: true,
                  keyboardType: TextInputType.name,
                  decoration: const InputDecoration(
                    labelText: 'Email',
                    labelStyle: TextStyle(
                      color: Color.fromRGBO(30, 30, 30, 100),
                      fontSize: 20,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
                Container(
                  height: 50.0,
                  width: 230.0,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30)),
                        backgroundColor: const Color(0xff29af6f),
                        textStyle: const TextStyle(
                          color: Colors.white,
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.bold,
                        )),
                    onPressed: () {
                      _showPopup();
                    },
                    child: const Text('Confirmar'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showPopup() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          insetPadding: const EdgeInsets.all(30),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          title: const Text('Aviso', textAlign: TextAlign.center),
          content: const Text(
              'UM LINK DE RECUPERAÇÃO DE SENHA FOI ENVIADO PARA '
              'O SEU EMAIL',
              style: TextStyle(color: Colors.black54),
              textAlign: TextAlign.center),
          actions: <Widget>[
            Center(
              child: Container(
                height: 50.0,
                width: 150.0,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30)),
                      backgroundColor: const Color(0xff29af6f),
                      textStyle: const TextStyle(
                        color: Colors.white,
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.bold,
                      )),
                  child: const Text('Ok'),
                ),
              ),
            ),
          ],
        );
        ;
      },
    );
  }
}
