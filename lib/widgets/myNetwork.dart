import 'package:dbproject/widgets/accomplishments.dart';
import 'package:flutter/material.dart';

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
  const PeopleYouMayKnowList({Key? key}) : super(key: key);

  @override
  _PeopleYouMayKnowListState createState() => _PeopleYouMayKnowListState();
}

class _PeopleYouMayKnowListState extends State<PeopleYouMayKnowList> {
  List<InvitationCard> list = [];
  // addSkillCard() {
  //   list.add(new InvitationCard());
  //   setState(() {});
  // }

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
            Flexible(
                child: ListView.builder(
                    itemCount: list.length,
                    itemBuilder: (_, index) => list[index])),
            PeopleCard(),
          ],
        ));
  }
}

class PeopleCard extends StatelessWidget {
  const PeopleCard({Key? key}) : super(key: key);

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
                Text(
                  "User Name",
                  style: TextStyle(color: Colors.white),
                ),
                TextButton(onPressed: () {}, child: Text("Connect")),
              ],
            )));
  }
}
