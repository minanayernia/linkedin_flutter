import 'package:dbproject/models/AditionallInfo.dart';
import 'package:dbproject/models/Network.dart';
import 'package:dbproject/models/Notification.dart';
import 'package:dbproject/widgets/additionalinformation.dart';
import 'package:flutter/material.dart';

import '../database.dart';


class CurrentJob extends StatefulWidget {
  const CurrentJob(this.id , this.company , this.job);
  final id ;
  final company ;
  final job ;

  @override
  _CurrentJobState createState() => _CurrentJobState();
}

class _CurrentJobState extends State<CurrentJob> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10),
      height: 50,
      width: MediaQuery.of(context).size.width*0.88,
      color: Colors.white,
      child: Container(margin: EdgeInsets.only(left: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
        Visibility(
          visible: true,
          child: Container(
            width: 100,
            alignment: Alignment.center,
            color: Colors.redAccent,
            child: Text("Current job" , style: TextStyle(color: Colors.white),),) ),
        
        Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
        Row(children: [
            Text(widget.id , style: TextStyle(color: Colors.redAccent),) ,
            Container(
              padding: EdgeInsets.only(left: 5),
              child: Text(widget.company , style: TextStyle(color: Colors.redAccent),),),
              Container(
              padding: EdgeInsets.only(left: 5),
              child: Text(widget.job , style: TextStyle(color: Colors.redAccent),),)
            


        ],),
        
        // TextButton(onPressed: (){}, child: Text("Edit")),

      ],)

      ],),
      
      
      )
      
    );
  }
}
class AboutCard extends StatefulWidget {
const AboutCard(this.job , this.company , this.id , this.db);
  final id ;
  final company ;
  final job ;
  final AppDatabase db ;
  @override
  _AboutCardState createState() => _AboutCardState();
}

class _AboutCardState extends State<AboutCard> {

  void deleteJob()async{
    await widget.db.additionalInfoDao.deleteJobByjobid(int.parse(widget.id));
    print("job deleted successfully");
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10),
      height: 80,
      width: MediaQuery.of(context).size.width*0.88,
      color: Colors.redAccent,
      child: Container(margin: EdgeInsets.only(left: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
        
        Text(widget.id , style: TextStyle(color: Colors.white),),
            Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
        Row(children: [
          Text("Company :   " , style: TextStyle(color: Colors.white),),
            Text(widget.company , style: TextStyle(color: Colors.white),) ,
            Text("   Job : " , style: TextStyle(color: Colors.white),),
            Container(
              padding: EdgeInsets.only(left: 5),
              child: Text(widget.job , style: TextStyle(color: Colors.white),),)
            


        ],),
      ],),
      
      
        Container(
          // margin: EdgeInsets.only(bottom: 20),
          alignment: Alignment.bottomRight,
          child: TextButton(onPressed: (){
            return deleteJob();
          }, child: Text("delete")),),
        

      ],)


      
      
      )
      
    );
  }
}
// class AboutCard extends StatelessWidget {
//   const AboutCard(this.id , this.text);
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
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//         Visibility(
//           visible: true,
//           child: Container(
//             width: 100,
//             alignment: Alignment.center,
//             color: Colors.white,
//             child: Text("Current job" , style: TextStyle(color: Colors.redAccent),),) ),
        
//         Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//         Row(children: [
//             Text( , style: TextStyle(color: Colors.white),) ,
//             Container(
//               padding: EdgeInsets.only(left: 5),
//               child: Text("project" , style: TextStyle(color: Colors.white),),)
            


//         ],),
        
//         TextButton(onPressed: (){}, child: Text("Edit")),

//       ],)

//       ],),
      
      
//       )
      
      
//     );
//   }
// }

var additionalInfo ;

bool checkAdditionalInfoField = false ;
bool checkCopy = false ;
List<AboutCard> list = [];
class AdditionalInfoList extends StatefulWidget {
  const AdditionalInfoList(this.db , this.user);
  final AppDatabase db ;
  final int? user  ; 

  @override
  _AdditionalInfoListState createState() => _AdditionalInfoListState();
}

class _AdditionalInfoListState extends State<AdditionalInfoList> {

// List<int> parseNetwork(List network, userId) { 
//   List<int> myNet = [];

//   for (var i in network){
//     if (i.userId == userId){
//         myNet.add(i.userReq);
//     } else {
//       myNet.add(i.userId);
//     }
//   }

//   return myNet;
// }

// int findNumberOfMutualConnections(List network1,List network2) { 
//   int n = 0;

//   for (var i in network1){
//     if (network2.contains(i)){
//       n++;
//     }
//   }
//   return n;
// }


  // void findmynet()async{
  //   print("we are in findmynet");
  //   widget.db.netwokDao.allNetwork(widget.user!).then((value) => setState((){
  //     print("we are finding users of my network!!");
  //     print(value);
  //     var x = parseNetwork(value , widget.user);
  //     print("mamad's $x");
  //   }));
  // }

addInfoCard(var job , var company , var id){
  
  if(company != "" && job != ""){
  list.add(new AboutCard(job , company , id , widget.db));
  setState((){});
  }
}

  void getAdditionalInfo()async{
    var a = widget.user;
    var profileId ;
   
    list.clear();
    if (a != null){
      widget.db.userProfileDao.findProfileByUserId(a).then((val) => setState((){
        if (val != null) {
          profileId = val.ProfileId;
          // print("this profileid in test card $profileId");
          // skill = Skill(SkillText: "android" ,profileId: profileId);
          // widget.db.skillDao.insertSkill(skill);q

          widget.db.additionalInfoDao.allAdditionalInfo(profileId).then((value) => setState((){
             if (value != null){
              for (int i = 0 ; i < value.length ; i++){
                if (value[i] != null){
                  print(value[i].jobName);
                  print("this is the skillid :");
                  print(value[i].jobId);
                  addInfoCard(value[i].jobName  , value[i].companyName , value[i].jobId);
                  // var li = list[i].text;
                  // print("$i , $li");
                }
                
              }
             }
          }));
          print(additionalInfo);
          }
      }));
    }
  }
 @override
  void initState() {
    // findmynet();
    getAdditionalInfo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // getAdditionalInfo();
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
          height: 30,
          margin: EdgeInsets.only(left: 10 , top: 7),
          child: Text("ADDITIONALINFO",
          style: TextStyle(color: Colors.white , fontSize: 15),
          ),
        ),
        TextButton(onPressed:(){}, child: Text("Add")) ,

      ],) ,),
        
      // AboutCard(),
      CurrentJob(list.length > 0 ? list[list.length-1].id.toString() : "" , list.length > 0 ? list[list.length-1].company : "Not filled" , list.length > 0 ? list[list.length-1].job : "Not filled" ),
      Flexible(child:
       ListView.builder(
        itemCount: list.length,
        itemBuilder: (_,index) { 
          return AboutCard(list[index].job, list[index].company , list[index].id.toString() , widget.db);
          }))

      ], 
      )
      
    );
  }
}


TextEditingController infoController = TextEditingController();


class EditInfoCard extends StatefulWidget {
  const EditInfoCard(this.db , this.user);
  final AppDatabase db ;
    final int? user  ; 

  @override
  _EditInfoCardState createState() => _EditInfoCardState();
}

class _EditInfoCardState extends State<EditInfoCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
             margin: EdgeInsets.only(top: 20),

      height: 350,
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
        height: 300,
        
        child: SingleChildScrollView(child: Column(children: [
              NewInfo(widget.db , widget.user),
              EditedCard(widget.db , widget.user),
      ],),),)

      ], 
      )
      
    );
  }
}
// class EditInfoCard extends StatelessWidget {
//   const EditInfoCard(this.db , this.user);
//   final AppDatabase db ;
//   final int? user  ; 

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//              margin: EdgeInsets.only(top: 20),

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
//           child: Text("ADD/EDIT ADDITIONALINFO",
//           style: TextStyle(color: Colors.white , fontSize: 15),
//           ),
//         ),
//         TextButton(onPressed: (){}, child: Text("Edit")) ,

//       ],) ,),


      
//       Container(
        
//         child: SingleChildScrollView(child: Column(children: [
//               NewInfo(Widget.db , Widget.user),
//               EditedCard(),
//       ],),),)

//       ], 
//       )
      
//     );
//   }
// }
TextEditingController addInfoCompanyController = TextEditingController();
TextEditingController addInfoJobController = TextEditingController();


class NewInfo extends StatefulWidget {
  const NewInfo(this.db , this.user);
  final AppDatabase db ;
  final int? user  ; 

  @override
  _NewInfoState createState() => _NewInfoState();
}

class _NewInfoState extends State<NewInfo> {


 List<int> parseNetwork(List<Network?> network, userId) { 
  List<int> myNet = [];

  for (var i in network){
    if (i?.userId == userId){
      var k = i?.userReqId;
        myNet.add(k!);
    } else {
      var j = i?.userId ;
      myNet.add(j!);
    }
  }

  return myNet;
}

  int findNumberOfMutualConnections(List network1,List network2) { 
  int n = 0;

  for (var i in network1){
    if (network2.contains(i)){
      n++;
    }
  }
  return n;
}



    void addInfoCard(var job , var company , var id){
    if(company != "" && job != ""){
    list.add(new AboutCard(job , company , id , widget.db));
    setState((){});
    }
  }

    void addInfoToDatabase(String additionalInfoCompany , String additionalInfoJob)async{
    var a = widget.user;
    // var profileId ;
    // var accomplishment ;

    if (a != null){
      widget.db.userProfileDao.findProfileByUserId(a).then((value) => setState((){
        print("eeeeeeeeeeeeeeeeeeeeeeeeeeeeeee");
      if(value != null){

          if(additionalInfoJob != "" && additionalInfoCompany != ""){
            var profileId = value.ProfileId ;
            var info = AdditionalInfo(companyName: additionalInfoCompany, jobName: additionalInfoJob, profileId: profileId);
            widget.db.additionalInfoDao.insertAditionalInfo(info);

            //adding notification type7 for job change
            widget.db.netwokDao.allNetwork(a).then((val) => setState((){
              var mycons = parseNetwork(val, a);
              for( var i in mycons){
                var notif = Notificationn(notificationType: 7, receiver: i, sender: a);
              widget.db.notificationnDao.insertNotif(notif);
              print("current job notif changed");
              }
              
            }));
            //end of notif

            
            addInfoJobController.text = "" ;
            addInfoCompanyController.text = "";
            
          }


    //     var checkCopyField ;
    //       widget.db.additionalInfoDao.findAdditionalInfoByText(additionalInfoText , value.ProfileId!).then((v) => setState((){
    //         if (v != null ){
    //          print("find skill by name is not null");
    //          checkCopyField = v ;
    //          checkCopy = true ;

    //       }else{
    //     print("find skill by name is null");
    //     checkCopyField = null ;
    //     checkCopy = false ;
    //     if(additionalInfoText != "" && checkCopyField == null){
    //       var profileId ;
    //        var info ;
    //         widget.db.userProfileDao.findProfileByUserId(a).then((val) => setState((){
    //         if (val != null) {
    //         profileId = val.ProfileId;
    //       print("this profileid in test card $profileId");
    //       info = AdditionalInfo(jobName: additionalInfoText , companyName: profileId , profileId: profileId);
    //       widget.db.additionalInfoDao.insertAditionalInfo(info);
    //       }
    //   }
      
    //   ));
    //   addInfoController.text = ''  ;
    // }
    //   }
    // }));
        
        // print("profid : $profid");
      }
      else{
        print("null in find userprofile");
      }
    }));
    }



    setState(() {
    if(additionalInfoJob == "" || additionalInfoCompany == ""){
      checkAdditionalInfoField = true ;
    }
    if(additionalInfoJob != "" && additionalInfoCompany != ""){
      checkAdditionalInfoField = false ;
    }

    });
    //    

  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 180,
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
          child: Column(children: [
            TextField(
            controller: addInfoCompanyController,
            decoration: InputDecoration(
            hintText: "Company name",
            hintStyle: TextStyle(color: Colors.redAccent), 
            
            ), 
          ),
          TextField(
            controller: addInfoJobController,
            decoration: InputDecoration(
            hintText: "Job name",
            hintStyle: TextStyle(color: Colors.redAccent), 
            
            ), 
            
          ),
          Container(
            margin: EdgeInsets.only(top:10),
          alignment: Alignment.center,
          child: Visibility(
          visible: checkAdditionalInfoField,
          child: Container(child: Text("Field's names can't be empty" , style: TextStyle(color: Colors.redAccent),),),),),
              Container(
                alignment: Alignment.bottomRight,
                // margin: EdgeInsets.only(top:10 ),
                child:  ButtonTheme(
          height: 40,
          minWidth: MediaQuery.of(context).size.width*0.1,
          buttonColor: Colors.redAccent,
          child: RaisedButton(onPressed: (){
                addInfoToDatabase(addInfoCompanyController.text, addInfoJobController.text);
          },
           child: Text("Add" , style: TextStyle(color: Colors.white),))) ,)
            
          ],)
          
          
        ),
        

      ],),
      
    );
  }
}
// class NewInfo extends StatelessWidget {
//   const NewInfo({ Key? key }) : super(key: key);

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
//             controller: addInfoController,
//             decoration: InputDecoration(
//             hintText: "AdditionalInfo name",
//             hintStyle: TextStyle(color: Colors.redAccent),
//             suffixIcon: IconButton(onPressed: (){}, icon : Icon(Icons.check)),
            
//             ),
            
            
//           )
//         ),
        

//       ],),
      
//     );
//   }
// }

TextEditingController editNumberInfoController = TextEditingController();
TextEditingController editCompanyFieldInfoController = TextEditingController();
TextEditingController editJobFieldInfoController = TextEditingController();



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
  void editInfoINDatabase( var jobName , var companyName , String idNumber)async{

    setState(() {
      if(idNumber == ""){
        checkEditFieldNumber = true ;
      }
      if(idNumber != ""){
        checkEditFieldNumber = false ;
      }
    });
    
    if(idNumber != ""){
    int id = int.parse(editNumberInfoController.value.text);
    var a = widget.user; 
    if(a != null){
      widget.db.userProfileDao.findProfileByUserId(a).then((value) => setState((){
        print("eeeeeeeeeeeeeeeeeeeeeeeeeeeeeee");
      if(value != null){
        var checkFieldNumber ;
          widget.db.additionalInfoDao.findAdditionalInfoById(id , value.ProfileId!).then((v) => setState((){
            if (v != null ){
             print("find skill by name is not null");
             checkFieldNumber = v ;
             checkEditFieldNumber = false ;
             if(companyName != "" && jobName != "" && checkFieldNumber != null){
          print("this is userid:");
      print(a);
      widget.db.additionalInfoDao.editAditinallInfo(jobName ,companyName, id) ;
      widget.db.additionalInfoDao.findAdditionalInfoById(id , value.ProfileId!).then((val) => setState((){
        print("we are in editskilldatabase");
        print(val?.jobId);
        if (val != null){
          print("skilltext is going to change");
          companyName = val.jobName ;
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
  
    setState(() {
      if(companyName == "" || jobName == ""){
        checkEditFieldName = true ;
      }
      if(companyName != "" && jobName != ""){
        checkEditFieldName = false ;
      }

    });

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
          width: MediaQuery.of(context).size.width*0.2,
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
              width: MediaQuery.of(context).size.width*0.3,
              child: TextField(
            controller: editCompanyFieldInfoController,
            decoration: InputDecoration(
            hintText: "Edit company field",
            // suffixIcon: IconButton(
            // onPressed: () {},
            // icon: Icon(Icons.check),
            //  ),
              ),
              ),),

              Container(
              width: MediaQuery.of(context).size.width*0.3,
              child: TextField(
            controller: editJobFieldInfoController,
            decoration: InputDecoration(
            hintText: "Edit job field",
            suffixIcon: IconButton(
            onPressed: () => editInfoINDatabase(editJobFieldInfoController.value.text.toString() , editCompanyFieldInfoController.value.text.toString() , editNumberInfoController.text),
            icon: Icon(Icons.check),
             ),
              ),
              ),) 

            

      ],),
          Container(
          alignment: Alignment.center,
          child: Visibility(
          visible: checkEditFieldName,
          child: Container(child: Text("Edit Fields can't be empty" , style: TextStyle(color: Colors.white),),),),),

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
//   const EditedCard(this.db , this.user) ;
//   final AppDatabase db ;
//   final int? user  ; 

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
//           width: MediaQuery.of(context).size.width*0.2,
//           child: TextField(
//             controller: editNumberInfoController,
//             decoration: InputDecoration(
//             hintText: "Field number",
//             suffixIcon: IconButton(
//             onPressed: () {},
//             icon: Icon(Icons.countertops),
//              ),
//               ),
//               ),) ,
//             Container(
//               width: MediaQuery.of(context).size.width*0.3,
//               child: TextField(
//             controller: editCompanyFieldInfoController,
//             decoration: InputDecoration(
//             hintText: "Edit company field",
//             // suffixIcon: IconButton(
//             // onPressed: () {},
//             // icon: Icon(Icons.check),
//             //  ),
//               ),
//               ),),

//               Container(
//               width: MediaQuery.of(context).size.width*0.3,
//               child: TextField(
//             controller: editJobFieldInfoController,
//             decoration: InputDecoration(
//             hintText: "Edit job field",
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

var otherInfo ;
 List<OtherAdditionalInfoCard> otherList = [];
class OtherAdditionalInfo extends StatefulWidget {
  const OtherAdditionalInfo(this.db , this.user);
  final AppDatabase db ;
  final int? user  ;

  @override
  _OtherAdditionalInfoState createState() => _OtherAdditionalInfoState();
}

class _OtherAdditionalInfoState extends State<OtherAdditionalInfo> {

void addInfoCard(var company , var job , var id){
  
  otherList.add(new OtherAdditionalInfoCard(company , job , id));
  setState((){});
}

  void getInfo()async{
    var a = widget.user;
    var profileId ;
   
    if (a != null){
      widget.db.userProfileDao.findProfileByUserId(a).then((val) => setState((){
        if (val != null) {
          profileId = val.ProfileId;
          // print("this profileid in test card $profileId");
          // skill = Skill(SkillText: "android" ,profileId: profileId);
          // widget.db.skillDao.insertSkill(skill);q

          widget.db.additionalInfoDao.allAdditionalInfo(profileId).then((value) => setState((){
             if (value != null){
              for (int i = 0 ; i < value.length ; i++){
                if (value[i] != null){
                  // print(value[i]?.AccomplishmentText);
                  print("this is the skillid :");
                  // print(value[i]?.AcomplishmentId);
                  addInfoCard(value[i].jobName ,value[i].companyName , value[i].jobId );
                  // var li = otherList[i].text;
                  // print("$i , $li");
                }
                
              }
             }
          }));
          print(otherInfo);
          }
      }));
    }

    
    // print("this my profileid $profileId");
    
  }
  @override
  void initState() {
    getInfo();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 20),
      color: Colors.black87,
      height: 300,
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
          alignment: Alignment.center,
          child:CurrentJob(otherList.length > 0 ? otherList[otherList.length-1].id.toString() : "" , otherList.length > 0 ? otherList[otherList.length-1].company : "Not filled" , otherList.length > 0 ? otherList[otherList.length-1].job : "Not filled" ),
),
      Flexible(child:
       ListView.builder(
        itemCount: otherList.length,
        itemBuilder: (_,index) { 
          return OtherAdditionalInfoCard(otherList[index].job, otherList[index].company , otherList[index].id.toString());
          }))
        
      ],)
      
    );
  }
}



class OtherAdditionalInfoCard extends StatefulWidget {
  const OtherAdditionalInfoCard(this.job , this.company , this.id);
  final id ;
  final company ;
  final job ;

  @override
  _OtherAdditionalInfoCardState createState() => _OtherAdditionalInfoCardState();
}

class _OtherAdditionalInfoCardState extends State<OtherAdditionalInfoCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10),
      height: 80,
      width: MediaQuery.of(context).size.width*0.88,
      color: Colors.redAccent,
      child: Container(margin: EdgeInsets.only(left: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
        
        Text(widget.id , style: TextStyle(color: Colors.white),),
            Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
        Row(children: [
          Text("Company :   " , style: TextStyle(color: Colors.white),),
            Text(widget.company , style: TextStyle(color: Colors.white),) ,
            Text("   Job : " , style: TextStyle(color: Colors.white),),
            Container(
              padding: EdgeInsets.only(left: 5),
              child: Text(widget.job , style: TextStyle(color: Colors.white),),)
            


        ],),
      ],),
      
      
        

      ],)


      
      
      )
      
    );
  }
}
// class OtherAdditionalInfo extends StatelessWidget {
//   const OtherAdditionalInfo({ Key? key }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: EdgeInsets.only(top: 20),
//       color: Colors.black87,
//       height: 100,
//       width: MediaQuery.of(context).size.width * 0.9,
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
        
//         Container(
//           color: Colors.redAccent,
//           child: Row(children: [
//             Container(
//           margin: EdgeInsets.only(left: 10),
//           child:  Text("ADDITIONALINFO",
//           style: TextStyle(color: Colors.white , fontSize: 15),
//           ),

//         ),
        
//         ],),),
        
//         Container(
//           margin: EdgeInsets.only(left: 10 , top: 5),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//             Text("data" , 
//             style: TextStyle(color: Colors.white , fontSize: 13),
//             ) ,

//           ],),
//         )
//       ],)
      
//     );
//   }
// }