import 'package:dbproject/database.dart';
import 'package:dbproject/models/Message.dart';
import 'package:flutter/material.dart';
// final dataKey = new GlobalKey();

TextEditingController sendMessageController = TextEditingController();
TextEditingController searchMessageController = TextEditingController();


class Message extends StatefulWidget {
  const Message(this.db, this.myid);
  final AppDatabase db;
  final myid;
  @override
  _MessageState createState() => _MessageState();
}
String recieverr = '';
List<String> msg = [];
List<String> names = [];

class pm extends StatelessWidget {
  const pm(this.name , this.msg);
  final name ;
  final msg ;
  @override
  Widget build(BuildContext context) {
    return Container( 
      color: Colors.white12,
      margin: EdgeInsets.only(top:10),
      height: 60,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                        Container(
                          padding: EdgeInsets.only(left:10),
                          child: Text(name + " :" , style: TextStyle(color: Colors.white),),),
                        Container(
                          padding: EdgeInsets.only(left:10),
                          child: Text(msg , style: TextStyle(color: Colors.white),) ,)
                      ],),
                      
                    );
  }
}

List<pm> msgs=[];
class _MessageState extends State<Message> {

void addmsg(var text , var name){
  msgs.add(new pm(name, text));
  setState(() {
    
  });
}
void conversation(int myid , String othername )async{
  msgs.clear();
  print("we are in conversation!!!");
  widget.db.userDao.findeUserByUserName(othername).then((v) => setState((){

    if (v != null){
      print("value of findeUserByUserName found");

      var otherid = v.userId;
      print(otherid);
      widget.db.messageeDao.showMessage(myid, otherid!).then((value) => setState((){
    if(value != null){
      print("value of show message is not null");
      msg.clear();
      for(int i =0 ; i < value.length ; i++){
        if (value[i] != null){
          var t1 = value[i]?.messageText ;
          var id  = value[i]?.senderId;
          
          // msg[i] = value[i]?.messageText;
          // print(msg[i]);
          
        widget.db.userDao.findUserNameByUserId(id!).then((val) => setState((){
          if(val != null){
            var name = val.userName ; 
            addmsg(t1, name);
            print("at the end!!!!!!!!!!!!!!!!!!!");
            // print(names[i]);
          }
        }));
        }
        
      }
    }
  }));
    }    
  }));

  
  }
  

  List<UserCard> list = [];
  void addSearchCard(
    var db,
    String? username,
    int? id,
  ) {
    list.add(new UserCard(
      db,
      username,
      id,
    ));
    setState(() {});
  }

  var items;
  void searchUser(String text) async {
    items = [];
    list = [] ;
    var searchtext = "%" + text + "%";
    print("get in searchUser function");
    widget.db.userDao.searchByUsername(searchtext).then((value) => setState(() {
          items = [];
          print("search started");
          // mylist = value ;
          if (value != null) {
            for (int i = 0; i < value.length; i++) {
              if (value[i]?.userName != null) {
                // items.add(value[i]?.userName);
                addSearchCard(widget.db, value[i]?.userName, value[i]?.userId);
                print(value[i]?.userName);
              }
            }
          }
        }));
    for (int i = 0; i < items.length; i++) {
      items[i] = items[i].toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 20),
      height: 600,
      width: MediaQuery.of(context).size.width * 0.9,
      color: Colors.black87,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Container(
            width: MediaQuery.of(context).size.width * 0.45,
            child: Column(children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    // key: dataKey,
                    padding: EdgeInsets.only(left: 10),
                    child: Text(
                      "Conversation",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  // TextButton(onPressed: () {}, child: Text("New Message")),
                ],
              ),
              TextField(
                style: TextStyle(color: Colors.white),
                controller: searchMessageController,
                decoration: InputDecoration(
                  fillColor: Colors.white,
                  hintStyle: TextStyle(color: Colors.white),
                  hintText: "Search user" ,suffixIcon: IconButton(
                    onPressed: () {
                      searchUser(searchMessageController.text);
                    },
                    icon: Icon(
                      Icons.search,
                      color: Colors.white,
                    ),
                  ),),
              ),
              Container(
                height: 500,
                child: ListView.builder(
                    itemCount: list.length,
                    itemBuilder: (_, index) => UserCard(
                        widget.db, list[index].username, list[index].id)),
              ),
            ]),
          ),
          Container(
            color: Colors.white,
            width: MediaQuery.of(context).size.width * 0.45,
            child: Column(children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: EdgeInsets.only(left: 10),
                    child: Text(
                      "User",
                      style: TextStyle(color: Colors.redAccent),
                    ),
                  ),
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
                          ]),
                ],
              ),
              Container(
                color: Colors.redAccent[100],
                width: MediaQuery.of(context).size.width * 0.4,
                height: 400,
                child:  ListView.builder(
                    itemCount: msgs.length,
                    itemBuilder: (_, index) => pm(msgs[index].name, msgs[index].msg))),
              TextField(
                style: TextStyle(color: Colors.redAccent),
                controller: sendMessageController,
                decoration: InputDecoration(
                  fillColor: Colors.redAccent,
                  hintStyle: TextStyle(color: Colors.redAccent),
                  hintText: "type..."),
              ),
              TextButton(onPressed: () {
                return conversation(widget.myid, sendMessageController.text);
              }, child: Text("Send")),
            ]),
          ),
        ],
      ),
    );
  }
}
// class Message extends StatelessWidget {
//   const Message({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: EdgeInsets.only(top: 20),
//       height: 600,
//       width: MediaQuery.of(context).size.width * 0.9,
//       color: Colors.black87,
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceAround,
//         children: [
//           Container(
//             width: MediaQuery.of(context).size.width * 0.45,
//             child: Column(children: [
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Container(
//                     // key: dataKey,
//                     padding: EdgeInsets.only(left: 10),
//                     child: Text(
//                       "Conversation",
//                       style: TextStyle(color: Colors.white),
//                     ),
//                   ),
//                   // TextButton(onPressed: () {}, child: Text("New Message")),
//                 ],
//               ),
//               TextField(
//                 controller: searchMessageController,
//                 decoration: InputDecoration(hintText: "Search messages"),
//               ),
//               Container(
//                 height: 500,
//                 child: SingleChildScrollView(
//                   child: Column(
//                     children: [
//                       // UserCard(),
//                       // UserCard(),
//                       // UserCard(),

//                       // UserCard(),
//                       // UserCard(),
//                       // UserCard(),
//                       //  UserCard(),
//                       // UserCard(),

//                       // UserCard(),
//                       // UserCard(),
//                       //  UserCard(),
//                       // UserCard(),

//                       // UserCard(),
//                       // UserCard(),
//                     ],
//                   ),
//                 ),
//               ),
//             ]),
//           ),
//           Container(
//             color: Colors.white,
//             width: MediaQuery.of(context).size.width * 0.45,
//             child: Column(children: [
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Container(
//                     padding: EdgeInsets.only(left: 10),
//                     child: Text(
//                       "User",
//                       style: TextStyle(color: Colors.redAccent),
//                     ),
//                   ),
//                   PopupMenuButton(
//                       icon: Icon(Icons.more_horiz),
//                       itemBuilder: (context) => [
//                             PopupMenuItem(
//                               child: Text("Archieve"),
//                               value: 1,
//                             ),
//                             PopupMenuItem(
//                               child: Text("Mark unread"),
//                               value: 2,
//                             ),
//                             PopupMenuItem(
//                               child: Text("Delete"),
//                               value: 3,
//                             )
//                           ]),
//                 ],
//               ),
//               Container(
//                 color: Colors.redAccent[100],
//                 width: MediaQuery.of(context).size.width * 0.4,
//                 height: 400,
//                 child: Text("mesage"),
//               ),
//               TextField(
//                 controller: sendMessageController,
//                 decoration: InputDecoration(hintText: "type..."),
//               ),
//               TextButton(onPressed: () {}, child: Text("Send")),
//             ]),
//           ),
//         ],
//       ),
//     );
//   }
// }

class UserCard extends StatelessWidget {
  const UserCard(this.db, this.username, this.id);
  final AppDatabase db;
  final username;
  final id;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        // recieverr = username ;
      },
      child: Container(
        margin: EdgeInsets.only(top: 10),
        height: 50,
        width: MediaQuery.of(context).size.width * 0.45,
        color: Colors.redAccent,
        child: Container(
          alignment: Alignment.centerLeft,
          padding: EdgeInsets.only(left: 10),
          child: Text(username),
        ),
      ),
    );
  }
}

TextEditingController newMessageController = TextEditingController();
TextEditingController searchNewMessageController = TextEditingController();
TextEditingController searchUserController = TextEditingController();

class NewMessage extends StatefulWidget {
  const NewMessage(this.db, this.myid);
  final AppDatabase db;
  final myid;
  @override
  _NewMessageState createState() => _NewMessageState();
}

class _NewMessageState extends State<NewMessage> {
  String reciever = '';
  List<UserCard> list = [];
  void addSearchCard(
    var db,
    String? username,
    int? id,
  ) {
    list.add(new UserCard(
      db,
      username,
      id,
    ));
    setState(() {});
  }

  var items;
  void searchUser(String text) async {
    items = [];
    list = [] ;
    var searchtext = "%" + text + "%";
    print("get in searchUser function");
    widget.db.userDao.searchByUsername(searchtext).then((value) => setState(() {
          items = [];
          print("search started");
          // mylist = value ;
          if (value != null) {
            for (int i = 0; i < value.length; i++) {
              if (value[i]?.userName != null) {
                // items.add(value[i]?.userName);
                addSearchCard(widget.db, value[i]?.userName, value[i]?.userId);
                print(value[i]?.userName);
              }
            }
          }
        }));
    for (int i = 0; i < items.length; i++) {
      items[i] = items[i].toString();
    }
  }

  void sendMessage(String username, String msg) async {
    var id;

    widget.db.userDao
        .findeUserByUserName(username)
        .then((value) => setState(() {
              if (value != null) {
                id = value.userId;
                if (id != widget.myid) {
                  var masg = Messagee(recieverId: id, senderId: widget.myid , messageText: msg);
                  widget.db.messageeDao.insertMessage(masg);
                  print("message sent!");
                } else {
                  print("you cant send message to yourself ");
                }
              }
            }));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 20),
      height: 600,
      width: MediaQuery.of(context).size.width * 0.9,
      color: Colors.black87,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Container(
            width: MediaQuery.of(context).size.width * 0.45,
            child: Column(children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    // key: dataKey,
                    padding: EdgeInsets.only(left: 10),
                    child: Text(
                      "Messaging",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  Container(
                    color: Colors.redAccent,
                    child: TextButton(
                        onPressed: () {},
                        child: Text(
                          "New Message",
                          style: TextStyle(color: Colors.white),
                        )),
                  )
                ],
              ),
              TextField(
                style: TextStyle(color: Colors.white),
                controller: searchNewMessageController,
                decoration: InputDecoration(
                  hintText: "Search user",
                  fillColor: Colors.white,
                  contentPadding: EdgeInsets.only(left: 10, top: 15),
                  hintStyle: TextStyle(color: Colors.white),
                  suffixIcon: IconButton(
                    onPressed: () {
                      searchUser(searchNewMessageController.text);
                    },
                    icon: Icon(
                      Icons.search,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              Container(
                height: 500,
                child: ListView.builder(
                    itemCount: list.length,
                    itemBuilder: (_, index) => UserCard(
                        widget.db, list[index].username, list[index].id)),
              ),
            ]),
          ),
          Container(
            color: Colors.white,
            width: MediaQuery.of(context).size.width * 0.45,
            child: Column(children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: EdgeInsets.only(left: 10),
                    child: Text(
                      "New message",
                      style: TextStyle(color: Colors.redAccent),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
              Container(
                color: Colors.white,
                height: 30,
                width: 400,
                child: TextField(
                  style: TextStyle(color: Colors.redAccent),
                  controller: searchUserController,
                  textAlign: TextAlign.left,
                  decoration: InputDecoration(
                    hintText: "Type a name...",
                    fillColor: Colors.redAccent,
                    contentPadding: EdgeInsets.only(left: 10),
                    hintStyle: TextStyle(color: Colors.redAccent),
                    //         suffixIcon: IconButton(
                    //         onPressed: () {},
                    //         icon: Icon(Icons.search),

                    //  ),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 400),
                child: TextField(
                  style: TextStyle(color: Colors.redAccent),
                  controller: newMessageController,
                  decoration: InputDecoration(
                      fillColor: Colors.redAccent,
                      hintText: "Write a message...",
                      hintStyle: TextStyle(color: Colors.redAccent)),
                ),
              ),
              ButtonTheme(
                  height: 40,
                  minWidth: MediaQuery.of(context).size.width * 0.55,
                  buttonColor: Colors.redAccent,
                  child: RaisedButton(
                      onPressed: () {
                        return sendMessage(searchUserController.text,
                            newMessageController.text);
                      },
                      child: Text(
                        "Send",
                        style: TextStyle(color: Colors.white),
                      )))
            ]),
          ),
        ],
      ),
    );
  }
}
// class NewMessage extends StatelessWidget {
//   const NewMessage(this.db);
//   final AppDatabase db ;

//   @override
//   Widget build(BuildContext context) {
//     return Container(

//       margin: EdgeInsets.only(top: 20),
//       height: 600,
//       width: MediaQuery.of(context).size.width*0.9,
//       color: Colors.black87,
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceAround,
//         children: [
            
//         Container(
//          width: MediaQuery.of(context).size.width*0.45,

//           child: Column(children: [
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                 Container(
//                   // key: dataKey,
//                   padding: EdgeInsets.only(left: 10),
//                   child:Text("Messaging" , style: TextStyle(color: Colors.white),)  ,),

//                 Container(
//                   color: Colors.redAccent,
//                   child: TextButton(onPressed: (){}, child: Text("New Message" , style: TextStyle(color: Colors.white),)),)
                
//               ],),

//               TextField(
//                 controller: searchNewMessageController,
//                 decoration: InputDecoration(
//                   hintText: "Search User",
                  
//                   contentPadding: EdgeInsets.only(left: 10 , top: 15),
//                   hintStyle: TextStyle(color: Colors.white),
//                   suffixIcon: IconButton(
//                     onPressed: () {},
//                     icon: Icon(Icons.search , color: Colors.white,),
                    
                    
//              ),
//                 ),
//               ),


//               Container(
//                 height: 500,
//                 child:
//                SingleChildScrollView(
//                 child: Column(children: [

//                   UserCard(),
//                   UserCard(),
//                   UserCard(),
          
//                   UserCard(),
//                   UserCard(),
//                   UserCard(),
//                    UserCard(),
//                   UserCard(),
//                 ],),
//               ) ,) ,
              


//             ]),),

//             Container(
//             color: Colors.white,

//           width: MediaQuery.of(context).size.width*0.45,

//           child: Column(children: [
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                 Container(
                  
//                   padding: EdgeInsets.only(left: 10),
//                   child:Text("New message" , style: TextStyle(color: Colors.redAccent),textAlign: TextAlign.center,)  ,),
                
                
//               ],),

//               Container(
//                 color: Colors.white,
//                     height: 30,
//                     width: 400,
//                     child: TextField(
//                     controller: searchUserController,
//                     textAlign: TextAlign.left,
//                     decoration: InputDecoration(
//                     hintText: "Type a name...",
                    
//                     contentPadding: EdgeInsets.only(left: 10),
//                     hintStyle: TextStyle(color: Colors.redAccent),
//                     suffixIcon: IconButton(
//                     onPressed: () {},
//                     icon: Icon(Icons.search),
                    
//              ),
//               ),
//               ),),
//               Container(
//                 margin: EdgeInsets.only(top: 400),
//                 child:TextField(
//                   controller: newMessageController,
//                 decoration: InputDecoration(
//                   hintText: "Write a message...",
//                   hintStyle: TextStyle(color: Colors.redAccent)
//                 ),
//               ) 
//               ,),
              

//               ButtonTheme(
//           height: 40,
//           minWidth: MediaQuery.of(context).size.width*0.55,
//           buttonColor: Colors.redAccent,
//           child: RaisedButton(onPressed: (){}
//           ,
//            child: Text("Send" , style: TextStyle(color: Colors.white),))
//            )

              


//             ]),),
            

//       ],),

      
//     );
//   }
// }