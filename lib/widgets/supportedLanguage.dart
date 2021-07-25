import 'package:dbproject/models/Language.dart';
import 'package:flutter/material.dart';

import '../database.dart';

bool checkCopy = false ;
bool checkLanguageField = false ;
List<LanguageCard> list = [];
class LanguageList extends StatefulWidget {
  const LanguageList(this.db , this.user);
  final AppDatabase db ;
  final int? user  ; 

  @override
  _LanguageListState createState() => _LanguageListState();
}

class _LanguageListState extends State<LanguageList> {
         
void addLanguageCard(var id , var text){
  setState(() {
    if(text == ""){
    checkLanguageField = true ;
  }
  });
  
  if(text != "" && checkCopy == false){
  list.add(new LanguageCard(id , text , widget.db));
  setState((){});
  }
}

  void getLanguages()async{
    var a = widget.user;
    var profileId ;
   

    if (a != null){
      widget.db.userProfileDao.findProfileByUserId(a).then((val) => setState((){
        if (val != null) {
          profileId = val.ProfileId;
          // print("this profileid in test card $profileId");
          // skill = Skill(SkillText: "android" ,profileId: profileId);
          // widget.db.skillDao.insertSkill(skill);q
          widget.db.languageDao.allAdditionalInfo(profileId).then((value) => setState((){
             if (value != null){
              for (int i = 0 ; i < value.length ; i++){
                if (value[i] != null){
                  print(value[i].LanguageName);
                  print("this is the skillid :");
                  print(value[i].LanguageId);
                  addLanguageCard(value[i].LanguageId , value[i].LanguageName );
                  var li = list[i].text;
                  print("$i , $li");
                }
                
              }
             }
          }));
          // print(skill);
          }
      }));
    }

    
    // print("this my profileid $profileId");
    
  }

  @override
  void initState() {
    getLanguages();
    super.initState();
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
        TextButton(onPressed:(){}, child: Text("Add")) ,

      ],) ,),
        

      Flexible(child:
       ListView.builder(
        itemCount: list.length,
        itemBuilder: (_,index) { 
          return LanguageCard(list[index].id.toString(), list[index].text , widget.db);
          ;}))
      

      ], 
      )
      
    );
  }
}


class LanguageCard extends StatefulWidget {
  const LanguageCard(this.id , this.text , this.db);
  final id ;
  final text ;
  final AppDatabase db ;

  @override
  _LanguageCardState createState() => _LanguageCardState();
}

class _LanguageCardState extends State<LanguageCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: MediaQuery.of(context).size.width*0.88,
      color: Colors.redAccent,
      margin: EdgeInsets.only(top: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(children: [
            Container(
          margin: EdgeInsets.only(left: 10),
          child: Text(widget.id, 
          style: TextStyle(color: Colors.white , fontSize: 13),
          ),
        ),
        Container(
          margin: EdgeInsets.only(left: 5),
          child: Text(widget.text , 
          style: TextStyle(color: Colors.white , fontSize: 13),
          ),
        ),

          ],),
        
        Row(children: [
        TextButton(onPressed: (){}, child: Text("Delete")),
        TextButton(onPressed: (){}, child: Text("Edit"))
        ],)
        

      ],),
      
    );
  }
}
// class LanguageCard extends StatelessWidget {
//   const LanguageCard({ Key? key }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: 100,
//       width: MediaQuery.of(context).size.width*0.88,
//       color: Colors.redAccent,
//       margin: EdgeInsets.only(top: 10),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//         Container(
//           margin: EdgeInsets.only(left: 10),
//           child: Text("data" , 
//           style: TextStyle(color: Colors.white , fontSize: 13),
//           ),
//         ),
//         Row(children: [
//         TextButton(onPressed: (){}, child: Text("Delete")),
//         TextButton(onPressed: (){}, child: Text("Edit"))
//         ],)
        

//       ],),
      
//     );
//   }
// }


TextEditingController languageController = TextEditingController();


class EditLanguageCard extends StatefulWidget {
  const EditLanguageCard(this.db , this.user) ;
  final AppDatabase db ;
  final int? user  ; 

  @override
  _EditLanguageCardState createState() => _EditLanguageCardState();
}

class _EditLanguageCardState extends State<EditLanguageCard> {
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
          child: Text("ADD/EDIT LANGUAGE",
          style: TextStyle(color: Colors.white , fontSize: 15),
          ),
        ),
        TextButton(onPressed: (){}, child: Text("Edit")) ,

      ],) ,),

      Container(
        
        child: SingleChildScrollView(child: Column(children: [
              AddLanguage(widget.db , widget.user),
              EditedCard(widget.db , widget.user),
      ],),),)
      


      ], 
      )
      
    );
  }
}

// class EditLanguageCard extends StatelessWidget {
//   const EditLanguageCard(this.db , this.user) ;
//   final AppDatabase db ;
//   final int? user  ; 

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//             margin: EdgeInsets.only(top: 20),

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
//           child: Text("ADD/EDIT LANGUAGE",
//           style: TextStyle(color: Colors.white , fontSize: 15),
//           ),
//         ),
//         TextButton(onPressed: (){}, child: Text("Edit")) ,

//       ],) ,),

//       Container(
        
//         child: SingleChildScrollView(child: Column(children: [
//               AddLanguage(widget.db , widget.user),
//               EditedCard(),
//       ],),),)
      


//       ], 
//       )
      
//     );
//   }
// }
TextEditingController editNumberLanguageController = TextEditingController();
TextEditingController editFieldLanguageController = TextEditingController();


class EditedCard extends StatefulWidget {
  const EditedCard(this.db , this.user) ;
  final AppDatabase db ;
  final int? user  ; 

  @override
  _EditedCardState createState() => _EditedCardState();
}

class _EditedCardState extends State<EditedCard> {
    bool checkEditFieldName = false  ;
  bool checkEditFieldNumber = false ;
  void editLanguageINDatabase(var languageText , String idNumber)async{

    setState(() {
      if(idNumber == ""){
        checkEditFieldNumber = true ;
      }
      if(idNumber != ""){
        checkEditFieldNumber = false ;
      }
    });

    if(idNumber != ""){

    int id = int.parse(editNumberLanguageController.value.text);
    var a = widget.user;
    if(a != null){
      widget.db.userProfileDao.findProfileByUserId(a).then((value) => setState((){
        print("eeeeeeeeeeeeeeeeeeeeeeeeeeeeeee");
      if(value != null){
        var checkFieldNumber ;
          widget.db.languageDao.findLanguageById(id , value.ProfileId!).then((v) => setState((){
            if (v != null ){
             print("find skill by name is not null");
             checkFieldNumber = v ;
             checkEditFieldNumber = false ;
             if(languageText != "" && checkFieldNumber != null){
          print("this is userid:");
      print(a);
      widget.db.languageDao.editLanguage(languageText, id) ;
      widget.db.languageDao.findLanguageById(id , value.ProfileId!).then((val) => setState((){
        print("we are in editskilldatabase");
        print(val?.LanguageId);
        if (val != null){
          print("skilltext is going to change");
          languageText = val.LanguageName ;
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
    // final checkFieldNumber = await widget.db.skillDao.findSkillById(id);
    // setState(() {
    //   if (checkFieldNumber == null){
    //     checkEditFieldNumber = true ;
    //   }
    //   if (checkFieldNumber != null){
    //     checkEditFieldNumber = false ;
    //   }
    // });
    setState(() {
      if(languageText == ""){
        checkEditFieldName = true ;
      }
      if(languageText != ""){
        checkEditFieldName = false ;
      }

    });

  //   if(skillText != "" && checkFieldNumber != null){
    
  //   if (a != null){
  //     print("this is userid:");
  //     print(a);
  //     await widget.db.skillDao.editSkill(skillText, id) ;
  //     widget.db.skillDao.findSkillById(id).then((val) => setState((){
  //       print("we are in editskilldatabase");
  //       print(val?.SkillId);
  //       if (val != null){
  //         print("skilltext is going to change");
  //         skillText = val.SkillText ;
  //         }
  //         else{
  //           print("value is null");
  //         }
  //     }));
  //   }
  // }
    }
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10),
      height: 100,
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
            controller: editNumberLanguageController,
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
            controller: editFieldLanguageController,
            decoration: InputDecoration(
            hintText: "Edit field",
            suffixIcon: IconButton(
            onPressed: () {
              return editLanguageINDatabase(editFieldLanguageController.value.text.toString(), editNumberLanguageController.value.text);
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
          child: Container(child: Text("Edit filed can't be empty" , style: TextStyle(color: Colors.white),),),),),

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

//        margin: EdgeInsets.only(top: 10),
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
//             controller: editNumberLanguageController,
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
//             controller: editFieldLanguageController,
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



class AddLanguage extends StatefulWidget {
  const AddLanguage(this.db , this.user);
  final AppDatabase db ;
  final int? user  ; 

  @override
  _AddLanguageState createState() => _AddLanguageState();
}

class _AddLanguageState extends State<AddLanguage> {
  
  void addLanguageCard(var id , var text){
    if(text != ""&& checkCopy == false){
    list.add(new LanguageCard(id , text , widget.db));
    setState((){});
    }
  }

  void addLanguageToDatabase(String languageText)async{
    print("in addSkillToDatabase ");
    
    var a = widget.user ;
    print(widget.user);
    if(a != null){
      widget.db.userProfileDao.findProfileByUserId(a).then((value) => setState((){
        print("eeeeeeeeeeeeeeeeeeeeeeeeeeeeeee");
      if(value != null){
        var checkCopyField ;
          widget.db.languageDao.findLanguageByName(languageText , value.ProfileId!).then((v) => setState((){
            if (v != null ){
             print("find skill by name is not null");
             checkCopyField = v ;
             checkCopy = true ;

          }else{
        print("find skill by name is null");
        checkCopyField = null ;
        checkCopy = false ;
        if(languageText != "" && checkCopyField == null){
          var profileId ;
    var language ;
      widget.db.userProfileDao.findProfileByUserId(a).then((val) => setState((){
        if (val != null) {
          profileId = val.ProfileId;
          print("this profileid in test card $profileId");
          language = Language(LanguageName: languageText , profileId: profileId );
          widget.db.languageDao.insertLanguage(language);
          }
      }
      
      ));
      addLanguageController.text = ''  ;
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
    
    

    // var a = widget.user;
    

    // setState(() {
    //   if(checkCopyField != null){
    //     checkCopy = true ;
    //   }
    //   if(checkCopyField == null){
    //     checkCopy = false ;
    //   }
    // });

    setState(() {
      if (languageText == ""){
      checkLanguageField = true ;
      print("YYYYYYYYYYYYYYYYYYYYYYYY") ;
    }
  
    });
    setState(() {
      if (languageText != ""){
      checkLanguageField = false;
      print("YYYYYYYYYYYYYYYYYYYYYYYY") ;
    }
  
    });


    


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
            controller: addLanguageController,
            decoration: InputDecoration(
            hintText: "Language name",
            hintStyle: TextStyle(color: Colors.redAccent),
            suffixIcon: IconButton(onPressed: () => addLanguageToDatabase(addLanguageController.text), icon : Icon(Icons.check)),
            
            ),
            
            
          )
        ),
        Container(
          alignment: Alignment.center,
          child: Visibility(
          visible: checkLanguageField,
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
TextEditingController addLanguageController = TextEditingController();
// class AddLanguage extends StatelessWidget {
//   const AddLanguage({ Key? key }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: 100,
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
//             controller: addLanguageController,
//             decoration: InputDecoration(
//             hintText: "Language name",
//             hintStyle: TextStyle(color: Colors.redAccent),
//             suffixIcon: IconButton(onPressed: (){}, icon : Icon(Icons.check)),
            
//             ),
            
            
//           )
//         ),
        

//       ],),
      
//     );
//   }
// }


var otherLanguage ;
 List<OtherLanguageCard> otherList = [];
class OtherLanguage extends StatefulWidget {
  const OtherLanguage(this.db , this.user);
  final AppDatabase db ;
  final int? user  ;

  @override
  _OtherLanguageState createState() => _OtherLanguageState();
}

class _OtherLanguageState extends State<OtherLanguage> {
  void addLanguageCard(var id , var text){
  
  otherList.add(new OtherLanguageCard(id , text));
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

          widget.db.languageDao.allAdditionalInfo(profileId).then((value) => setState((){
             if (value != null){
              for (int i = 0 ; i < value.length ; i++){
                if (value[i] != null){
                  print(value[i].LanguageName);
                  print("this is the skillid :");
                  print(value[i].LanguageId);
                  addLanguageCard(value[i].LanguageId , value[i].LanguageName );
                  var li = otherList[i].text;
                  print("$i , $li");
                }
                
              }
             }
          }));
          print(otherLanguage);
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
          child: Text("LANGUAGES",
          style: TextStyle(color: Colors.white , fontSize: 15),
          ),
        ),

      ],) ,),

      Flexible(child:
       ListView.builder(
        itemCount: otherList.length,
        itemBuilder: (_,index) { 
          return OtherLanguageCard(otherList[index].id.toString(), otherList[index].text);
          ;}))
      // OtherLanguageCard(),

      /*Flexible(child: ListView.builder(
        itemCount: list.length,
        itemBuilder: (_,index) => list[index]))*/
      

      ], 
      )
      
    );
  }
}
// class OtherLanguage extends StatelessWidget {
//   const OtherLanguage({ Key? key }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Container(

//       margin: EdgeInsets.only(top: 20),

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
//           child: Text("LANGUAGES",
//           style: TextStyle(color: Colors.white , fontSize: 15),
//           ),
//         ),

//       ],) ,),
//       OtherLanguageCard(),

//       /*Flexible(child: ListView.builder(
//         itemCount: list.length,
//         itemBuilder: (_,index) => list[index]))*/
      

//       ], 
//       )

      
//     );
//   }
// }


class OtherLanguageCard extends StatefulWidget {
  const OtherLanguageCard(this.id , this.text);
  final id ;
  final text ;

  @override
  _OtherLanguageCardState createState() => _OtherLanguageCardState();
}

class _OtherLanguageCardState extends State<OtherLanguageCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
       height: 50,
      width: MediaQuery.of(context).size.width*0.88,
      color: Colors.redAccent,
      margin: EdgeInsets.only(top: 10 ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
        Container(
          padding: EdgeInsets.only(left:5),
          child: Text(widget.id , style: TextStyle(color: Colors.white),) ,),
        
        Container(
          margin: EdgeInsets.only(left: 5),
          child: Text(widget.text , 
          style: TextStyle(color: Colors.white , fontSize: 13),
          ),
        ),
        

      ],),
      
    );
  }
}

// class OtherLanguageCard extends StatelessWidget {
//   const OtherLanguageCard({ Key? key }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//         height: 100,
//       width: MediaQuery.of(context).size.width*0.88,
//       color: Colors.redAccent,
//       margin: EdgeInsets.only(top: 10),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//         Container(
//           margin: EdgeInsets.only(left: 10),
//           child: Text("data" , 
//           style: TextStyle(color: Colors.white , fontSize: 13),
//           ),
//         ),
        

//       ],),
      
//     );
//   }
// }

