import 'package:dbproject/widgets/logIn.dart';
import 'package:dbproject/widgets/signUp.dart';
import 'package:flutter/material.dart';


class SignUpLogIn extends StatelessWidget {
  const SignUpLogIn({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      backgroundColor: Colors.white,
  body: SingleChildScrollView(
    child: Column(

      crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      LogInCard(),
      SignUpCard(),
          
  ],
    ),
    ),
     
      
    );
  }
}