import 'package:dbproject/models/UserProfile.dart';
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

// var checkPass = "Password can't be an empty field" ;
// class SignUpCard extends StatelessWidget {
//   final AppDatabase db ;
  
//   const SignUpCard(this.db);

//   @override
//   Widget build(BuildContext context) {

//     void _signUp(String username , String password ) async {
//     final userDao = db.userDao ;
//     final prifileDao = db.userProfileDao;
//     await prifileDao.deletAllProfile();
//     await userDao.deleteAllUsers();

//     if (username == ""){
//         checkUser = true ;
//         print("boooooz") ;
//     }
//     if (checkUser != true){
//    final user = User( password : password , userName: username );
//     // print(username + password);
//     await userDao.insertUser(user); //kar mikone
//     // final result = await userDao.findAllusers();
//     final result = await userDao.findUserByUsernamePassword(password, username);
//     print("jojoooooooooooo");
//     print(result?.userId);
//     final out = result?.userId;
//     // final chert = await userDao.findUserNameByUserId(result?.userId);
//     // print(await  db.userProfileDao.findProfileByUserId(result?.userId));
//     final userProfileDao = db.userProfileDao ;
//     final userProfile = UserProfile(userId : result?.userId);
//     await userProfileDao.insertUserProfile(userProfile) ;
//     Navigator.push(
//             context,
//             MaterialPageRoute(builder: (context) =>  MyHomePage(this.db , out)),);

//     }
    
//     // print(signupPassController.text);
//   }
    
//     return Align(
//       alignment: Alignment.center,
//       child : Container(
//       margin: EdgeInsets.only(top: 50),
//       height: MediaQuery.of(context).size.height*0.5,
//       width: MediaQuery.of(context).size.width * 0.6,
//       color: Colors.black87,
//       child: Column(
//       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//       children: [


//         Container(
//           margin: EdgeInsets.only(left: 10),
//           height: 40,
//         alignment: Alignment.centerLeft,
//         child: Text("SIGNUP" , 
//         style: TextStyle(color: Colors.white , fontSize: 20),),
//         ),

//         Container(
//           color: Colors.redAccent,
//           child:TextField(
//           controller: signupUserController,
//           style: TextStyle(color: Colors.white),
//           decoration: InputDecoration(
//             fillColor: Colors.white,
//           border: OutlineInputBorder(),
//           hintText: 'UserName' , 
//           hintStyle: TextStyle(color: Colors.white),
//           // print("hi"),
//           // print(signupUserController),
//   ),
          
//         ) ,),
//         Visibility(
//           visible: checkUser,
//           child: Container(child: Text("User name can't be an empty field" , style: TextStyle(color: Colors.redAccent),),),),
        
        
//         Container(
//           color: Colors.redAccent,
//           child:TextField(
//           obscureText: true,
//           controller: signupPassController,
//           decoration: InputDecoration(
//           border: OutlineInputBorder(),
//           fillColor: Colors.white,

//           hintText: 'Password',
//           hintStyle: TextStyle(color: Colors.white)
//   ),
          
//         ) ,),
        
//       ButtonTheme(
//           height: 40,
//           minWidth: MediaQuery.of(context).size.width*0.55,
//           buttonColor: Colors.white,
//           child: RaisedButton(onPressed: (){
//             _signUp(signupUserController.text , signupPassController.text );
//           },
//            child: Text("SignUp" , style: TextStyle(color: Colors.redAccent),)))

//         ],
//       ),
//       ),
      
//     );
//   }
// }




class SignUp extends StatefulWidget {
   final AppDatabase db ;
  const SignUp(this.db);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  DateTime? _dateTime;
  bool checkUser = false ;
  bool checkPass = false ;
  bool checkCopyUser = false ; 
  bool checkDate = false ; 
  @override
  Widget build(BuildContext context) {
   void _signUp(String username , String password ) async {
    final userDao = widget.db.userDao ;
    final prifileDao = widget.db.userProfileDao;
    // await widget.db.skillDao.deleteSkills();
    // await prifileDao.deletAllProfile();
    // await userDao.deleteAllUsers();
    
    final checkUserName = await userDao.findeUserByUserName(username) ;
    print("KKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKK");
    print(username);

    setState(() {
      if (_dateTime == null ){
        checkDate = true ;  

        
    }
    if (_dateTime != null){
        checkDate = false ;  
        
    }
    });
    setState(() {
      if (username == "" && password == ""){
        checkUser = true ;
        checkPass = true ;
        print("boooooz") ;  

        
    }
    });
    setState(() {
      if (username != "" && password == ""){
        checkUser = false ;
        checkPass = true ;
      }
    });

    setState(() {
      if (username == "" && password != ""){
        checkUser = true ;
        checkPass = false ;
      }
    });


    setState(() {
            if (checkUserName != null) {
          checkCopyUser = !checkCopyUser ;

      }
    });

    if (username != "" && password != "" && checkUserName == null && _dateTime != null ){
   final user = User( password : password , userName: username  , birthday : _dateTime!);
   var useid = user.userId ;
   print("this is my user id before inserting to database : $useid");
    // print(username + password);
    await userDao.insertUser(user); //kar mikone
    // final result = await userDao.findAllusers();
    final result = await userDao.findUserByUsernamePassword(password, username);
    
    print("jojoooooooooooo");
    print(result?.userId);
    final out = result?.userId;
    // final chert = await userDao.findUserNameByUserId(result?.userId);
    // print(await  db.userProfileDao.findProfileByUserId(result?.userId));
    final userProfileDao = widget.db.userProfileDao ;
    final userProfile ;
    var profid ;
    if (result != null ){
      userProfile = UserProfile(userId : result.userId , );
      print("this is my profileid in sign up page before adding to database : $profid");
      await userProfileDao.insertUserProfile(userProfile) ;
      print("profile added!");
    }else{
      print("the result of findUserByUserName is null ");
    }
    
    
    
    var prof ;
    var profid2;
    if (out != null){
      widget.db.userProfileDao.findProfileByUserId(out).then((value) => setState((){
        if (value != null){
          print("the value of findProfileByUserId is not null");
          profid2 = value.ProfileId ;
          print("this is my profileid in after adding to database : $profid2");
          // print(object
        }else{
          print("the value of profile is null");
        }
      }));
    }
    
    signupUserController.text = "";
    signupPassController.text = "";
    Navigator.push(
            context,
            MaterialPageRoute(builder: (context) =>  MyHomePage(widget.db , out)),);

    }
    
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
        Visibility(
          visible: checkUser,
          child: Container(child: Text("User name can't be an empty field" , style: TextStyle(color: Colors.redAccent),),),),

          Visibility(
          visible: checkCopyUser,
          child: Container(child: Text("This user name already exists!" , style: TextStyle(color: Colors.redAccent),),),),
        
        
        Container(
          color: Colors.redAccent,
          child:TextField(
          obscureText: true,
          controller: signupPassController,
          decoration: InputDecoration(
          border: OutlineInputBorder(),
          fillColor: Colors.white,

          hintText: 'Password',
          hintStyle: TextStyle(color: Colors.white)
  ),
          
        ) ,),

        Visibility(
          visible: checkPass,
          child: Container(child: Text("password can't be an empty field" , style: TextStyle(color: Colors.redAccent),),),),
          //for adding birthday
          // Container(
          // color: Colors.redAccent,
          // child:InputDatePickerFormField(firstDate: DateTime.now(), lastDate:  DateTime.now(),)),
  
          Text(_dateTime == null ? "pick your birthday ": _dateTime.toString() , style: TextStyle(color:Colors.white),),
          Visibility(
          visible: checkDate,
          child: Container(child: Text("Birthday field can't be empty!" , style: TextStyle(color: Colors.redAccent),),),),

          ButtonTheme(
            height: 40,
          minWidth: MediaQuery.of(context).size.width*0.2,
          buttonColor: Colors.redAccent,
            child: RaisedButton(
            child: Text("Pick date" , style: TextStyle(color:Colors.white),),
            onPressed: (){
              showDatePicker(context: context,
               initialDate: DateTime.now(),
                firstDate: DateTime(1990), 
              lastDate: DateTime.now()).then((date) => setState((){
                _dateTime = date ;
              }));
            }),),
          

        
      ButtonTheme(
          height: 40,
          minWidth: MediaQuery.of(context).size.width*0.55,
          buttonColor: Colors.white,
          child: RaisedButton(onPressed: (){
            _signUp(signupUserController.text , signupPassController.text );
          },
           child: Text("SignUp" , style: TextStyle(color: Colors.redAccent),)))

        ],
      ),
      ),
      
    );
  }
}