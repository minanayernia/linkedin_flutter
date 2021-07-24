import 'package:flutter/material.dart';

import '../database.dart';


import 'package:dbproject/models/Accomplishment.dart';

// class AccomplishmentCard extends StatelessWidget {
//   const AccomplishmentCard({ Key? key }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Container(

//     );
//   }
// }

class AccomplishCard extends StatefulWidget {
  const AccomplishCard(this.id , this.text , this.db);
  final id ;
  final text ;
  final AppDatabase db ;

  @override
  _AccomplishCardState createState() => _AccomplishCardState();
}

class _AccomplishCardState extends State<AccomplishCard> {

  void deleteAccomplishment()async{
    widget.db.accomplishmentDao.deleteAccomplishmentById(int.parse(widget.id));
    print("accomplishment deleted seccessfully");
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
        Row(children: [
            Text(widget.id , style: TextStyle(color: Colors.white),) ,
            Container(
              padding: EdgeInsets.only(left: 5),
              child: Text(widget.text , style: TextStyle(color: Colors.white),),)
            


        ],),
        TextButton(onPressed: (){
          return deleteAccomplishment();
        }, child: Text("delete")),

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
 bool checkAccomplishField = false ;
    bool checkCopy = false ;
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
  
  if(text != "" && checkCopy == false){
  list.add(new AccomplishCard(id , text , widget.db));
  setState((){});
  }
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
          return AccomplishCard(list[index].id.toString(), list[index].text , widget.db);
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
              EditedCard(widget.db , widget.user),
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
    if(text != ""){
    list.add(new AccomplishCard(id , text , widget.db));
    setState((){});
    }
  }

  void addAccomplishToDatabase(String accomplishmentText)async{




    // final checkCopyField = await widget.db.accomplishmentDao.findAccomplishmentByText(accomplishmentText);
    var a = widget.user;
    // var profileId ;
    // var accomplishment ;

    if (a != null){
      widget.db.userProfileDao.findProfileByUserId(a).then((value) => setState((){
        print("eeeeeeeeeeeeeeeeeeeeeeeeeeeeeee");
      if(value != null){
        var checkCopyField ;
          widget.db.accomplishmentDao.findAccomplishmentByText(accomplishmentText , value.ProfileId!).then((v) => setState((){
            if (v != null ){
             print("find skill by name is not null");
             checkCopyField = v ;
             checkCopy = true ;

          }else{
        print("find skill by name is null");
        checkCopyField = null ;
        checkCopy = false ;
        if(accomplishmentText != "" && checkCopyField == null){
          var profileId ;
           var accmplishment ;
            widget.db.userProfileDao.findProfileByUserId(a).then((val) => setState((){
            if (val != null) {
            profileId = val.ProfileId;
          print("this profileid in test card $profileId");
          accmplishment = Accomplishment(AccomplishmentText: accomplishmentText ,profileId: profileId);
          widget.db.accomplishmentDao.insertAccomplishment(accmplishment);
          }
      }
      
      ));
      addAccomplishController.text = ''  ;
    }
      }
    }));
        
        // print("profid : $profid");
      }
      else{
        print("null in find userprofile");
      }
    }));
    }

    //     setState(() {
    //   if(checkCopyField != null){
    //     checkCopy = true ;
    //   }
    //   if(checkCopyField == null){
    //     checkCopy = false ;
    //   }
    // });

    setState(() {
    if(accomplishmentText == ""){
      checkAccomplishField = true ;
    }
    if(accomplishmentText != ""){
      checkAccomplishField = false ;
    }


    });
    // if(accomplishmentText != "" && checkCopyField == null){
    // if (a != null){
    //   widget.db.userProfileDao.findProfileByUserId(a).then((val) => setState((){
    //     if (val != null) {
    //       profileId = val.ProfileId;
    //       print("this profileid in test card $profileId");
    //       accomplishment = Accomplishment(AccomplishmentText: accomplishmentText ,profileId: profileId);
    //       widget.db.accomplishmentDao.insertAccomplishment(accomplishment);
    //       // widget.db.skillDao.allSkills(profileId).then((value) => setState((){
    //       //    if (value != null){
    //       //     for (int i = 0 ; i < value.length ; i++){
    //       //       if (value[i] != null){
    //       //         // addSkillCard(id, text)
    //       //         print(value[i]?.SkillText);
    //       //         print("this is the skillid :");
    //       //         print(value[i]?.SkillId);
    //       //         addSkillCard(value[i]?.SkillId , value[i]?.SkillText );
    //       //         var li = list[i].text;
    //       //         print("$i , $li");
    //       //       }
                
    //       //     }
    //       //    }
    //       // }));
    //       // print(skill);
    //       }
    //   }
      
    //   ));
    //   addAccomplishController.text = ''  ;
    // }
    // }

    
    // print("this my profileid $profileId");


  }
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: MediaQuery.of(context).size.width*0.88,
      color: Colors.white,
      margin: EdgeInsets.only(top: 10),
      child: Column(
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
        
              Container(
          alignment: Alignment.center,
          child: Visibility(
          visible: checkAccomplishField,
          child: Container(child: Text("Field name can't be empty" , style: TextStyle(color: Colors.redAccent),),),),),

          Container(
          alignment: Alignment.center,
          child: Visibility(
          visible: checkCopy,
          child: Container(child: Text("This field already exists" , style: TextStyle(color: Colors.redAccent),),),),),
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
  bool checkEditFieldName = false ;
  bool checkEditFieldNumber = false ;
  void editAccomplishmentINDatabase(var skillText , String idNumber)async{

    setState(() {
      if(idNumber == ""){
        checkEditFieldNumber = true ;
      }
      if(idNumber != ""){
        checkEditFieldNumber = false ;
      }
    });
    
    if(idNumber != ""){
    int id = int.parse(editNumberAccomplishController.value.text);
    var a = widget.user; 
    if(a != null){
      widget.db.userProfileDao.findProfileByUserId(a).then((value) => setState((){
        print("eeeeeeeeeeeeeeeeeeeeeeeeeeeeeee");
      if(value != null){
        var checkFieldNumber ;
          widget.db.accomplishmentDao.findAccomplishmentById(id , value.ProfileId!).then((v) => setState((){
            if (v != null ){
             print("find skill by name is not null");
             checkFieldNumber = v ;
             checkEditFieldNumber = false ;
             if(skillText != "" && checkFieldNumber != null){
          print("this is userid:");
      print(a);
      widget.db.accomplishmentDao.editAccomplishment(skillText, id) ;
      widget.db.accomplishmentDao.findAccomplishmentById(id , value.ProfileId!).then((val) => setState((){
        print("we are in editskilldatabase");
        print(val?.AcomplishmentId);
        if (val != null){
          print("skilltext is going to change");
          skillText = val.AccomplishmentText ;
          }
          else{
            print("value is null");
          }
      }));
    }

          }else{
        print("find skill by name is null");
        checkFieldNumber = null ;
        checkEditFieldNumber = true ;

      }
    }));
        
        // print("profid : $profid");
      }
      else{
        print("null in find userprofile");
      }
    }));
    }
    // final checkFieldNumber = await widget.db.accomplishmentDao.findAccomplishmentById(id);

    // setState(() {
    //   if (checkFieldNumber == null){
    //     checkEditFieldNumber = true ;
    //   }
    //   if (checkFieldNumber != null){
    //     checkEditFieldNumber = false ;
    //   }
    // });
    setState(() {
      if(skillText == ""){
        checkEditFieldName = true ;
      }
      if(skillText != ""){
        checkEditFieldName = false ;
      }

    });
    // if(skillText != "" && checkFieldNumber != null){
    // var a = widget.user;
    // if (a != null){
    //   print("this is userid:");
    //   print(a);
    //   await widget.db.accomplishmentDao.editAccomplishment(skillText, id) ;
    //   widget.db.accomplishmentDao.findAccomplishmentById(id).then((val) => setState((){
    //     print("we are in editskilldatabase");
    //     // print(val?.SkillId);
    //     if (val != null){
    //       print("skilltext is going to change");
    //       accopmlishText = val ;
    //       }
    //       else{
    //         print("value is null");
    //       }
    //   }));
    // }
    // }
    }
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10),
      height: 90,
      width: MediaQuery.of(context).size.width*0.88,
      color: Colors.redAccent,
      child: Container(margin: EdgeInsets.only(left: 5),
      child: Column(children: [

          Row(
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
              return editAccomplishmentINDatabase(editFieldAccomplishController.value.text.toString(), editNumberAccomplishController.value.text);

            },
            icon: Icon(Icons.check),
             ),
              ),
              ),) 

            

      ],),
          Container(
          alignment: Alignment.center,
          child: Visibility(
          visible: checkEditFieldName,
          child: Container(child: Text("Edit Field can't be empty" , style: TextStyle(color: Colors.white),),),),),

          Container(
          alignment: Alignment.center,
          child: Visibility(
          visible: checkEditFieldNumber,
          child: Container(child: Text("No such field exists" , style: TextStyle(color: Colors.white),),),),),
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
var otherAccomplishment ;
 List<OtherAccomplishCard> otherList = [];
class OtherAccomplish extends StatefulWidget {
  const OtherAccomplish(this.db , this.user);
  final AppDatabase db ;
  final int? user  ;

  @override
  _OtherAccomplishState createState() => _OtherAccomplishState();
}

class _OtherAccomplishState extends State<OtherAccomplish> {
    List accomplishmentsText = [] ;
    List accomplishmentsId = [] ;

void addAccomplishCard(var id , var text){
  
  otherList.add(new OtherAccomplishCard(id , text));
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
                  addAccomplishCard(value[i]?.AcomplishmentId , value[i]?.AccomplishmentText );
                  var li = otherList[i].text;
                  print("$i , $li");
                }
                
              }
             }
          }));
          print(otherAccomplishment);
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
          
          height: 30,
          margin: EdgeInsets.only(left: 10 , top: 7),
          child: Text("ACCOMPLISHMENTS",
          style: TextStyle(color: Colors.white , fontSize: 15),
          ),
        ),

      ],) ,),
        
      Flexible(child:
       ListView.builder(
        itemCount: otherList.length,
        itemBuilder: (_,index) { 
          return OtherAccomplishCard(otherList[index].id.toString(), otherList[index].text);
          ;}))
      /*Flexible(child: ListView.builder(
        itemCount: list.length,
        itemBuilder: (_,index) => list[index]))*/
      // OtherAccomplishCard() ,

      ], 
      )
      
    );
  }
}
// class OtherAccomplish extends StatelessWidget {
//   const OtherAccomplish({ Key? key }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Container(

//          margin: EdgeInsets.only(top: 20),

//       height: 200,
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
          
//           height: 30,
//           margin: EdgeInsets.only(left: 10 , top: 7),
//           child: Text("ACCOMPLISHMENTS",
//           style: TextStyle(color: Colors.white , fontSize: 15),
//           ),
//         ),

//       ],) ,),
        

//       /*Flexible(child: ListView.builder(
//         itemCount: list.length,
//         itemBuilder: (_,index) => list[index]))*/
//       OtherAccomplishCard() ,

//       ], 
//       )

      
//     );
//   }
// }



class OtherAccomplishCard extends StatefulWidget {
  const OtherAccomplishCard(this.id , this.text);
  final id ;
  final text ;

  @override
  _OtherAccomplishCardState createState() => _OtherAccomplishCardState();
}

class _OtherAccomplishCardState extends State<OtherAccomplishCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10),
      height: 50,
      width: MediaQuery.of(context).size.width*0.88,
      color: Colors.redAccent,
      child: Container(margin: EdgeInsets.only(left: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
        Text(widget.id , style: TextStyle(color: Colors.white),) ,
            Container(
              padding: EdgeInsets.only(left: 5),
              child: Text(widget.text , style: TextStyle(color: Colors.white),),)
      ],)
      )
      
    );
  }
}

// class OtherAccomplishCard extends StatelessWidget {
//   const OtherAccomplishCard(this.id , this.text);
//   final id ;
//   final text ;

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
//         Text("project" , style: TextStyle(color: Colors.white),) ,
//       ],)
//       )
      
//     );
//   }
// }