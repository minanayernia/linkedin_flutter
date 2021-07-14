import 'package:flutter/material.dart';

class AboutCard extends StatelessWidget {
  const AboutCard({ Key ?key }) : super(key: key);

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


class AdditionalInfoList extends StatefulWidget {
  const AdditionalInfoList({ Key? key }) : super(key: key);

  @override
  _AdditionalInfoListState createState() => _AdditionalInfoListState();
}

class _AdditionalInfoListState extends State<AdditionalInfoList> {
List<AboutCard> list = [];
addSkillCard(){
  
  list.add(new AboutCard()
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
          child: Text("ADDITIONALINFO",
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


TextEditingController infoController = TextEditingController();
class EditInfoCard extends StatelessWidget {
  const EditInfoCard({ Key? key }) : super(key: key);

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
          child: Text("ADD/EDIT ADDITIONALINFO",
          style: TextStyle(color: Colors.white , fontSize: 15),
          ),
        ),
        TextButton(onPressed: (){}, child: Text("Edit")) ,

      ],) ,),


      
      Container(
        
        child: SingleChildScrollView(child: Column(children: [
              NewInfo(),
              EditedCard(),
      ],),),)

      ], 
      )
      
    );
  }
}
TextEditingController addInfoController = TextEditingController();

class NewInfo extends StatelessWidget {
  const NewInfo({ Key? key }) : super(key: key);

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
            controller: addInfoController,
            decoration: InputDecoration(
            hintText: "AdditionalInfo name",
            hintStyle: TextStyle(color: Colors.redAccent),
            suffixIcon: IconButton(onPressed: (){}, icon : Icon(Icons.check)),
            
            ),
            
            
          )
        ),
        

      ],),
      
    );
  }
}

TextEditingController editNumberInfoController = TextEditingController();
TextEditingController editFieldInfoController = TextEditingController();

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
            controller: editNumberInfoController,
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
            controller: editFieldInfoController,
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


class OtherAdditionalInfo extends StatelessWidget {
  const OtherAdditionalInfo({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 20),
      color: Colors.black87,
      height: 100,
      width: MediaQuery.of(context).size.width * 0.9,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
        
        Container(
          color: Colors.redAccent,
          child: Row(children: [
            Container(
          margin: EdgeInsets.only(left: 10),
          child:  Text("ADDITIONALINFO",
          style: TextStyle(color: Colors.white , fontSize: 15),
          ),

        ),
        
        ],),),
        
        Container(
          margin: EdgeInsets.only(left: 10 , top: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
            Text("data" , 
            style: TextStyle(color: Colors.white , fontSize: 13),
            ) ,

          ],),
        )
      ],)
      
    );
  }
}