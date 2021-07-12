

import 'package:flutter/material.dart';


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
                TextButton(onPressed: (){},
                 child:Text("My Network")),
                 TextButton(onPressed: (){},
                 child:Text("Direct"))
            ],
          )
        ],
      ),
      
    );
  }
}


