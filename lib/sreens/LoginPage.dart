import 'package:flutter/material.dart';
import 'VocaPage.dart';

// import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
// import 'package:google_sign_in/google_sign_in.dart';
// import 'package:amazon_cognito_identity_dart_2/cognito.dart';
// import 'package:amazon_cognito_identity_dart_2/sig_v4.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=>VocaPage()),
            );
          },
          child: Text('로그인완료'),
        )
      ),
    );
  }
}
