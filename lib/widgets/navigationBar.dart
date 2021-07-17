

import 'package:dbproject/models/User.dart';
import 'package:flutter/material.dart';

import '../database.dart';

// final dataKey = new GlobalKey();
TextEditingController searchUserController = TextEditingController();

  // var items = ['Working a lot harder', 'Being a lot smarter', 'Being a self-starter', 'Placed in charge of trading charter'];
class NavigationBar extends StatefulWidget {
  const NavigationBar(this.db, this.user) ;
  final AppDatabase db ;
  final user ;
  @override
  _NavigationBarState createState() => _NavigationBarState();
}

class _NavigationBarState extends State<NavigationBar> {
  bool inOtherPage = false ;
  List<String?> items = [] ;
  var loplop = ["mina" , "bahar"] ;
  // var mylist ;
  void searchUser(String text)async{
    var searchtext = "%"+text+"%" ;
    print("get in searchUser function");
    widget.db.userDao.searchByUsername(searchtext).then((value) => setState((){
      items = [];
      print("search started");
      // mylist = value ;
      if (value != null ){
        for (int i = 0 ; i < value.length ; i++){
          if(value[i]?.userName != null){
            items.add(value[i]?.userName);
            print(value[i]?.userName);
          }
          
      }
      }
      
      
    }));

    for(int i = 0 ; i < items.length ; i++){
      items[i] = items[i].toString();
    }


  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      color: Colors.redAccent,
      child: Row(
        
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(left: 10),
            child:Text("LinkedIn",
          style: TextStyle(fontSize: 25 , color: Colors.white) ,),
          
          
          ),
          
          Container(
            width: 600,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[


              //       child: TextField(
              //       controller: searchUserController,
              //       textAlign: TextAlign.left,
              //       decoration: InputDecoration(
              //       hintText: "Search user...",
                    
              //       contentPadding: EdgeInsets.only(left: 10 , top: 9),
              //       hintStyle: TextStyle(color: Colors.redAccent),
              //       suffixIcon: PopupMenuButton(
    
              //         icon: const Icon(Icons.search),
              //           onSelected: (Icon) {
              //             // searchUserController.text = value!;
              //             print("onselceted of pop up menu");
              //             // searchUser(searchUserController.text);
              //           },
                      
              //         itemBuilder: (BuildContext context){
              //             return loplop.map<PopupMenuItem<String?>>((String? value) {
              //               return new PopupMenuItem(child: new Text(value!), value: value);
              //             }).toList();
              //           },)
              // ),
              // ),

                TextButton(onPressed: (){},
                 child:Text("Home")),
                 TextButton(onPressed: (){},
                 child:Text("Notification")),
                 TextButton(onPressed: (){},
                 child:Text("Message")),
                 TextButton(onPressed: (){},
                 child:Text("My Network")),

                 Visibility(
                   visible: true,
                   child: Container(
                    color: Colors.white,
                    height: 30,
                    width: 100,
                    child: ButtonTheme(
                    height: 20,
                    minWidth: MediaQuery.of(context).size.width*0.1,
                    buttonColor: Colors.white,
                    child: RaisedButton(onPressed: (){
          },
           child: Text("Connect" , style: TextStyle(color: Colors.redAccent),)))
              ),)
                 
                 
            ],
          ),)
          
        ],
      ),
      
    );
  }
}





