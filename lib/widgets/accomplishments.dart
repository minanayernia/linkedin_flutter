import 'package:flutter/material.dart';

class AccomplishmentCard extends StatelessWidget {
  const AccomplishmentCard({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(

    );
  }
}


class AcomplishCard extends StatelessWidget {
  const AcomplishCard({ Key ?key }) : super(key: key);

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
        Text("project" , style: TextStyle(color: Colors.white),) ,
        TextButton(onPressed: (){}, child: Text("Edit")),

      ],)
      )
    );
  }
}


class AddAccomplish extends StatefulWidget {
  const AddAccomplish({ Key? key }) : super(key: key);

  @override
  _AddAccomplishState createState() => _AddAccomplishState();
}

class _AddAccomplishState extends State<AddAccomplish> {
       List<EditAccomplishCard> list = [];
addSkillCard(){
  
  list.add(new EditAccomplishCard()
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
          
          margin: EdgeInsets.only(left: 10),
          child: Text("ACCOMPLISHMENTS",
          style: TextStyle(color: Colors.white , fontSize: 15),
          ),
        ),
        TextButton(onPressed: addSkillCard, child: Text("Add")) ,

      ],) ,),
        

      Flexible(child: ListView.builder(
        itemCount: list.length,
        itemBuilder: (_,index) => list[index]))
      

      ], 
      )
      
      
    );
  }
}
TextEditingController accomplishController = TextEditingController();

class EditAccomplishCard extends StatelessWidget {
  const EditAccomplishCard({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10),
      height: 50,
      width: MediaQuery.of(context).size.width*0.88,
      color: Colors.redAccent,
      child: Container(margin: EdgeInsets.only(left: 5),
      child: 
        TextField(
            controller: accomplishController,
            decoration: InputDecoration(
            hintText: "Edit field",
            suffixIcon: IconButton(
            onPressed: () {},
            icon: Icon(Icons.check),
             ),
              ),
              ),

    
      )

      
    );
  }
}


class OtherAccomplish extends StatelessWidget {
  const OtherAccomplish({ Key? key }) : super(key: key);

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
          child: Text("ACCOMPLISHMENTS",
          style: TextStyle(color: Colors.white , fontSize: 15),
          ),
        ),

      ],) ,),
        

      /*Flexible(child: ListView.builder(
        itemCount: list.length,
        itemBuilder: (_,index) => list[index]))*/
      OtherAccomplishCard() ,

      ], 
      )

      
    );
  }
}

class OtherAccomplishCard extends StatelessWidget {
  const OtherAccomplishCard({ Key? key }) : super(key: key);

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
        Text("project" , style: TextStyle(color: Colors.white),) ,
      ],)
      )
      
    );
  }
}