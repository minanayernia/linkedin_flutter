import 'package:flutter/material.dart';

import '../database.dart';

var temp ;
var firstname ;
var lasttname ;
var about ;
var birthdate ;
var location ;

class EditIntrCard extends StatelessWidget {
  final AppDatabase db ;
  //final user ;
  final String userName ; 
  final String password ; 
  const EditIntrCard( this.db , this.userName , this.password) ;

  void getIntro() async {
    print("TTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTT") ;
    final id = await db.userDao.findUserByUsernamePassword(password, userName) ;

    temp = id ; 
    print("jjjjjjjjjjjjjjjjjjjjj") ;
    print(temp) ;
    final res = await db.userProfileDao.findProfileByUserId(temp.userId) ;
    firstname = res?.FirstName ;
    print("hhhhhhhhhhhhhhhhhhh") ;

  }
void edit()async{

  getIntro();

  print("oooooooooooooooooooooooooooo") ;
  final res = await db.userProfileDao.editAbout(temp, "gkgmdlg") ;


  about = res?.About ;
  print("RRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRR") ;
  print(about) ;


}
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 20),
      height: MediaQuery.of(context).size.height*0.55,
      width: MediaQuery.of(context).size.width * 0.9,
      color: Colors.black87,
      child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [


        Container(
          margin: EdgeInsets.only(left: 10),
          height: 40,
        alignment: Alignment.centerLeft,
        child: Text("EDIT INTRO" , 
        style: TextStyle(color: Colors.white , fontSize: 20),),
        ),

        Container(
          color: Colors.redAccent,
          child:TextField(
          
          style: TextStyle(color: Colors.white),
          decoration: InputDecoration(
            fillColor: Colors.white,
          border: OutlineInputBorder(),
          hintText: firstname , 
          hintStyle: TextStyle(color: Colors.white)
  ),
          
        ) ,),
        
        Container(
          color: Colors.redAccent,
          child:TextField(
          decoration: InputDecoration(
          border: OutlineInputBorder(),
          hintText: 'LastName',
          hintStyle: TextStyle(color: Colors.white)
  ),
          
        ) ,),


         Container(
          color: Colors.redAccent,
          child:TextField(
          decoration: InputDecoration(
          border: OutlineInputBorder(),
          hintText: about,
          hintStyle: TextStyle(color: Colors.white)
  ),
          
        ) ,),
        
        Container(
          color: Colors.redAccent,
          child:TextField(
          decoration: InputDecoration(
          border: OutlineInputBorder(),
          hintText: "Enter Date",
          suffixIcon: IconButton(
            onPressed: (){},
         // onPressed: () => _controller.clear(),
          icon: Icon(Icons.calendar_today),
    ),
          hintStyle: TextStyle(color: Colors.white)
  ),
          //readOnly: true,
          /*onTap: () async{
            DateTime pickedDate = await showDatePicker(
                      context: context, initialDate: DateTime.now(),
                      firstDate: DateTime(2000), //DateTime.now() - not to allow to choose before today.
                      lastDate: DateTime(2101)
                  );

          },*/
          
        ) ,),


        Container(
          color: Colors.redAccent,
          child:TextField(
          decoration: InputDecoration(
          border: OutlineInputBorder(),
          hintText: 'Location',
          hintStyle: TextStyle(color: Colors.white)
  ),
          
        ) ,),
        Container(
          alignment: Alignment.centerRight,
          child:TextButton(onPressed: edit , child: Text("Save" , style: TextStyle(color: Colors.white),))
        
         ,)
        


        ],
      ),

      
    );
  }
}