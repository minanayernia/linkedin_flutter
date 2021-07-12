import 'package:dbproject/views/homeView.dart';
import 'package:flutter/material.dart';
import 'package:dbproject/models/User.dart';
import '../database.dart';
import '../main.dart';


TextEditingController signupUserController = TextEditingController();
TextEditingController signupPassController = TextEditingController();



// class SignUpCard extends StatefulWidget {
//   final AppDatabase db ;
//   const SignUpCard(this.db);

//   void _signUp() async {

//     final userDao = widget.db.userDao ;
//     final User mina = User(1 , 123 , "mina");
//     await userDao.insertUser(mina);
//   }

//   @override
//   _SignUpCardState createState() => _SignUpCardState();
// }

// class _SignUpCardState extends State<SignUpCard> {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
      
//     );
//   }
// }
class SignUpCard extends StatelessWidget {
  final AppDatabase db ;
  
  const SignUpCard(this.db);

  @override
  Widget build(BuildContext context) {

    void _signUp(String username , String password ) async {
    final userDao = db.userDao ;
    final user = User( password , username);
    print(username + password);
    await userDao.insertUser(user);
    // print("111111111111111111111111111111111111");
    // final result = await userDao.findAllusers();
    // print("2222222222222222222222222222222");
    final result = await userDao.findUserByUsernamePassword(password, username);
    print(result);
    Navigator.push(
            context,
            MaterialPageRoute(builder: (context) =>  MyHomePage(this.db , result)),);
    
    // print(signupPassController.text);
  }
    
    return Align(
      alignment: Alignment.center,
      child : Container(
      margin: EdgeInsets.only(top: 50),
      height: MediaQuery.of(context).size.height*0.5,
      width: MediaQuery.of(context).size.width * 0.6,
      color: Colors.black87,
      child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [


        Container(
          margin: EdgeInsets.only(left: 10),
          height: 40,
        alignment: Alignment.centerLeft,
        child: Text("SIGNUP" , 
        style: TextStyle(color: Colors.white , fontSize: 20),),
        ),

        Container(
          color: Colors.redAccent,
          child:TextField(
          controller: signupUserController,
          style: TextStyle(color: Colors.white),
          decoration: InputDecoration(
            fillColor: Colors.white,
          border: OutlineInputBorder(),
          hintText: 'UserName' , 
          hintStyle: TextStyle(color: Colors.white),
          // print("hi"),
          // print(signupUserController),
  ),
          
        ) ,),
        
        Container(
          color: Colors.redAccent,
          child:TextField(
          controller: signupPassController,
          decoration: InputDecoration(
          border: OutlineInputBorder(),
          hintText: 'Password',
          hintStyle: TextStyle(color: Colors.white)
  ),
          
        ) ,),
        
      ButtonTheme(
          height: 40,
          minWidth: MediaQuery.of(context).size.width*0.55,
          buttonColor: Colors.white,
          child: RaisedButton(onPressed: (){
            _signUp(signupUserController.text , signupPassController.text );
            // Navigator.push(
            // context,
            // MaterialPageRoute(builder: (context) => HomeView()),);
          },
           child: Text("SignUp" , style: TextStyle(color: Colors.redAccent),)))

        ],
      ),
      ),
      
    );
  }
}