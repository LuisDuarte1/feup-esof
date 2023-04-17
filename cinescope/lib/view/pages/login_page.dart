import 'package:cinescope/utils/validators.dart';
import 'package:cinescope/view/pages/main_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

import '../button/login_button.dart';

class LoginPage extends StatefulWidget {
  final String? email;
  const LoginPage({super.key, this.email});

  @override
  State<StatefulWidget> createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _textEditingControllerEmail =
      TextEditingController();
  final TextEditingController _textEditingControllerPassword =
      TextEditingController();

  void Function() loginButtonHandler(BuildContext context) {
    return () {
      if (_formKey.currentState!.validate()) {
        FirebaseAuth.instance
            .signInWithEmailAndPassword(
                email: _textEditingControllerEmail.text,
                password: _textEditingControllerPassword.text)
            .then((value) => Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const MainPage())))
            .onError((error, stackTrace) {
          final FirebaseAuthException err = error as FirebaseAuthException;
          if (err.code == "invalid-email" || err.code == "user-not-found") {
            showDialog(
                context: context,
                builder: ((context) => AlertDialog(
                      title: const Text("Login failed"),
                      content: const Text("Invalid email or not found."),
                      actions: [
                        TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: const Text("Ok"))
                      ],
                    )));
          }
          if (err.code == "wrong-password") {
            showDialog(
                context: context,
                builder: ((context) => AlertDialog(
                      title: const Text("Login failed"),
                      content: const Text(
                        "Invalid password",
                        textScaleFactor: 1.2,
                      ),
                      actions: [
                        TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: const Text("Ok"))
                      ],
                    )));
          }
        });
      }
    };
  }

  @override
  Widget build(BuildContext context) {
    _textEditingControllerEmail.text = widget.email ?? '';
    return Scaffold(
        body: Container(
            padding: const EdgeInsets.all(20),
            color: const Color(0XFF07393C),
            child: Center(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                  const Padding(padding: EdgeInsets.symmetric(vertical: 20)),
                  Image.asset(
                    "assets/logo-no-background.png",
                    color: Colors.white,
                  ),
                  const Padding(padding: EdgeInsets.symmetric(vertical: 15)),
                  const Text(
                    "Login:",
                    textAlign: TextAlign.left,
                    style: TextStyle(color: Colors.white, fontSize: 35),
                  ),
                  const Padding(padding: EdgeInsets.symmetric(vertical: 20)),
                  Form(
                    key: _formKey,
                    child: Column(children: [
                      TextFormField(
                        controller: _textEditingControllerEmail,
                        decoration: const InputDecoration(
                          fillColor: Colors.white,
                          focusColor: Colors.white,
                          border: OutlineInputBorder(),
                          labelText: 'Email',
                        ),
                        validator: emailValidator,
                      ),
                      const Padding(
                          padding: EdgeInsets.symmetric(vertical: 10)),
                      TextFormField(
                        controller: _textEditingControllerPassword,
                        decoration: const InputDecoration(
                          fillColor: Colors.white,
                          focusColor: Colors.white,
                          border: OutlineInputBorder(),
                          labelText: 'Password',
                        ),
                        obscureText: true,
                      ),
                    ]),
                  ),
                  const Padding(padding: EdgeInsets.symmetric(vertical: 10)),
                  LoginButton(
                      pressedFunction: loginButtonHandler(context),
                      childWidget: const Text("Sign-in with email")),
                ]))));
  }
}
