

import 'package:flutter/material.dart';

// final dataKey = new GlobalKey();
TextEditingController searchUserController = TextEditingController();

class NavigationBar extends StatelessWidget {
  const NavigationBar({ Key? key }) : super(key: key);

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
                    suffixIcon: IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.search),
                    
             ),
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



