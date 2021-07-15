import 'package:dbproject/widgets/logIn.dart';
import 'package:dbproject/widgets/signUp.dart';
import 'package:flutter/material.dart';

import '../database.dart';


class SignUpLogIn extends StatelessWidget {
  const SignUpLogIn( this.db) ;
  final AppDatabase db ;

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      backgroundColor: Colors.white,
  body: SingleChildScrollView(
    child: Column(

      crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      LogIn(db),
      SignUp(db),
          
  ],
    ),
    ),
     
      
    );
  }
}