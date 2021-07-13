import 'package:flutter/material.dart';


class LanguageList extends StatefulWidget {
  const LanguageList({ Key? key }) : super(key: key);

  @override
  _LanguageListState createState() => _LanguageListState();
}

class _LanguageListState extends State<LanguageList> {
         List<AddLanguage> list = [];
addSkillCard(){
  
  list.add(new AddLanguage()
  );
  setState((){});
}
  bool showTextField = false;

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
          child: Text("LANGUAGES",
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
class LanguageCard extends StatelessWidget {
  const LanguageCard({ Key? key }) : super(key: key);

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
        TextButton(onPressed: (){}, child: Text("Delete")),
        TextButton(onPressed: (){}, child: Text("Edit"))
        ],)
        

      ],),
      
    );
  }
}


TextEditingController languageController = TextEditingController();

class EditLanguageCard extends StatelessWidget {
  const EditLanguageCard({ Key? key }) : super(key: key);

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
            controller: languageController,
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


TextEditingController addLanguageController = TextEditingController();
class AddLanguage extends StatelessWidget {
  const AddLanguage({ Key? key }) : super(key: key);

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
            controller: addLanguageController,
            decoration: InputDecoration(
            hintText: "Language name",
            hintStyle: TextStyle(color: Colors.redAccent),
            suffixIcon: IconButton(onPressed: (){}, icon : Icon(Icons.check)),
            
            ),
            
            
          )
        ),
        

      ],),
      
    );
  }
}

class OtherLanguage extends StatelessWidget {
  const OtherLanguage({ Key? key }) : super(key: key);

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
          child: Text("LANGUAGES",
          style: TextStyle(color: Colors.white , fontSize: 15),
          ),
        ),

      ],) ,),
      OtherLanguageCard(),

      /*Flexible(child: ListView.builder(
        itemCount: list.length,
        itemBuilder: (_,index) => list[index]))*/
      

      ], 
      )

      
    );
  }
}

class OtherLanguageCard extends StatelessWidget {
  const OtherLanguageCard({ Key? key }) : super(key: key);

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
        

      ],),
      
    );
  }
}