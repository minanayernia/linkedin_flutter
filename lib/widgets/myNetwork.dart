import 'package:flutter/material.dart';
import 'package:dbproject/models/Network.dart';

import '../database.dart';

class InvitationList extends StatefulWidget {
  const InvitationList(this.user , this.db);
  final AppDatabase db ;
  final user ;
  @override
  _InvitationListState createState() => _InvitationListState();
}

class _InvitationListState extends State<InvitationList> {
  List<InvitationCard> list = [];
  addInvitationCard(var username , int userid , int myid) {
    list.add(new InvitationCard(username , userid , myid , widget.db));
    setState(() {});
  }
  void allInvitations()async{
    print("we are in all invitations");
    print(list);
    widget.db.netwokDao.invitations(widget.user).then((value) => setState((){
      for(int i = 0 ; i < value.length ; i++){
        if(value[i] != null){
          var userid = value[i]?.userReqId; 
          var myid = value[i]?.userId;
          if( userid != null){
            widget.db.userDao.findUserNameByUserId(userid).then((val) => setState((){
              var name = val?.userName ;
             
              print("who send invitation");
              print(name);
              addInvitationCard(name , userid , myid!) ;
            }));
          }
        }
        print("waht about now?");
        print(list);
      }
    }));
  }
  @override
  void initState() {
    allInvitations();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(top: 20),
        height: 200,
        width: MediaQuery.of(context).size.width * 0.9,
        color: Colors.black87,
        child: Column(
          children: [
            Container(
              color: Colors.redAccent,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: 30,
                    margin: EdgeInsets.only(left: 10, top: 7),
                    child: Text(
                      "INVITATIONS",
                      style: TextStyle(color: Colors.white, fontSize: 15),
                    ),
                  ),
                ],
              ),
            ),
            Flexible(
                child: ListView.builder(
                    itemCount: list.length,
                    itemBuilder: (_, index) => InvitationCard(list[index].username , list[index].userid , list[index].myid , widget.db))),
            
          ],
        ));
  }
}
class InvitationCard extends StatefulWidget {
  const InvitationCard(this.username ,this.userid , this.myid, this.db);
  final username ;
  final userid ;
  final myid ;
  final AppDatabase db ;

  @override
  _InvitationCardState createState() => _InvitationCardState();
}

class _InvitationCardState extends State<InvitationCard> {

  void acceptinvitation()async{
    print("we are in acceot invitation");
    widget.db.netwokDao.findNetwork(widget.myid, widget.userid).then((value) => setState((){
      if(value != null){
        var netid = value.networkId ;
        print("netid is : $netid");
        widget.db.netwokDao.acceptInvitation(netid!);
      }else{
        print("value of finding network is null");
      }
    }));
    
  }
  void deleteInvitation()async{
    await widget.db.netwokDao.deletNetwork(widget.userid, widget.myid);
    print("network deleted");
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: MediaQuery.of(context).size.width * 0.88,
      color: Colors.redAccent,
      margin: EdgeInsets.only(top: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            margin: EdgeInsets.only(left: 10),
            child: Text(widget.username,
              style: TextStyle(color: Colors.white, fontSize: 13),
            ),
          ),
          Row(
            children: [
              TextButton(onPressed: () {
                return acceptinvitation();
              }, child: Text("Accept")),
              TextButton(onPressed: () {
                return deleteInvitation();
              }, child: Text("Ignore"))
            ],
          )
        ],
      ),
    );
  }
}
// class InvitationCard extends StatelessWidget {
//   const InvitationCard(this.username , this.id);
//   final username ;
//   final id ;

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: 100,
//       width: MediaQuery.of(context).size.width * 0.88,
//       color: Colors.redAccent,
//       margin: EdgeInsets.only(top: 10),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Container(
//             margin: EdgeInsets.only(left: 10),
//             child: Text(username,
//               style: TextStyle(color: Colors.white, fontSize: 13),
//             ),
//           ),
//           Row(
//             children: [
//               TextButton(onPressed: () {}, child: Text("Accept")),
//               TextButton(onPressed: () {}, child: Text("Ignore"))
//             ],
//           )
//         ],
//       ),
//     );
//   }
// }

class PeopleYouMayKnowList extends StatefulWidget {
  const PeopleYouMayKnowList(this.db , this.user);
  final AppDatabase db ;
  final int? user  ;

  @override
  _PeopleYouMayKnowListState createState() => _PeopleYouMayKnowListState();
}

class _PeopleYouMayKnowListState extends State<PeopleYouMayKnowList> {
  List<PeopleCard> list = [];
  addPeopleCard(var id , var username) {
    list.add(new PeopleCard(id , username));
    setState(() {});
  }



  void getPeopleYouMayKnow() async{

    var a = widget.user ;
    if(a != null){
      widget.db.netwokDao.allNetwork(a).then((value) => setState((){
        print("we are in your network");
          if(value != null){
            for(int i = 0 ; i < value.length ; i++){
              
              var userid = value[i]?.userId ;
              print("userid is: $userid");
              
              var user1  = value[i]?.userReqId;
              print("user1 is: $user1");
              if(userid != widget.user){
              widget.db.netwokDao.allNetwork(userid!).then((val) => setState((){
                      print(val);
                      print("we r in userid network");
                      if(val != null){
                        for(int j = 0 ; j < val.length ; j++){
                            print("j = $j");
                            var ui = val[j]?.userId ;
                            print("ui is : $ui") ;

                            var ur = val[j]?.userReqId ;
                            print("ur is : $ur") ;

                            if(ui != user1 && ur == userid){
                            widget.db.userDao.findUserNameByUserId(ui!).then((v) => setState((){
                              print("finding username1 :");
                                  if (v != null){
                                      addPeopleCard(ui , v.userName) ;
                                  }
                            }));
                            }
                            else if(ur != user1 && ui == userid){
                              widget.db.userDao.findUserNameByUserId(ur!).then((v) => setState((){
                                print("finding username2 :");
                                  if (v != null){
                                      addPeopleCard(ur , v.userName) ;
                                  }
                            }));

                            }
                        }
                      }

              }));
              }
              else{
                print("we r in else");
                  widget.db.netwokDao.allNetwork(user1!).then((vl) => setState((){
                    print("we r in user1 network");
                        if(vl != null){
                          for(int k = 0 ; k < vl.length ; k++){
                            var ui = vl[k]?.userId ;
                            print("ui is : $ui") ;
                            var ur = vl[k]?.userReqId ;
                            print("ur is : $ur") ;

                            if(ui != userid && ur == user1){
                            widget.db.userDao.findUserNameByUserId(ui!).then((v) => setState((){
                              print("finding username1 :");
                                  if (v != null){
                                      addPeopleCard(ui , v.userName) ;
                                      
                                  }
                            }));
                            }
                            else if(ur != userid && ui == user1){
                              widget.db.userDao.findUserNameByUserId(ur!).then((v) => setState((){
                                print("finding username2 :");
                                  if (v != null){
                                      addPeopleCard(ur , v.userName) ;
                                  }
                            }));

                            }
                          }
                        }
                  }));
              }
            }
          }

      }));



      

    }
    


  }

  void clearList()async{
    print("clear is called");
    for(int k = 0 ; k < list.length ; k++){
          print("im in loop");
          var b = widget.user;
          widget.db.netwokDao.findNetwork(b! , list[k].id).then((value) => setState((){
                if(value != null){
                  print("k is $k");
                  list.removeAt(k);
                }

          }));
      }


  }
  @override
  void initState() {
    getPeopleYouMayKnow();
    clearList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(top: 20),
        height: 200,
        width: MediaQuery.of(context).size.width * 0.9,
        color: Colors.black87,
        child: Column(
          children: [
            Container(
              color: Colors.redAccent,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: 30,
                    margin: EdgeInsets.only(left: 10, top: 7),
                    child: Text(
                      "PEOPLE YOU MAY KNOW",
                      style: TextStyle(color: Colors.white, fontSize: 15),
                    ),
                  ),
                ],
              ),
            ),
            Flexible(child:
       ListView.builder(
        itemCount: list.length,
        itemBuilder: (_,index) { 
          return PeopleCard(list[index].id.toString(), list[index].username);
          ;}))
          ],
        ));
  }
}


class PeopleCard extends StatefulWidget {
 const PeopleCard(this.id , this.username);
  final id ;
  final username ;

  @override
  _PeopleCardState createState() => _PeopleCardState();
}

class _PeopleCardState extends State<PeopleCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10),
        height: 50,
        width: MediaQuery.of(context).size.width * 0.88,
        color: Colors.redAccent,
        child: Container(
            margin: EdgeInsets.only(left: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(children: [

                  Text(
                  widget.id,
                  style: TextStyle(color: Colors.white),
                ),

                  Text(
                  "  " + widget.username,
                  style: TextStyle(color: Colors.white),
                ),

                ],),
                
                TextButton(onPressed: () {}, child: Text("Connect")),
              ],
            ))
      
    );
  }
}

// class PeopleCard extends StatelessWidget {
//   const PeopleCard(this.id , this.username);
//   final id ;
//   final username ;

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//         margin: EdgeInsets.only(top: 10),
//         height: 50,
//         width: MediaQuery.of(context).size.width * 0.88,
//         color: Colors.redAccent,
//         child: Container(
//             margin: EdgeInsets.only(left: 5),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Text(
//                   widget.uername,
//                   style: TextStyle(color: Colors.white),
//                 ),
//                 TextButton(onPressed: () {}, child: Text("Connect")),
//               ],
//             ))
//             );
//   }
// }
