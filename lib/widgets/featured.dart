

import 'package:dbproject/models/Featured.dart';
import 'package:flutter/material.dart';

import '../database.dart';


bool checkFeatureField = false ; 
bool checkCopy = false ;
class FeaturedList extends StatefulWidget {
  const FeaturedList(this.db , this.user);
  final AppDatabase db ;
  final int? user  ; 

  @override
  _FeaturedListState createState() => _FeaturedListState();
}

class _FeaturedListState extends State<FeaturedList> {

  List featuredsText = [] ;
  List featuredsId = [] ;

addSkillCard(var id , var text){
  
    if(text != "" && checkCopy == false){
  list.add(new FeaturedCard(id , text));
  setState((){});
  }
}
var feature ;
void getFeatures()async{
    var a = widget.user;
    var profileId ;
   

    if (a != null){
      widget.db.userProfileDao.findProfileByUserId(a).then((val) => setState((){
        if (val != null) {
          profileId = val.ProfileId;
          // print("this profileid in test card $profileId");
          // skill = Skill(SkillText: "android" ,profileId: profileId);
          // widget.db.skillDao.insertSkill(skill);q
          widget.db.featuredDao.allAdditionalInfo(profileId).then((value) => setState((){
             if (value != null){
              for (int i = 0 ; i < value.length ; i++){
                if (value[i] != null){
                  print(value[i]?.featuredText);
                  print("this is the skillid :");
                  print(value[i]?.featuredId);
                  addSkillCard(value[i]?.featuredId , value[i]?.featuredText );
                  var li = list[i].text;
                  print("$i , $li");
                }
                
              }
             }
          }));
          print(feature);
          }
      }));
    }
}


@override
  void initState() {
    getFeatures();
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
          child: Text("FEATURED",
          style: TextStyle(color: Colors.white , fontSize: 15),
          ),
        ),
        TextButton(onPressed: (){}, child: Text("Add")) ,

      ],) ,),
        

      Flexible(child:
       ListView.builder(
        itemCount: list.length,
        itemBuilder: (_,index) { 
          return FeaturedCard(list[index].id.toString(), list[index].text);
          ;}))
      

      ], 
      )

      
    );
  }
}

List<FeaturedCard> list = [];
class FeaturedCard extends StatefulWidget {
  const FeaturedCard(this.id , this.text);
  final id ;
  final text ;

  @override
  _FeaturedCardState createState() => _FeaturedCardState();
}

class _FeaturedCardState extends State<FeaturedCard> {
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

// class FeaturedCard extends StatelessWidget {
//   const FeaturedCard({ Key? key }) : super(key: key);

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
//               child: Text("Article" , style: TextStyle(color: Colors.white),),)
            


//         ],),
//         TextButton(onPressed: (){}, child: Text("Edit")),

//       ],)
//       )
      
//     );
//   }
// }

class EditFeaturedCard extends StatefulWidget {
  const EditFeaturedCard(this.db , this.user) ;
  final AppDatabase db ;
  final int? user  ; 

  @override
  _EditFeaturedCardState createState() => _EditFeaturedCardState();
}

class _EditFeaturedCardState extends State<EditFeaturedCard> {
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
          child: Text("ADD/EDIT FEATURED",
          style: TextStyle(color: Colors.white , fontSize: 15),
          ),
        ),
        TextButton(onPressed: (){}, child: Text("Edit")) ,

      ],) ,),


      
      Container(
        
        child: SingleChildScrollView(child: Column(children: [
              NewFeature(widget.db , widget.user),
              EditedCard(widget.db , widget.user),
      ],),),)

      ], 
      )
      
    );
  }
}

// class EditFeaturedCard extends StatelessWidget {
//   const EditFeaturedCard(this.db , this.user) ;
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
//           child: Text("ADD/EDIT FEATURED",
//           style: TextStyle(color: Colors.white , fontSize: 15),
//           ),
//         ),
//         TextButton(onPressed: (){}, child: Text("Edit")) ,

//       ],) ,),


      
//       Container(
        
//         child: SingleChildScrollView(child: Column(children: [
//               NewFeature(widget.db , widget.user),
//               // EditedCard(),
//       ],),),)

//       ], 
//       )
//     );
//   }
// }
TextEditingController addFeatureController = TextEditingController();

class NewFeature extends StatefulWidget {
  const NewFeature(this.db , this.user);
  final AppDatabase db ;
  final int? user  ;

  @override
  _NewFeatureState createState() => _NewFeatureState();
}

class _NewFeatureState extends State<NewFeature> {


    void addFeatureCard(var id , var text){
    if(text != ""&& checkCopy == false){
    list.add(new FeaturedCard(id , text));
    setState((){});
    }
  }

  void addFeatureToDatabase(String featureText)async{
    final checkCopyField = await widget.db.featuredDao.findFeaturedByText(featureText);
    var a = widget.user;
    var profileId ;
    var feature ;

        setState(() {
      if(checkCopyField != null){
        checkCopy = true ;
      }
      if(checkCopyField == null){
        checkCopy = false ;
      }
    });

    setState(() {
    if(featureText == ""){
      checkFeatureField = true ;
    }
    if(featureText != ""){
      checkFeatureField = false ;
    }


    });

    if(featureText != "" && checkCopyField == null){
    if (a != null){
      widget.db.userProfileDao.findProfileByUserId(a).then((val) => setState((){
        if (val != null) {
          profileId = val.ProfileId;
          print("this profileid in test card $profileId");
          feature = Featured(featuredText: featureText ,profileId: profileId);
          widget.db.featuredDao.insertFeatured(feature);
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
      addFeatureController.text = ''  ;
    }
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
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
        Container(
          color: Colors.white,
          width: MediaQuery.of(context).size.width*0.86,
          margin: EdgeInsets.only(left: 10),
          child: TextField(
            controller: addFeatureController,
            decoration: InputDecoration(
            hintText: "Feature name",
            hintStyle: TextStyle(color: Colors.redAccent),
            suffixIcon: IconButton(onPressed: () => addFeatureToDatabase(addFeatureController.text)


            , icon : Icon(Icons.check)),
            
            ),
            
            
          )
        ),
        Container(
          alignment: Alignment.center,
          child: Visibility(
          visible: checkFeatureField,
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

// class NewFeature extends StatelessWidget {
//   const NewFeature({ Key? key }) : super(key: key);

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
//             controller: addFeatureController,
//             decoration: InputDecoration(
//             hintText: "Feature name",
//             hintStyle: TextStyle(color: Colors.redAccent),
//             suffixIcon: IconButton(onPressed: (){}, icon : Icon(Icons.check)),
            
//             ),
            
            
//           )
//         ),
        

//       ],),
      
//     );
//   }
// }


TextEditingController editNumberFeatureController = TextEditingController();
TextEditingController editFieldFeatureController = TextEditingController();

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
    void editFeatureINDatabase(var featureText , String idNumber)async{

      setState(() {
      if(idNumber == ""){
        checkEditFieldNumber = true ;
      }
      if(idNumber != ""){
        checkEditFieldNumber = false ;
      }
    });

    if(idNumber != ""){
      int id = int.parse(editNumberFeatureController.value.text);
    final checkFieldNumber = await widget.db.accomplishmentDao.findAccomplishmentById(id);

    setState(() {
      if (checkFieldNumber == null){
        checkEditFieldNumber = true ;
      }
      if (checkFieldNumber != null){
        checkEditFieldNumber = false ;
      }
    });
    setState(() {
      if(featureText == ""){
        checkEditFieldName = true ;
      }
      if(featureText != ""){
        checkEditFieldName = false ;
      }

    });
    if(featureText != "" && checkFieldNumber != null){
    var a = widget.user;
    if (a != null){
      print("this is userid:");
      print(a);
      await widget.db.featuredDao.editFeatured(featureText, id) ;
      widget.db.featuredDao.findFeaturedById(id).then((val) => setState((){
        print("we are in editskilldatabase");
        print(val?.featuredText);
        if (val != null){
          print("skilltext is going to change");
          featureText = val.featuredText ;
          }
          else{
            print("value is null");
          }
      }));
    }
    }
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
            controller: editNumberFeatureController,
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
            controller: editFieldFeatureController,
            decoration: InputDecoration(
            hintText: "Edit field",
            suffixIcon: IconButton(
            onPressed: () {
              return editFeatureINDatabase(editFieldFeatureController.value.text.toString(), editNumberFeatureController.value.text);
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
//             controller: editNumberFeatureController,
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
//             controller: editFieldFeatureController,
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