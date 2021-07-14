import 'package:flutter/material.dart';
// final dataKey = new GlobalKey();

TextEditingController sendMessageController = TextEditingController();
TextEditingController searchMessageController = TextEditingController();

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
                controller: searchMessageController,
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
                controller: sendMessageController,
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

TextEditingController newMessageController = TextEditingController();
TextEditingController searchNewMessageController = TextEditingController();
TextEditingController searchUserController = TextEditingController();
class NewMessage extends StatelessWidget {
  const NewMessage({ Key? key }) : super(key: key);

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

                Container(
                  color: Colors.redAccent,
                  child: TextButton(onPressed: (){}, child: Text("New Message" , style: TextStyle(color: Colors.white),)),)
                
              ],),

              TextField(
                controller: searchNewMessageController,
                decoration: InputDecoration(
                  hintText: "Search messages",
                  
                  contentPadding: EdgeInsets.only(left: 10 , top: 15),
                  hintStyle: TextStyle(color: Colors.redAccent),
                  suffixIcon: IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.search),
                    
                    
             ),
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
                  child:Text("New message" , style: TextStyle(color: Colors.redAccent),textAlign: TextAlign.center,)  ,),
                
                
              ],),

              Container(
                color: Colors.white,
                    height: 30,
                    width: 400,
                    child: TextField(
                    controller: searchUserController,
                    textAlign: TextAlign.left,
                    decoration: InputDecoration(
                    hintText: "Type a name...",
                    
                    contentPadding: EdgeInsets.only(left: 10),
                    hintStyle: TextStyle(color: Colors.redAccent),
                    suffixIcon: IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.search),
                    
             ),
              ),
              ),),
              Container(
                margin: EdgeInsets.only(top: 400),
                child:TextField(
                  controller: newMessageController,
                decoration: InputDecoration(
                  hintText: "Write a message...",
                  hintStyle: TextStyle(color: Colors.redAccent)
                ),
              ) 
              ,),
              

              ButtonTheme(
          height: 40,
          minWidth: MediaQuery.of(context).size.width*0.55,
          buttonColor: Colors.redAccent,
          child: RaisedButton(onPressed: (){}
          ,
           child: Text("Send" , style: TextStyle(color: Colors.white),))
           )

              


            ]),),
            

      ],),

      
    );
  }
}