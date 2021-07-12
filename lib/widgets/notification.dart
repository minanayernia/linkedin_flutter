import 'package:flutter/material.dart';

class NotificationCard extends StatelessWidget {
  const NotificationCard({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: MediaQuery.of(context).size.width*0.88,
      color: Colors.redAccent,
      margin: EdgeInsets.only(top: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
        Container(
          margin: EdgeInsets.only(left: 10),
          child: Text("data" , 
          style: TextStyle(color: Colors.white , fontSize: 13),
          ),
        ),
        TextButton(onPressed: (){}, child: Text("..."))

      ],),
      
    );
  }
}


class NotifList extends StatelessWidget {
  const NotifList({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 20),
      height: 400,
      width: MediaQuery.of(context).size.width*0.9,
      color: Colors.black87,
      child: SingleChildScrollView(
        child: Column(children: [
          NotificationCard(),
          NotificationCard(),
          NotificationCard(),
          NotificationCard(),
          NotificationCard(),
          NotificationCard(),
        ],),
      ),

      
    );
  }
}