// import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ipk_kalkulator/pages/login_page.dart';
import 'package:ipk_kalkulator/pages/loginorRegister.dart';
import 'package:ipk_kalkulator/pages/main_page.dart';

class authPage extends StatelessWidget {
  const authPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return mainPage();
          } else {
            return LoginOrRegister();
          }
        },
      ),
    );
  }
}
