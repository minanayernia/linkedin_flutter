import 'package:dbproject/widgets/editintro.dart';
import 'package:flutter/material.dart';

import '../database.dart';

var temp ;
var firstname ;
var lasttname ;
var about ;
var birthdate ;
var location ;

TextEditingController firstNameController = TextEditingController();
TextEditingController lastNameController = TextEditingController();
TextEditingController aboutController = TextEditingController();
TextEditingController birthDateController = TextEditingController();
TextEditingController locationController = TextEditingController();
class EditIntrCard extends StatefulWidget {
  
  const EditIntrCard( { required this.db ,required this.user}) ;
  final AppDatabase db ;
  final int? user ; 

  @override
  _EditIntrCardState createState() => _EditIntrCardState();
}

class _EditIntrCardState extends State<EditIntrCard> {

  void getProfile() async{
    var a = widget.user ;
    if (a != null){
      print("i reached here");
        widget.db.userProfileDao.findProfileByUserId(a).then((val) => setState(() {
        print('val is : $val');
        if (val != null){
          firstname= val.FirstName;
          lasttname = val.LastName ;
          about = val.About;
          location = val.location;
        } else {
          firstname= "not_filled";
          lasttname = "not_filled";
          about = "not_filled";
          location = "not_filled";
        }
          
        }));
    } else {
      print("profile not found");
    }
  }
  void editIntro()async{
    var a = widget.user;
    if (a != null){
      widget.db.userProfileDao.editAllProfile(a, firstNameController.value.text, lastNameController.value.text, aboutController.value.text , locationController.value.text).then((val) => setState((){
        if (val != null){
          firstname= val.FirstName;
          lasttname = val.LastName ;
          about = val.About;
          location = val.location;
          }
      }));
    }
    
  }
  // void editIntro()async {
  //   var a = widget.user;
  //   if (a != null){
  //     print("i reached here");
  //       widget.db.userProfileDao.editAllProfile(a, firstname, lastname, about, additionalInfo).then((val) => setState(() {
  //       print('val is : $val');
  //       if (val != null){
  //         firstname= val.FirstName;
  //         lasttname = val.LastName ;
  //         about = val.About;
  //         location = val.location;
  // }
  @override
  void initState() {
    getProfile();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 20),
      height: MediaQuery.of(context).size.height*0.65,
      width: MediaQuery.of(context).size.width * 0.9,
      color: Colors.black87,
      child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [


        Container(
          color: Colors.redAccent,
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(left: 10),
                alignment: Alignment.centerLeft,
                child: Text("FirstName" , style: TextStyle(color: Colors.white),),),
              TextField(
            controller: firstNameController,
            style: TextStyle(color: Colors.white),
          decoration: InputDecoration(
            fillColor: Colors.white,
          border: OutlineInputBorder(),
          hintText: firstname,
          hintStyle: TextStyle(color: Colors.white)
  ),
          //readOnly: true,
          /*onTap: () async{
            DateTime pickedDate = await showDatePicker(
                      context: context, initialDate: DateTime.now(),
                      firstDate: DateTime(2000), //DateTime.now() - not to allow to choose before today.
                      lastDate: DateTime(2101)
                  );

          },*/
          
        ) ,
            ],
          )
        ),
        
        Container(
          color: Colors.redAccent,
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(left: 10),
                alignment: Alignment.centerLeft,
                child: Text("LastName" , style: TextStyle(color: Colors.white),),),
              TextField(
            controller: lastNameController,
            style: TextStyle(color: Colors.white),
          decoration: InputDecoration(
            fillColor: Colors.white,
          border: OutlineInputBorder(),
          hintText:lasttname,
          hintStyle: TextStyle(color: Colors.white)
  ),
          //readOnly: true,
          /*onTap: () async{
            DateTime pickedDate = await showDatePicker(
                      context: context, initialDate: DateTime.now(),
                      firstDate: DateTime(2000), //DateTime.now() - not to allow to choose before today.
                      lastDate: DateTime(2101)
                  );

          },*/
          
        ) ,
            ],
          )
        ),


         Container(
          color: Colors.redAccent,
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(left: 10),
                alignment: Alignment.centerLeft,
                child: Text("About" , style: TextStyle(color: Colors.white),),),
              TextField(
            controller: aboutController,
            style: TextStyle(color: Colors.white),
          decoration: InputDecoration(
            fillColor: Colors.white,
          border: OutlineInputBorder(),
          hintText: about,
          hintStyle: TextStyle(color: Colors.white)
  ),
          //readOnly: true,
          /*onTap: () async{
            DateTime pickedDate = await showDatePicker(
                      context: context, initialDate: DateTime.now(),
                      firstDate: DateTime(2000), //DateTime.now() - not to allow to choose before today.
                      lastDate: DateTime(2101)
                  );

          },*/
          
        ) ,
            ],
          )
        ),
        
        Container(
          color: Colors.redAccent,
          child: Column(
            children: [
              // Container(
              //   margin: EdgeInsets.only(left: 10),
              //   alignment: Alignment.centerLeft,
              //   child: Text("BirthDate" , style: TextStyle(color: Colors.white),),),
  //             TextField(
  //           controller: birthDateController,
  //           style: TextStyle(color: Colors.white),
  //         decoration: InputDecoration(
  //           fillColor: Colors.white,
  //         border: OutlineInputBorder(),
  //         hintText: "Enter Date",
  //         suffixIcon: IconButton(
  //           onPressed: (){},
  //        // onPressed: () => _controller.clear(),
  //         icon: Icon(Icons.calendar_today),
  //   ),
  //         hintStyle: TextStyle(color: Colors.white)
  // ),
  //         //readOnly: true,
  //         /*onTap: () async{
  //           DateTime pickedDate = await showDatePicker(
  //                     context: context, initialDate: DateTime.now(),
  //                     firstDate: DateTime(2000), //DateTime.now() - not to allow to choose before today.
  //                     lastDate: DateTime(2101)
  //                 );

  //         },*/
          
  //       ) ,
            ],
          )
        ),


        Container(
          color: Colors.redAccent,
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(left: 10),
                alignment: Alignment.centerLeft,
                child: Text("Location" , style: TextStyle(color: Colors.white),),),
              TextField(
            controller: locationController,
            style: TextStyle(color: Colors.white),
          decoration: InputDecoration(
            fillColor: Colors.white,
          border: OutlineInputBorder(),
          hintText: location,
          hintStyle: TextStyle(color: Colors.white)
  ),
          //readOnly: true,
          /*onTap: () async{
            DateTime pickedDate = await showDatePicker(
                      context: context, initialDate: DateTime.now(),
                      firstDate: DateTime(2000), //DateTime.now() - not to allow to choose before today.
                      lastDate: DateTime(2101)
                  );

          },*/
          
        ) ,
            ],
          )
        ),
        Container(
          alignment: Alignment.centerRight,
          child:TextButton(onPressed:()=>editIntro() , child: Text("Save" , style: TextStyle(color: Colors.white),))
        
         ,)
        


        ],
      ),

      
    );
  }
}


// class EditIntrCard extends StatelessWidget {
//   final AppDatabase db ;
//   //final user ;
//   final int? user ; 
//   const EditIntrCard( this.db , this.user) ;

//   void getProfile() async {
//     var a = user ;
//     if (a != null){
//       print("i reached here");
//         db.userProfileDao.findProfileByUserId(a).then((val) => setState(() {
//         print('val is : $val');
//         if (val != null){
//           firstname= val.FirstName;
//           lasttname = val.LastName ;
//           about = val.About;
//           location = val.location;
//         } else {
//           firstname= "not_filled";
//           lasttname = "not_filled";
//           about = "not_filled";
//           location = "not_filled";
//         }
          
//         }));
//     } else {
//       print("profile not found");
//     }


//   }
// void edit()async{

//   // getIntro();

//   print("oooooooooooooooooooooooooooo") ;
//   final res = await db.userProfileDao.editAbout(temp, "gkgmdlg") ;


//   about = res?.About ;
//   print("RRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRR") ;
//   print(about) ;


// }
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: EdgeInsets.only(top: 20),
//       height: MediaQuery.of(context).size.height*0.55,
//       width: MediaQuery.of(context).size.width * 0.9,
//       color: Colors.black87,
//       child: Column(
//       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//       children: [


//         Container(
//           margin: EdgeInsets.only(left: 10),
//           height: 40,
//         alignment: Alignment.centerLeft,
//         child: Text("EDIT INTRO" , 
//         style: TextStyle(color: Colors.white , fontSize: 20),),
//         ),

//         Container(
//           color: Colors.redAccent,
//           child:TextField(
          
//           style: TextStyle(color: Colors.white),
//           decoration: InputDecoration(
//             fillColor: Colors.white,
//           border: OutlineInputBorder(),
//           hintText: firstname , 
//           hintStyle: TextStyle(color: Colors.white)
//   ),
          
//         ) ,),
        
//         Container(
//           color: Colors.redAccent,
//           child:TextField(
//           decoration: InputDecoration(
//           border: OutlineInputBorder(),
//           hintText: 'LastName',
//           hintStyle: TextStyle(color: Colors.white)
//   ),
          
//         ) ,),


//          Container(
//           color: Colors.redAccent,
//           child:TextField(
//           decoration: InputDecoration(
//           border: OutlineInputBorder(),
//           hintText: about,
//           hintStyle: TextStyle(color: Colors.white)
//   ),
          
//         ) ,),
        
//         Container(
//           color: Colors.redAccent,
//           child:TextField(
//           decoration: InputDecoration(
//           border: OutlineInputBorder(),
//           hintText: "Enter Date",
//           suffixIcon: IconButton(
//             onPressed: (){},
//          // onPressed: () => _controller.clear(),
//           icon: Icon(Icons.calendar_today),
//     ),
//           hintStyle: TextStyle(color: Colors.white)
//   ),
//           //readOnly: true,
//           /*onTap: () async{
//             DateTime pickedDate = await showDatePicker(
//                       context: context, initialDate: DateTime.now(),
//                       firstDate: DateTime(2000), //DateTime.now() - not to allow to choose before today.
//                       lastDate: DateTime(2101)
//                   );

//           },*/
          
//         ) ,),


//         Container(
//           color: Colors.redAccent,
//           child:TextField(
//           decoration: InputDecoration(
//           border: OutlineInputBorder(),
//           hintText: 'Location',
//           hintStyle: TextStyle(color: Colors.white)
//   ),
          
//         ) ,),
//         Container(
//           alignment: Alignment.centerRight,
//           child:TextButton(onPressed: edit , child: Text("Save" , style: TextStyle(color: Colors.white),))
        
//          ,)
        


//         ],
//       ),

      
//     );
//   }
// }