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
        Row(children: [
            Text("1" , style: TextStyle(color: Colors.white),) ,
            Container(
              padding: EdgeInsets.only(left: 5),
              child: Text("project" , style: TextStyle(color: Colors.white),),)
            


        ],),
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
       List<AcomplishCard> list = [];
addSkillCard(){
  
  list.add(new AcomplishCard()
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
          margin: EdgeInsets.only(top: 20),

      height: 250,
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
          child: Text("ADD/EDIT ACCOMPLISHMENT",
          style: TextStyle(color: Colors.white , fontSize: 15),
          ),
        ),
        TextButton(onPressed: (){}, child: Text("Edit")) ,

      ],) ,),


      
      Container(
        
        child: SingleChildScrollView(child: Column(children: [
              NewAccomplish(),
              EditedCard(),
      ],),),)

      ], 
      )

      
    );
  }
}


TextEditingController addAccomplishController = TextEditingController();

class NewAccomplish extends StatelessWidget {
  const NewAccomplish({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
       height: 100,
      width: MediaQuery.of(context).size.width*0.88,
      color: Colors.white,
      margin: EdgeInsets.only(top: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
        Container(
          color: Colors.white,
          width: MediaQuery.of(context).size.width*0.86,
          margin: EdgeInsets.only(left: 10),
          child: TextField(
            controller: addAccomplishController,
            decoration: InputDecoration(
            hintText: "Accomplishment name",
            hintStyle: TextStyle(color: Colors.redAccent),
            suffixIcon: IconButton(onPressed: (){}, icon : Icon(Icons.check)),
            
            ),
            
            
          )
        ),
        

      ],),
      
    );
  }
}

TextEditingController editNumberAccomplishController = TextEditingController();

TextEditingController editFieldAccomplishController = TextEditingController();

class EditedCard extends StatelessWidget {
  const EditedCard({ Key? key }) : super(key: key);

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
        Container(
          width: MediaQuery.of(context).size.width*0.18,
          child: TextField(
            controller: editNumberAccomplishController,
            decoration: InputDecoration(
            hintText: "Field number",
            suffixIcon: IconButton(
            onPressed: () {},
            icon: Icon(Icons.countertops),
             ),
              ),
              ),) ,
            Container(
              width: MediaQuery.of(context).size.width*0.68,
              child: TextField(
            controller: editFieldAccomplishController,
            decoration: InputDecoration(
            hintText: "Edit field",
            suffixIcon: IconButton(
            onPressed: () {},
            icon: Icon(Icons.check),
             ),
              ),
              ),) 

            

      ],)
        

    
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