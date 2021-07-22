import 'package:dbproject/views/homeView.dart';
import 'package:dbproject/views/otherUserView.dart';
import 'package:flutter/material.dart';


import '../database.dart';
import '../main.dart';
TextEditingController loginUserController = TextEditingController();
TextEditingController loginPassController = TextEditingController();


class LogIn extends StatefulWidget {
  const LogIn(this.db) ;
  final AppDatabase db ;

  @override
  _LogInState createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  bool userExist = false ;


  @override
  Widget build(BuildContext context) {

    void _login(String username , String password) async {
      final userDao = widget.db.userDao ;
      final prifileDao = widget.db.userProfileDao;
      final findUser = await userDao.findUserByUsernamePassword(password, username);


      setState(() {
        if(findUser == null){
          userExist = true ;
        }

      });


      if(findUser != null){
        loginUserController.text = "";
        loginPassController.text = "";
        final out = findUser.userId;
        Navigator.push(
            context,
            MaterialPageRoute(builder: (context) =>  MyHomePage(this.widget.db , out)),);

    }


    }


    

    return Align(
      alignment: Alignment.center,
      child : Container(
      margin: EdgeInsets.only(top: 50),
      height: MediaQuery.of(context).size.height*0.5,
      width: MediaQuery.of(context).size.width * 0.6,
      color: Colors.white60,
      child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [


        Container(
          margin: EdgeInsets.only(left: 10),
          height: 40,
        alignment: Alignment.centerLeft,
        child: Text("LOGIN" , 
        style: TextStyle(color: Colors.redAccent , fontSize: 20),),
        ),

        Container(
          color: Colors.white,
          child:TextField(
            controller: loginUserController,
          
          style: TextStyle(color: Colors.redAccent),
          decoration: InputDecoration(
            fillColor: Colors.white,
          border: OutlineInputBorder(),
          hintText: 'UserName' , 
          hintStyle: TextStyle(color: Colors.redAccent)
  ),
          
        ) ,),
        
        Container(
          color: Colors.white,
          child:TextField(
          obscureText: true,
          controller: loginPassController,
          decoration: InputDecoration(
          border: OutlineInputBorder(),
          hintText: 'Password',
          hintStyle: TextStyle(color: Colors.redAccent)
  ),
          
        ) ,),

        Visibility(
          visible: userExist,
          child: Container(child: Text("Incorrect user name or password!" , style: TextStyle(color: Colors.redAccent),),),),

        ButtonTheme(
          height: 40,
          minWidth: MediaQuery.of(context).size.width*0.55,
          buttonColor: Colors.redAccent,
          child: RaisedButton(onPressed: (){
            _login(loginUserController.text, loginPassController.text) ;
          },
  //           Navigator.push(
  //           context,
  //           MaterialPageRoute(builder: (context) => OtherUserView(widget.db)),
  // );
  //         },
           child: Text("LogIn" , style: TextStyle(color: Colors.white),))
           )

        


        ],
      ),

      ),
      
    );
  }
}

class LogInCard extends StatelessWidget {
  
  const LogInCard(this.db) ;
  final AppDatabase db ;

  @override
  Widget build(BuildContext context) {

    void _login(String username , String password)async{
    final userDao = db.userDao ;
    final user = await userDao.findUserByUsernamePassword(password, username);
    Navigator.push(
            context,
            MaterialPageRoute(builder: (context) =>  MyHomePage(this.db , user?.userId)),);

  }

    return Align(
      alignment: Alignment.center,
      child : Container(
      margin: EdgeInsets.only(top: 50),
      height: MediaQuery.of(context).size.height*0.5,
      width: MediaQuery.of(context).size.width * 0.6,
      color: Colors.white60,
      child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [


        Container(
          margin: EdgeInsets.only(left: 10),
          height: 40,
        alignment: Alignment.centerLeft,
        child: Text("LOGIN" , 
        style: TextStyle(color: Colors.redAccent , fontSize: 20),),
        ),

        Container(
          color: Colors.white,
          child:TextField(
            controller: loginUserController,
          
          style: TextStyle(color: Colors.redAccent),
          decoration: InputDecoration(
            fillColor: Colors.white,
          border: OutlineInputBorder(),
          hintText: 'UserName' , 
          hintStyle: TextStyle(color: Colors.redAccent)
  ),
          
        ) ,),
        
        Container(
          color: Colors.white,
          child:TextField(
          obscureText: true,
          controller: loginPassController,
          decoration: InputDecoration(
          border: OutlineInputBorder(),
          hintText: 'Password',
          hintStyle: TextStyle(color: Colors.redAccent)
  ),
          
        ) ,),

  //       ButtonTheme(
  //         height: 40,
  //         minWidth: MediaQuery.of(context).size.width*0.55,
  //         buttonColor: Colors.redAccent,
  //         child: RaisedButton(onPressed: (){
  //           Navigator.push(
  //           context,
  //           MaterialPageRoute(builder: (context) => OtherUserView(db , user)),
  // );
  //         },
  //          child: Text("LogIn" , style: TextStyle(color: Colors.white),))
  //          )

        


        ],
      ),

      ),
      
      
    );
  }
}