

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
  List<String?> items = [] ;
  // var loplop = ["mina" , "bahar"] ;
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
  
void m()
{
  final TextEditingController _controller = new TextEditingController();
  // var items = ['Working a lot harder', 'Being a lot smarter', 'Being a self-starter', 'Placed in charge of trading charter'];
  runApp(
    new MaterialApp(
      title: 'Drop List Example',
      home: new Scaffold(
        appBar: new AppBar(title: const Text('Drop List Example')),
        body: new Center(
          child: new Container(
            child: new Column(
              children: [
                new Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: new Row(
                    children: <Widget>[
                      new Expanded(
                        child: new TextField(
                          controller: _controller)
                      ),
                      new PopupMenuButton<String?>(
                        icon: const Icon(Icons.search),
                        onSelected: (String? value) {
                          // _controller.text = value!;
                          searchUser(_controller.text);
                        },
                        itemBuilder: (BuildContext context) {
                          return items.map<PopupMenuItem<String?>>((String? value) {
                            return new PopupMenuItem(child: new Text(value!), value: value);
                          }).toList();
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    ),
  );
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
          
          
          Row(
            children: <Widget>[

              
              Container(
                color: Colors.white,
                    height: 40,
                    width: 400,
                    child: TextField(
                    controller: searchUserController,
                    textAlign: TextAlign.left,
                    decoration: InputDecoration(
                    hintText: "Search user...",
                    
                    contentPadding: EdgeInsets.only(left: 10 , top: 9),
                    hintStyle: TextStyle(color: Colors.redAccent),
                    suffixIcon: PopupMenuButton(
    
                      icon: const Icon(Icons.search),
                        onSelected: (String? value) {
                          searchUserController.text = value!;
                          print("onselceted of pop up menu");
                          searchUser(searchUserController.text);
                        },
                      
                      itemBuilder: (BuildContext context){
                          return items.map<PopupMenuItem<String?>>((String? value) {
                            return new PopupMenuItem(child: new Text(value!), value: value);
                          }).toList();
                        },)
              ),
              ),

          ),
                TextButton(onPressed: (){},
                 child:Text("Home")),
                 TextButton(onPressed: (){},
                 child:Text("Notification")),
                 TextButton(onPressed: (){},
                 child:Text("Message")),
                 TextButton(onPressed: (){},
                 child:Text("My Network")),
                 
            ],
          )
        ],
      ),
      
    );
  }
}





