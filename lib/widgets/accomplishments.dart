import 'package:flutter/material.dart';

import '../database.dart';


import 'package:dbproject/models/Accomplishment.dart';

class AccomplishmentCard extends StatelessWidget {
  const AccomplishmentCard({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(

    );
  }
}

class AccomplishCard extends StatefulWidget {
  const AccomplishCard(this.id , this.text);
  final id ;
  final text ;

  @override
  _AccomplishCardState createState() => _AccomplishCardState();
}

class _AccomplishCardState extends State<AccomplishCard> {
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
            Text(widget.id , style: TextStyle(color: Colors.white),) ,
            Container(
              padding: EdgeInsets.only(left: 5),
              child: Text(widget.text , style: TextStyle(color: Colors.white),),)
            


        ],),
        TextButton(onPressed: (){}, child: Text("Edit")),

      ],)
      )
      
    );
  }
}

// class AcomplishCard extends StatelessWidget {
  

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: EdgeInsets.only(top: 10),
//       height: 50,
//       width: MediaQuery.of(context).size.width*0.88,
//       color: Colors.redAccent,
//       child: Container(margin: EdgeInsets.only(left: 5),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//         Row(children: [
//             Text("1" , style: TextStyle(color: Colors.white),) ,
//             Container(
//               padding: EdgeInsets.only(left: 5),
//               child: Text("project" , style: TextStyle(color: Colors.white),),)
            


//         ],),
//         TextButton(onPressed: (){}, child: Text("Edit")),

//       ],)
//       )
//     );
//   }
// }
 var accomplishment ;
 List<AccomplishCard> list = [];
class AddAccomplish extends StatefulWidget {
  const AddAccomplish(this.db , this.user);
  final AppDatabase db ;
  final int? user  ;  

  @override
  _AddAccomplishState createState() => _AddAccomplishState();
}

class _AddAccomplishState extends State<AddAccomplish> {

    List accomplishmentsText = [] ;
    List accomplishmentsId = [] ;

void addSkillCard(var id , var text){
  
  list.add(new AccomplishCard(id , text));
  setState((){});
}

  void getAccomplish()async{
    var a = widget.user;
    var profileId ;
   

    if (a != null){
      widget.db.userProfileDao.findProfileByUserId(a).then((val) => setState((){
        if (val != null) {
          profileId = val.ProfileId;
          // print("this profileid in test card $profileId");
          // skill = Skill(SkillText: "android" ,profileId: profileId);
          // widget.db.skillDao.insertSkill(skill);q

          widget.db.accomplishmentDao.allAccomplishments(profileId).then((value) => setState((){
             if (value != null){
              for (int i = 0 ; i < value.length ; i++){
                if (value[i] != null){
                  print(value[i]?.AccomplishmentText);
                  print("this is the skillid :");
                  print(value[i]?.AcomplishmentId);
                  addSkillCard(value[i]?.AcomplishmentId , value[i]?.AccomplishmentText );
                  var li = list[i].text;
                  print("$i , $li");
                }
                
              }
             }
          }));
          print(accomplishment);
          }
      }));
    }

     


    
    // print("this my profileid $profileId");
    
  }
  @override
  void initState() {
    getAccomplish();
    super.initState();
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
        TextButton(onPressed: (){}, child: Text("Add")) ,

      ],) ,),
        

      Flexible(child:
       ListView.builder(
        itemCount: list.length,
        itemBuilder: (_,index) { 
          return AccomplishCard(list[index].id.toString(), list[index].text);
          ;}))
      

      ], 
      )
      
      
    );
  }
}
TextEditingController accomplishController = TextEditingController();

class EditAccomplishCard extends StatefulWidget {
  const EditAccomplishCard(this.db , this.user) ;
  final AppDatabase db ;
  final int? user  ; 

  @override
  _EditAccomplishCardState createState() => _EditAccomplishCardState();
}

class _EditAccomplishCardState extends State<EditAccomplishCard> {
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
              NewAccomplish(widget.db , widget.user),
              // EditedCard(widget.db , widget.user),
      ],),),)

      ], 
      )
      
    );
  }
}

// class EditAccomplishCard extends StatelessWidget {
//   const EditAccomplishCard({ Key? key }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//           margin: EdgeInsets.only(top: 20),

//       height: 250,
//       width: MediaQuery.of(context).size.width*0.9,
//       color: Colors.black87,
//       child: 
//       Column(children: [
//         Container(
//           color: Colors.redAccent,
//           child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//         Container(
          
//           margin: EdgeInsets.only(left: 10),
//           child: Text("ADD/EDIT ACCOMPLISHMENT",
//           style: TextStyle(color: Colors.white , fontSize: 15),
//           ),
//         ),
//         TextButton(onPressed: (){}, child: Text("Edit")) ,

//       ],) ,),


      
//       Container(
        
//         child: SingleChildScrollView(child: Column(children: [
//               NewAccomplish(),
//               EditedCard(),
//       ],),),)

//       ], 
//       )

      
//     );
//   }
// }





TextEditingController addAccomplishController = TextEditingController();
class NewAccomplish extends StatefulWidget {
  const NewAccomplish(this.db , this.user);
  final AppDatabase db ;
  final int? user  ; 

  @override
  _NewAccomplishState createState() => _NewAccomplishState();
}


class _NewAccomplishState extends State<NewAccomplish> {
    void addSkillCard(var id , var text){
    list.add(new AccomplishCard(id , text));
    setState((){});
  }

  void addAccomplishToDatabase(String accomplishmentText)async{
    var a = widget.user;
    var profileId ;
    var accomplishment ;

    if (a != null){
      widget.db.userProfileDao.findProfileByUserId(a).then((val) => setState((){
        if (val != null) {
          profileId = val.ProfileId;
          print("this profileid in test card $profileId");
          accomplishment = Accomplishment(AccomplishmentText: accomplishmentText ,profileId: profileId);
          widget.db.accomplishmentDao.insertAccomplishment(accomplishment);
          // widget.db.skillDao.allSkills(profileId).then((value) => setState((){
          //    if (value != null){
          //     for (int i = 0 ; i < value.length ; i++){
          //       if (value[i] != null){
          //         // addSkillCard(id, text)
          //         print(value[i]?.SkillText);
          //         print("this is the skillid :");
          //         print(value[i]?.SkillId);
          //         addSkillCard(value[i]?.SkillId , value[i]?.SkillText );
          //         var li = list[i].text;
          //         print("$i , $li");
          //       }
                
          //     }
          //    }
          // }));
          // print(skill);
          }
      }
      
      ));
      addAccomplishController.text = ''  ;
    }

    
    // print("this my profileid $profileId");


  }
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
            suffixIcon: IconButton(onPressed: () => addAccomplishToDatabase(addAccomplishController.text), icon : Icon(Icons.check)),
            
            ),
            
            
          )
        ),
        

      ],),
      
    );
  }
}



// class NewAccomplish extends StatelessWidget {
//   const NewAccomplish({ Key? key }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//        height: 100,
//       width: MediaQuery.of(context).size.width*0.88,
//       color: Colors.white,
//       margin: EdgeInsets.only(top: 10),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//         Container(
//           color: Colors.white,
//           width: MediaQuery.of(context).size.width*0.86,
//           margin: EdgeInsets.only(left: 10),
//           child: TextField(
//             controller: addAccomplishController,
//             decoration: InputDecoration(
//             hintText: "Accomplishment name",
//             hintStyle: TextStyle(color: Colors.redAccent),
//             suffixIcon: IconButton(onPressed: (){}, icon : Icon(Icons.check)),
            
//             ),
            
            
//           )
//         ),
        

//       ],),
      
//     );
//   }
// }

TextEditingController editNumberAccomplishController = TextEditingController();

TextEditingController editFieldAccomplishController = TextEditingController();

var accopmlishText ;
class EditedCard extends StatefulWidget {
  const EditedCard(this.db , this.user) ;
  final AppDatabase db ;
  final int? user  ;  

  @override
  _EditedCardState createState() => _EditedCardState();
}

class _EditedCardState extends State<EditedCard> {
  void editAccomplishmentINDatabase(var skillText , int id)async{

    var a = widget.user;
    // if (a != null){
    //   print("this is userid:");
    //   print(a);
    //   await widget.db.accomplishmentDao.editAccomplishment(skillText, id) ;
    //   widget.db.accomplishmentDao.(id).then((val) => setState((){
    //     print("we are in editskilldatabase");
    //     // print(val?.SkillId);
    //     if (val != null){
    //       print("skilltext is going to change");
    //       // accopmlishText = val ;
    //       }
    //       else{
    //         print("value is null");
    //       }
    //   }));
    // }
  }
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
            onPressed: () {
              return editAccomplishmentINDatabase(editFieldAccomplishController.value.text.toString(), int.parse(editNumberAccomplishController.value.text));

            },
            icon: Icon(Icons.check),
             ),
              ),
              ),) 

            

      ],)
        

    
      )
      
    );
  }
}
// class EditedCard extends StatelessWidget {
//   const EditedCard({ Key? key }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: EdgeInsets.only(top: 10),
//       height: 50,
//       width: MediaQuery.of(context).size.width*0.88,
//       color: Colors.redAccent,
//       child: Container(margin: EdgeInsets.only(left: 5),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//         Container(
//           width: MediaQuery.of(context).size.width*0.18,
//           child: TextField(
//             controller: editNumberAccomplishController,
//             decoration: InputDecoration(
//             hintText: "Field number",
//             suffixIcon: IconButton(
//             onPressed: () {},
//             icon: Icon(Icons.countertops),
//              ),
//               ),
//               ),) ,
//             Container(
//               width: MediaQuery.of(context).size.width*0.68,
//               child: TextField(
//             controller: editFieldAccomplishController,
//             decoration: InputDecoration(
//             hintText: "Edit field",
//             suffixIcon: IconButton(
//             onPressed: () {},
//             icon: Icon(Icons.check),
//              ),
//               ),
//               ),) 

            

//       ],)
        

    
//       )
      
//     );
//   }
// }


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