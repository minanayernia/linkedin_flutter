import 'package:flutter/material.dart';
// final dataKey = new GlobalKey();
class Message extends StatelessWidget {
  const Message({ Key ? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 20),
      height: 600,
      width: MediaQuery.of(context).size.width*0.9,
      color: Colors.black87,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
            
        Container(
         width: MediaQuery.of(context).size.width*0.45,

          child: Column(children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                Container(
                  // key: dataKey,
                  padding: EdgeInsets.only(left: 10),
                  child:Text("Messaging" , style: TextStyle(color: Colors.white),)  ,),
                
                TextButton(onPressed: (){}, child: Text("New Message")),
              ],),

              TextField(
                decoration: InputDecoration(
                  hintText: "Search messages"
                ),
              ),


              Container(
                height: 500,
                child:
               SingleChildScrollView(
                child: Column(children: [

                  UserCard(),
                  UserCard(),
                  UserCard(),
          
                  UserCard(),
                  UserCard(),
                  UserCard(),
                   UserCard(),
                  UserCard(),
          
                  UserCard(),
                  UserCard(),
                   UserCard(),
                  UserCard(),
          
                  UserCard(),
                  UserCard(),
                ],),
              ) ,) ,
              


            ]),),

            Container(
            color: Colors.white,

          width: MediaQuery.of(context).size.width*0.45,

          child: Column(children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                Container(
                  padding: EdgeInsets.only(left: 10),
                  child:Text("User" , style: TextStyle(color: Colors.redAccent),)  ,),
                
                PopupMenuButton(
                icon: Icon(Icons.more_horiz),
                itemBuilder: (context) => [
                  PopupMenuItem(
                    child: Text("Archieve"),
                    value: 1,
                  ),
                  PopupMenuItem(
                    child: Text("Mark unread"),
                    value: 2,
                  ),
                  PopupMenuItem(
                    child: Text("Delete"),
                    value: 3,
                  )
                   
                ]
            ),
              ],),

              Container(
                color: Colors.redAccent[100],
                width: MediaQuery.of(context).size.width*0.4,
                height: 400,
                child: Text("mesage"),),

              TextField(
                decoration: InputDecoration(
                  hintText: "type..."
                ),
              ),

              TextButton(onPressed: (){}, child: Text("Send")),

              


            ]),),
            

      ],),
      
    );
  }
}


class UserCard extends StatelessWidget {
  const UserCard({ Key ?key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10),
      height: 50,
      width: MediaQuery.of(context).size.width*0.45,
      color: Colors.redAccent,
      child: Container(
        alignment: Alignment.centerLeft,
        padding: EdgeInsets.only(left: 10),
        child: Text("User"),),
      
    );
  }
}