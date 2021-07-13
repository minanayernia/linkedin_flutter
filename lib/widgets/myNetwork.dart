import 'package:flutter/material.dart';



class InvitationList extends StatefulWidget {
  const InvitationList({ Key? key }) : super(key: key);

  @override
  _InvitationListState createState() => _InvitationListState();
}

class _InvitationListState extends State<InvitationList> {
           List<InvitationCard> list = [];
addSkillCard(){
  
  list.add(new InvitationCard()
  );
  setState((){});
}
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 20),

      height: 200,
      width: MediaQuery.of(context).size.width*0.9,
      color: Colors.black87,
      child: 
      Column(children: [
        Container(
          color: Colors.redAccent,
          child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
        Container(
          height: 30,
          margin: EdgeInsets.only(left: 10 , top: 7),
          child: Text("INVITATIONS",
          style: TextStyle(color: Colors.white , fontSize: 15),
          ),
        ),

      ],) ,),
        

      Flexible(child: ListView.builder(
        itemCount: list.length,
        itemBuilder: (_,index) => list[index])),
      
      InvitationCard(),
      ], 
      )
      
    );
  }
}



class InvitationCard extends StatelessWidget {
  const InvitationCard({ Key? key }) : super(key: key);

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
        Row(children: [
        TextButton(onPressed: (){}, child: Text("Accept")),
        TextButton(onPressed: (){}, child: Text("Ignore"))
        ],)
        

      ],),
    );
  }
}



class PeopleYouMayKnowList extends StatefulWidget {
  const PeopleYouMayKnowList({ Key? key }) : super(key: key);

  @override
  _PeopleYouMayKnowListState createState() => _PeopleYouMayKnowListState();
}

class _PeopleYouMayKnowListState extends State<PeopleYouMayKnowList> {
List<InvitationCard> list = [];
addSkillCard(){
  
  list.add(new InvitationCard()
  );
  setState((){});
}
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 20),

      height: 200,
      width: MediaQuery.of(context).size.width*0.9,
      color: Colors.black87,
      child: 
      Column(children: [
        Container(
          color: Colors.redAccent,
          child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
        Container(
          height: 30,
          margin: EdgeInsets.only(left: 10 , top: 7),
          child: Text("PEOPLE YOU MAY KNOW",
          style: TextStyle(color: Colors.white , fontSize: 15),
          ),
        ),

      ],) ,),
        

      Flexible(child: ListView.builder(
        itemCount: list.length,
        itemBuilder: (_,index) => list[index])),
      
      PeopleCard(),

      ], 
      
      )
      
    );
  }
}

class PeopleCard extends StatelessWidget {
  const PeopleCard({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10),
      height: 50,
      width: MediaQuery.of(context).size.width*0.88,
      color: Colors.redAccent,
      child: Container(margin: EdgeInsets.only(left: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
        Text("User Name" , style: TextStyle(color: Colors.white),) ,
        TextButton(onPressed: (){}, child: Text("Connect")),

      ],)
      )
      
    );
  }
}