import 'dart:js';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:ipk_kalkulator/components/my_button.dart';
import 'package:ipk_kalkulator/components/textField.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ipk_kalkulator/pages/authpage.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({
    super.key,
    required this.onTap,
  });
  final Function()? onTap;

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

TextEditingController emailController = TextEditingController();
TextEditingController passwordController = TextEditingController();
TextEditingController confirmPasswordController = TextEditingController();

class _RegisterPageState extends State<RegisterPage> {
  @override
  Widget build(BuildContext context) {
    void wrongMessage(String Message) {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              backgroundColor: Colors.red,
              title: Container(
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(5)),
                  child: Text(Message)),
            );
          });
    }

    void confirmPassword() {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              backgroundColor: Colors.red,
              title: Container(
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(5)),
                  child: Text("Password not same")),
            );
          });
    }

    void SignUserUp() async {
      //show Dialog
      showDialog(
          context: context,
          builder: (context) {
            return Center(
              child: CircularProgressIndicator(),
            );
          });
      try {
        if (passwordController.text == confirmPasswordController.text) {
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: emailController.text,
            password: passwordController.text,
          );
        } else {
          Navigator.pop(context);
          confirmPassword();
        }
      } on FirebaseAuthException catch (e) {
        Navigator.pop(context);
        wrongMessage(e.code);
      }
    }

    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 50.0),
            child: Icon(
              Icons.lock,
              size: 100,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 4),
            child: textFieldTile(
              hintText: "Name",
              controller: emailController,
              obsecureText: false,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 4),
            child: textFieldTile(
              hintText: "Password",
              controller: passwordController,
              obsecureText: true,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 4),
            child: textFieldTile(
              hintText: "Confirm Password",
              controller: confirmPasswordController,
              obsecureText: true,
            ),
          ),
          my_button(
            text: "Sign Up",
            onTap: SignUserUp,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 50.0),
            child: Text("or"),
          ),
          Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(5)),
            height: size.height / 20,
            width: size.width * 0.8,
            child: OutlinedButton.icon(
                onPressed: () {},
                icon: Image(
                  image: AssetImage("assets/google.png"),
                  width: 60,
                ),
                label: Text("Sign In with Google")),
          ),
          Spacer(),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 50.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Dont have an account yet? "),
                GestureDetector(
                    onTap: widget.onTap,
                    child: Text(
                      "Login now",
                      style: TextStyle(color: Colors.blue),
                    )),
              ],
            ),
          )
        ],
      ),
    );
  }
}
