import 'package:dbproject/database.dart';
import 'package:dbproject/widgets/accomplishments.dart';
import 'package:flutter/material.dart';

class NotificatioCard extends StatefulWidget {
  const NotificatioCard(this.notiftype , this.doer) ;
  final notiftype ;
  final doer ;
  

  @override
  _NotificatioCardState createState() => _NotificatioCardState();
}

class _NotificatioCardState extends State<NotificatioCard> {

  String notiftext = '';
  void makenotiftext(){
    print("type of notif");
    var f = widget.notiftype ;
    print("$f");
    var d = widget.doer ;
    if (widget.notiftype == 1 ){
      notiftext = "happy birthday to : $d" ;
    }else if (widget.notiftype == 2 ){
      notiftext = "your profile seen by : $d";
    }else if (widget.notiftype == 3 ){
      notiftext = "$d commented on your post";
    }else if (widget.notiftype == 4 ){
      notiftext = "$d liked your post";
    }else if (widget.notiftype == 5 ){
      notiftext = "$d like your comment / commented on your comment";
    }else if (widget.notiftype == 6 ){
      notiftext = "$d emdorsed your skill";
    }else if (widget.notiftype == 7 ){
      notiftext = "job position changed - congratulate to :$d ";
    }


  }
  @override
  void initState() {
    makenotiftext();
    super.initState();
  }



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
          child: Text(notiftext, 
          style: TextStyle(color: Colors.white , fontSize: 13),
          ),
        ),
        TextButton(onPressed: (){}, child: Text("..."))

      ],),
      
    );
  }
}

// class NotificationCard extends StatelessWidget {
//   const NotificationCard(this.notiftype);
//   final notiftype ;

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
//         TextButton(onPressed: (){}, child: Text("..."))

//       ],),
      
//     );
//   }
// }

class NotifList extends StatefulWidget {
  const NotifList(this.db , this.myid);
  final myid ;
  final AppDatabase db ;

  @override
  _NotifListState createState() => _NotifListState();
}

class _NotifListState extends State<NotifList> {
  List<NotificatioCard> list =[];

    void addNotificatioCard(int nt , String d){
      list.add(new NotificatioCard(nt, d));
    }

    void getAllNotif()async{
      list.clear();
      widget.db.notificationnDao.showNotif(widget.myid).then((value) => setState((){
        if (value!= null ){
          for(int i = 0 ; i < value.length ; i++){
            // var nt = value[i]?.networkId ;
            var typ = value[i]?.notificationType ;
            print("we are in getAllNotif and type is :");
            print("$typ");
            var sender = value[i]?.sender ;
            print("notif sender : $sender");
            var reciever = value[i]?.receiver ;
            print("notif reciever : $reciever");
            widget.db.userDao.findUserNameByUserId(sender!).then((val) => setState((){
              if(val != null){
                addNotificatioCard(typ!, val.userName);
                print("after adding notif card");
              }
            }));

            // widget.db.netwokDao.findNetworkByoneIdNetworkid(nt!, widget.myid).then((val) => setState((){
            //   if(val != null){
            //     var vuserid  = val.userId;
            //     var vuserreqid = val.userReqId ;
            //     if( vuserid != widget.myid ){
            //       widget.db.userDao.findUserNameByUserId(vuserid!).then((v) => setState((){
            //         var un = v?.userName ;
            //         addNotificatioCard(typ!, un!);
            //       }));
                  
            //     }else{
            //       widget.db.userDao.findUserNameByUserId(vuserreqid!).then((vl) => setState((){
            //         var un = vl?.userName ;
            //         addNotificatioCard(typ!, un!);
            //       }));
                  
            //     }
            //   }
            // }));
            
          }
        }
      }));

    }
    @override
    void initState() {
    getAllNotif();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 20),
      height: 400,
      width: MediaQuery.of(context).size.width*0.9,
      color: Colors.black87,
      child:Column(
        children: [
          Container(
            margin: EdgeInsets.only(left: 10 , top: 4),
            height: 30 ,
            child : Align(
              alignment: Alignment.centerLeft,
              child: Text("NOTIFICATION" , style: TextStyle(color: Colors.white , fontSize: 15 ),) ,)
           
            
            ),
          
          Container(
        height: 350 ,    
        child:ListView.builder(
                    itemCount: list.length,
                    itemBuilder: (_, index) => NotificatioCard(list[index].notiftype, list[index].doer)
                    ), )
          
        ],
      ) 

      
    );
  }
}

// class NotifList extends StatelessWidget {
//   const NotifList(this.db , this.myid);
//   final myid ;
//   final AppDatabase db ;

//   @override
//   Widget build(BuildContext context) {

//     List<NotificatioCard> list =[];

//     void addNotificatioCard(int nt , String d){
//       list.add(new NotificatioCard(nt, d));
//     }

//   void allnotif()async{}

//     return Container(
//       margin: EdgeInsets.only(top: 20),
//       height: 400,
//       width: MediaQuery.of(context).size.width*0.9,
//       color: Colors.black87,
//       child:Column(
//         children: [
//           Container(
//             margin: EdgeInsets.only(left: 10 , top: 4),
//             height: 30 ,
//             child : Align(
//               alignment: Alignment.centerLeft,
//               child: Text("NOTIFICATION" , style: TextStyle(color: Colors.white , fontSize: 15 ),) ,)
           
            
//             ),
          
//           Container(
//         height: 350 ,    
//         child:ListView.builder(
//                     itemCount: list.length,
//                     itemBuilder: (_, index) => NotificatioCard(list[index].notiftype, list[index].doer)
//                     ), )
          
//         ],
//       ) 

      
//     );
//   }
// }