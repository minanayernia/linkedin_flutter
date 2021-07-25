

import 'package:dbproject/models/Featured.dart';
import 'package:flutter/material.dart';
import 'package:dbproject/widgets/postCard.dart';
import '../database.dart';
import 'postCard.dart';
import 'package:dbproject/models/Comment.dart';
import 'package:dbproject/models/CommentLike.dart';
import 'package:dbproject/models/Featured.dart';
import 'package:dbproject/models/Like.dart';
import 'package:dbproject/models/User.dart';
import 'package:dbproject/models/Notification.dart';
import 'package:dbproject/models/post.dart';

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

 void refresh() {
    setState(() {});
  }

addSkillCard(var id , var text){
  
    if(text != "" && checkCopy == false){
  list.add(new FeaturedCard(id , text , widget.db));
  setState((){});
  }
}
addPostFeaturedCard(var caption , var id , int postId ){
  featuredPost.add(new FeaturePost(caption, id, postId, widget.db));
  setState((){});
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
          
          print(val);

          widget.db.featuredDao.allAdditionalInfo(profileId).then((value) => setState((){
             if (value != null){
               print("all of features!!!!!!!!!!!!!!!");print(value);
              for ( var f in value){
               if(f?.postId ==null){//textfeature
                addSkillCard(f?.featuredId, f?.featuredText);
               }else if(f?.postId != null){//postfeature
               var postid = f?.postId ;
                widget.db.postDao.findPostByPostId(postid!).then((po) => setState((){
                  var cap = po?.PostCaption ;
                addPostFeaturedCard(cap,widget.user, postid);
                }));
               }
                
              }
             }
          }));
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

      height: 400,
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
       Container(
         height: 300,
         width: MediaQuery.of(context).size.width*0.9,
         child: 
       Row(
         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
         children: [

        Container(
          height: 300,
          width: MediaQuery.of(context).size.width*0.43,
          child: 
       ListView.builder(
        itemCount: list.length,
        itemBuilder: (_,index) { 
          return FeaturedCard(list[index].id.toString(), list[index].text , widget.db);
          })),
    
       

       // post for features :
        Container(
          width: MediaQuery.of(context).size.width*0.43,
          child:
       ListView.builder(
        itemCount: featuredPost.length,
        itemBuilder: (_,index) { 
          return FeaturePost(featuredPost[index].caption, featuredPost[index].id, featuredPost[index].postId, widget.db);
          })),
      ],),) 
      
      
      

      ], 
      )

      
    );
  }
}


class FeaturePost extends StatefulWidget {
  const FeaturePost(this.caption, this.id, this.postId, this.db);
  final postId;
  final id;
  final caption;
  final AppDatabase db;

  @override
  _FeaturePostState createState() => _FeaturePostState();
}

class _FeaturePostState extends State<FeaturePost> {
    TextEditingController newCommentController = TextEditingController();
  TextEditingController toWhomCommentController = TextEditingController();
  TextEditingController likeCommentController = TextEditingController();
  void addtofeatured()async{
    widget.db.featuredDao.findFeatureByPostid(widget.postId).then((v) => setState(() {
      if(v == null){//the post is not featured untill now
        
    widget.db.postDao.findPostByPostId(widget.postId).then((value) => setState((){
      var userid = value?.userId ;
      widget.db.userProfileDao.findProfileByUserId(userid!).then((val) => setState(() {
        var profid = val?.ProfileId ;
        var featured = Featured( profileId: profid , postId: widget.postId);
        widget.db.featuredDao.insertFeatured(featured);
        print("post featured added successfully!");
      }));
    }));
      }
    }));

    
  }

  String username = '';
  
  void getUserName() async {
    widget.db.userDao.findUserNameByUserId(widget.id).then((value) => setState(() {
      print("entered the query");
      if (value != null) {
        username = value.userName;
        print("the username is : $username");
      }
    }));
  }
  String sharedname = '';
  void getSharedname()async{
    widget.db.postDao.findPostByPostId(widget.postId).then((value) => setState((){
      if(value != null){
        if(value.sharedPost != null){ //so this is a shred post and we shoulf find the username
          widget.db.postDao.findPostByPostId(value.sharedPost!).then((val) => setState(() {
            if(val != null){
              var shareduserid = val.userId ;
              widget.db.userDao.findUserNameByUserId(shareduserid).then((v) => setState(() {
                if(v!= null){
                  sharedname = v.userName ;

                  
                }
              }));
            }
          }));
        }else{//this is not a shared post 
          sharedname = " " ;
          print("shared post is nulllllllll");
        }
      }
    }));
  }

  var likeNumbers;
  List<int?> likelist = [];

  void countLike(int postId) async {
    likeNumbers = await widget.db.likeDao.likeNumbers(postId);
    widget.db.likeDao.likelist(postId).then((value) => setState(() {
          if (value != null) {
            int count = 0;
            for (int i = 0; i < value.length; i++) {
              // likeNumbers ++ ;
              likelist.add(value[i]?.userId);
              // print()
              print(likelist[i]);
            }
          }
        }));
  }

  void addLike(int postId, int userId) async {
    print("this liked post id : $postId");
    print("this liker userId :$userId");
    var like = Like(userId: userId, PostId: postId);
    widget.db.likeDao.findLikeIdByUseridPostid(userId, postId).then((value) =>
        setState(() {
          if (value != null) {
            print("this is user id that we want:");
            print(userId);
            print("value is not null");
            print(value.LikeId);
            print(userId);
          }

          if (value == null) {
            print(userId);
            print("value is nulllllllllllllll");
            print(value);
            widget.db.likeDao.insertLike(like).then((val) => setState(() {
                  print("inside liking the post!");
                  likelist = [];
                  countLike(postId);
          //adding notification
          widget.db.postDao.findPostByPostId(postId).then((v) => setState(() {
          if (v != null) {
            print("start of sending notif by finding the reciever");
            var receiver = v.userId;
            if( receiver != userId){
              print("reciever is : $receiver");
            print("myid is : $userId");
            // print("network of notification founded");               
            int n = 4;
            var notif = Notificationn(
            post: postId,
            sender: userId,       
            notificationType: n,
            receiver: receiver);
            print("before adding notif like");
            widget.db.notificationnDao.insertNotif(notif);
            print("notif like added successfully!!!!");
            }
            
                  }
        }));

    ///end of adding notification

                  
                }));
          }
        }));
  }

  var commentIds = [];
  List<String?> commentsTexts = [];
  List<int?> commentUserIds = [];
  List<String?> commentsUserNames = [];
  List<int?> commentrEPLY = [];
  List<int> temp = [];

  void addComment(int userId, int postId, String commentText, String replyto) async {
    var comment;
    if(replyto == ""){
      comment =Comment(  postId: postId, userId: userId, commentText: commentText);
      widget.db.commentDao.insertComment(comment).then((ci) => setState(() {
      //adding notification for comment on post
    widget.db.postDao.findPostByPostId(postId).then((v) => setState(() {
      if (v != null) {
        print("start of sending notif by finding the reciever");
        var receiver = v.userId;
        if(receiver != userId){
          print("reciever is : $receiver");
        print("myid is : $userId");
        print("network of notification founded");               
        var notif = Notificationn( post: postId , sender: userId , notificationType: 3 , receiver: receiver);
        widget.db.notificationnDao.insertNotif(notif);
        print("notif added successfully!!!!");
        }
        
              }
    }));

    ///end of adding notification


    }));


    }else{
    comment =Comment( ReplyCommentId: int.parse(replyto) , postId: postId, userId: userId, commentText: commentText);
    widget.db.commentDao.insertComment(comment).then((ci) => setState(() {
      var comid = ci ;
       //adding notification if it is comment reply
      if(replyto!=""){
        widget.db.commentDao.findCommentBycommentId(int.parse(replyto)).then((repid) => setState(() {
          if(repid!= null){
            var receiver = repid.userId;
            var notif = Notificationn(notificationType: 5, receiver: receiver, sender: userId , comment:comid );
            widget.db.notificationnDao.insertNotif(notif);
            print("notif comment reply added ");
          }
          
        }));
      }//end of notif type 5
      //adding notification for comment on post
    widget.db.postDao.findPostByPostId(postId).then((v) => setState(() {
      if (v != null) {
        print("start of sending notif by finding the reciever");
        var receiver = v.userId;
        if(receiver != userId){
          print("reciever is : $receiver");
        print("myid is : $userId");
        print("network of notification founded");               
        var notif = Notificationn( post: postId , sender: userId , notificationType: 3 , receiver: receiver);
        widget.db.notificationnDao.insertNotif(notif);
        print("notif added successfully!!!!");
        }
        
              }
    }));

    ///end of adding notification


    }));
    }

    
    print("controller of replyto :");
    print(replyto.toString());
    //for reply
    // if(replyto != null){
    //   widget.db.commentDao.updateCommentForReply(int.parse(replyto));
    // }

    print("after inserting comment");
    commentIds = [];
    commentsTexts = [];
    commentUserIds = [];
    commentrEPLY = [];
    allComments(postId);
    newCommentController.text = "";
  }



  List<int> commentlikes = [];
  void allComments(int postId) async {
    commentlikes = [];
    commentsTexts = [];
    commentsUserNames = [];
    commentIds = [];

    widget.db.commentDao.findAllComment(postId).then((value) => setState(() {
          if (value != null) {
            for (int i = 0; i < value.length; i++) {
              temp.add(0);
              var userid = value[i].userId;
              if (userid != null) {
                widget.db.userDao.findUserNameByUserId(userid).then((val) => setState(() {
                  commentsUserNames.add(val?.userName);
                  print("username is adding to commentusernamelist");
                  }));
              }
              //adding commentlikes ;
              var com = value[i].commentId;
              if (com != null) {
                widget.db.commentLikeDao.commentLikes(com).then((value) => setState(() {
                          int count = 0;
                          for (int i = 0; i < value.length; i++) {
                            count++;
                          }
                          commentlikes.add(count);
                        }));
              }

              print(value[i].commentId);
              commentIds.add(value[i].commentId);
              commentUserIds.add(value[i].userId);
              commentrEPLY.add(value[i].ReplyCommentId);
              if (value[i] != null) {
                commentsTexts.add(value[i].commentText);
              }

              print(commentIds);
            }
          }
        }));
  }

  void likeComment(int commentId, int userId) async {
    var commentLike = CommentLike(userId: userId, commentId: commentId);
    widget.db.commentLikeDao.findCommentLikeBYUseridCommentId(userId, commentId).then((value) => setState(() {
              if (value == null) {
                print("this isnt found");
                widget.db.commentLikeDao.insertCommentLike(commentLike);
            //adding notification
          widget.db.commentDao.findCommentBycommentId(commentId).then((val) => setState((){
            if(val != null){

              var reciever = val.userId ;
              // var compost = val.commentText ;
              var notif = Notificationn(notificationType: 5, receiver: reciever, sender: userId , comment: commentId);
              widget.db.notificationnDao.insertNotif(notif);
              print("commentid in lkecomment: $commentId");
              print("notif comment like added successfully!!!!");

            }
          }));

        //     widget.db.commentLikeDao.findCommentLikeBYUseridCommentId(userId, commentId).then((v) => setState(() {
        //       if (v != null) {
        //     print("start of sending notif by finding the reciever");
        //     var receiver = v.userId;
        //     if( receiver != userId){
        //       print("reciever is : $receiver");
        //     print("myid is : $userId");
        //     print("network of notification founded");               
        //     int n = 5;
        //     var notif = Notificationn(
        //       comment: commentId,
        //     sender: userId,       
        //     notificationType: n,
        //     receiver: receiver);
        //     widget.db.notificationnDao.insertNotif(notif);
        //     print("notif added successfully!!!!");
        //     }
            
        //           }
        // }));
        //end of adding notif

                print("after inserting commentlike ");
              } else {
                print("you have liked this comment before!");
              }
            }));
  }

  void deletePostFeature(){
    widget.db.featuredDao.deletePostFeature(widget.postId);
    print("post feature deleted");
  }

  @override
  void initState() {
    print("we are in init");
    print(widget.id);
    
    getUserName();
    getSharedname();
    print("hey what is your sharedname : $sharedname");
    countLike(widget.postId);
    allComments(widget.postId);
    super.initState();
  }

  @override
  void setState(fn) {
    // countLike(widget.postId);
    super.setState(fn);
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 1.2,
      width: MediaQuery.of(context).size.width * 0.86,
      color: Colors.redAccent,
      margin: EdgeInsets.only(top: 20, bottom: 20),
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            height: 30,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  margin: EdgeInsets.only(left: 15),
                  child: Text(
                    username,
                    style: TextStyle(color: Colors.white, fontSize: 13),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(bottom:4),
                  child:Text("Post shared from :  " + sharedname , style: TextStyle(color: Colors.white),),
                  ),
                TextButton(onPressed: () {
                  deletePostFeature();
                }, child: Text("delete from featured"))
              ],
            ),
          ),
          

          Container(
            height: MediaQuery.of(context).size.height * 0.35,
            width: MediaQuery.of(context).size.width * 0.84,
            color: Colors.white12,
          ),

          Container(
            height: MediaQuery.of(context).size.height * 0.1,
            width: MediaQuery.of(context).size.width * 0.84,
            color: Colors.redAccent[100],
            child: Container(
              padding: EdgeInsets.only(left: 10, top: 5),
              child: Text(
                widget.caption,
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),

          Row(
            children: [
              Container(
                  child: TextButton(
                      onPressed: () {
                        return addLike(widget.postId, widget.id);
                      },
                      child: Text(
                        "Likes",
                        style: TextStyle(color: Colors.white, fontSize: 13),
                      ))),
              Text(
                likelist.length.toString(),
                style: TextStyle(color: Colors.white),
              ),
              Container(
                margin: EdgeInsets.only(left: 5),
                child: TextButton(
                    onPressed: () {},
                    child: Text(
                      "Comments",
                      style: TextStyle(color: Colors.white, fontSize: 13),
                    )),
              ),
              Text(
                commentIds.length.toString(),
                style: TextStyle(color: Colors.white),
              ),
            ],
          ),

          // NewCommentCard(),

          //start new comment
          Column(
            children: [
              Container(
                margin: EdgeInsets.only(top: 20),
                height: 130,
                width: MediaQuery.of(context).size.width * 0.5,
                color: Colors.redAccent[100],
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      padding: EdgeInsets.only(left: 10),
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "User",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          width: 200,
                          child: TextField(
                            controller: toWhomCommentController,
                            textAlign: TextAlign.left,
                            style: TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                                fillColor: Colors.white,
                                border: OutlineInputBorder(),
                                hintText: 'To which comment ?',
                                hintStyle: TextStyle(color: Colors.white)),
                          ),
                        ),
                        Container(
                          width: 200,
                          child: TextField(
                            controller: newCommentController,
                            textAlign: TextAlign.left,
                            style: TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                                fillColor: Colors.white,
                                border: OutlineInputBorder(),
                                hintText: 'Add a comment...',
                                hintStyle: TextStyle(color: Colors.redAccent)),
                          ),
                        )
                      ],
                    ),
                    Container(
                      alignment: Alignment.bottomRight,
                      width: MediaQuery.of(context).size.width * 0.8,
                      child: TextButton(
                          onPressed: () {
                            return addComment(
                                widget.id,
                                widget.postId,
                                newCommentController.text,
                                toWhomCommentController.text);
                          },
                          child: Text("Send")),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 20),
                height: 130,
                width: MediaQuery.of(context).size.width * 0.3,
                color: Colors.white10,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      padding: EdgeInsets.only(left: 10),
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "User",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 300,
                          child: TextField(
                            controller: likeCommentController,
                            textAlign: TextAlign.left,
                            style: TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                                fillColor: Colors.white,
                                border: OutlineInputBorder(),
                                hintText: 'Which Comment ?',
                                hintStyle: TextStyle(color: Colors.white)),
                          ),
                        ),
                      ],
                    ),
                    Container(
                        alignment: Alignment.center,
                        width: MediaQuery.of(context).size.width * 0.8,
                        child: ButtonTheme(
                            height: 30,
                            minWidth: MediaQuery.of(context).size.width * 0.2,
                            buttonColor: Colors.white,
                            child: RaisedButton(
                                onPressed: () {
                                  likeComment(
                                      int.parse(likeCommentController.text),
                                      widget.id);
                                  allComments(widget.postId);
                                },
                                child: Text(
                                  "Like",
                                  style: TextStyle(color: Colors.redAccent),
                                )))),
                  ],
                ),
              ),
            ],
          ),

          //End new comment

          Flexible(
              child: ListView.builder(
                  itemCount: commentsTexts.length,
                  itemBuilder: (_, index) {
                    return Container(
                        margin: EdgeInsets.only(top: 20),
                        height: 50,
                        width: MediaQuery.of(context).size.width * 0.86,
                        color: Colors.redAccent[100],
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.86,
                          height: 30,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text("commentId :"),
                                  Text(commentIds.length > 0
                                      ? commentIds[index].toString()
                                      : '0'),
                                  Text("  "),
                                  Text(commentsUserNames.length > 0 ? commentsUserNames[index]! : '0'),
                                  Text("   likes:"),
                                  Text(commentlikes.length > 0
                                      ? commentlikes[index].toString()
                                      : '0'),
                                  Text("   Reply to:"),
                                  Text(commentrEPLY.length > 0
                                      ? commentrEPLY[index].toString()
                                      : ""),
                                ],
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width * 0.9,
                                // color: Colors.white,
                                child: Text(
                                  commentsTexts.length > 0
                                      ? commentsTexts[index]!
                                      : '0',
                                  style: TextStyle(color: Colors.black , fontWeight: FontWeight.bold),
                                ),
                              )
                            ],
                          ),
                        ));
                  }))

          // Row(children: [
          //   TextButton(onPressed: (){}, child: Text("Like")),
          //   TextButton(onPressed: (){}, child: Text("Comment")),
          //   TextButton(onPressed: (){}, child: Text("Share"))
          // ],)
        ],
      ),
      
    );
  }
}

List<FeaturedCard> list = [];
List<FeaturePost> featuredPost = [];
class FeaturedCard extends StatefulWidget {
  const FeaturedCard(this.id , this.text , this.db);
  final id ;
  final text ;
  final AppDatabase db ;

  @override
  _FeaturedCardState createState() => _FeaturedCardState();
}

class _FeaturedCardState extends State<FeaturedCard> {

  void deleteFeatured(){
    widget.db.featuredDao.deleteFeatureById(int.parse(widget.id));
    print("feature deleted successfully");
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
          return deleteFeatured();
        }, child: Text("delete")),

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
    list.add(new FeaturedCard(id , text , widget.db));
    setState((){});
    }
  }

  void addFeatureToDatabase(String featureText)async{
    // final checkCopyField = await widget.db.featuredDao.findFeaturedByText(featureText);
    var a = widget.user;
    // var profileId ;
    // var feature ;

        if(a != null){
          widget.db.userProfileDao.findProfileByUserId(a).then((value) => setState((){
        print("eeeeeeeeeeeeeeeeeeeeeeeeeeeeeee");
      if(value != null){
        var checkCopyField ;
          widget.db.featuredDao.findFeaturedByText(featureText , value.ProfileId!).then((v) => setState((){
            if (v != null ){
             print("find skill by name is not null");
             checkCopyField = v ;
             checkCopy = true ;

          }else{
        print("find skill by name is null");
        checkCopyField = null ;
        checkCopy = false ;
        if(featureText != "" && checkCopyField == null){
          var profileId ;
           var feature ;
            widget.db.userProfileDao.findProfileByUserId(a).then((val) => setState((){
            if (val != null) {
            profileId = val.ProfileId;
          print("this profileid in test card $profileId");
          feature = Featured(featuredText: featureText ,profileId: profileId);
          widget.db.featuredDao.insertFeatured(feature);
          }
      }
      
      ));
      addFeatureController.text = ''  ;
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
    if(featureText == ""){
      checkFeatureField = true ;
    }
    if(featureText != ""){
      checkFeatureField = false ;
    }


    });

    // if(featureText != "" && checkCopyField == null){
    // if (a != null){
    //   widget.db.userProfileDao.findProfileByUserId(a).then((val) => setState((){
    //     if (val != null) {
    //       profileId = val.ProfileId;
    //       print("this profileid in test card $profileId");
    //       feature = Featured(featuredText: featureText ,profileId: profileId);
    //       widget.db.featuredDao.insertFeatured(feature);
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
    //   addFeatureController.text = ''  ;
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
      var a = widget.user ; 
      if(a != null){
        widget.db.userProfileDao.findProfileByUserId(a).then((value) => setState((){
        print("eeeeeeeeeeeeeeeeeeeeeeeeeeeeeee");
      if(value != null){
        var checkFieldNumber ;
          widget.db.featuredDao.findFeaturedById(id , value.ProfileId!).then((v) => setState((){
            if (v != null ){
             print("find skill by name is not null");
             checkFieldNumber = v ;
             checkEditFieldNumber = false ;
             if(featureText != "" && checkFieldNumber != null){
          print("this is userid:");
      print(a);
      widget.db.featuredDao.editFeatured(featureText, id) ;
      widget.db.featuredDao.findFeaturedById(id , value.ProfileId!).then((val) => setState((){
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
    // final checkFieldNumber = await widget.db.featuredDao.findFeaturedById(id);

    // setState(() {
    //   if (checkFieldNumber == null){
    //     checkEditFieldNumber = true ;
    //   }
    //   if (checkFieldNumber != null){
    //     checkEditFieldNumber = false ;
    //   }
    // });
    setState(() {
      if(featureText == ""){
        checkEditFieldName = true ;
      }
      if(featureText != ""){
        checkEditFieldName = false ;
      }

    });
    // if(featureText != "" && checkFieldNumber != null){
    // var a = widget.user;
    // if (a != null){
    //   print("this is userid:");
    //   print(a);
    //   await widget.db.featuredDao.editFeatured(featureText, id) ;
    //   widget.db.featuredDao.findFeaturedById(id).then((val) => setState((){
    //     print("we are in editskilldatabase");
    //     print(val?.featuredText);
    //     if (val != null){
    //       print("skilltext is going to change");
    //       featureText = val.featuredText ;
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


class OtherFeaturePost extends StatefulWidget {
  const OtherFeaturePost(this.postId, this.id, this.caption, this.db, this.myid);
  final postId;
  final id;
  final caption;
  final AppDatabase db;
  final myid;

  @override
  _OtherFeaturePostState createState() => _OtherFeaturePostState();
}

class _OtherFeaturePostState extends State<OtherFeaturePost> {
    TextEditingController newCommentController = TextEditingController();
  TextEditingController toWhomCommentController = TextEditingController();
  TextEditingController likeCommentController = TextEditingController();

  String username = '';
  void getUserName() async {
    widget.db.postDao.findPostByPostId(widget.postId).then((val) => setState((){
      var userid = val?.userId ;
      widget.db.userDao.findUserNameByUserId(userid!).then((value) => setState(() {
        print("entered the query");
        if (value != null) {
        username = value.userName;
        print("the username is : $username");
    }
  }));
    }));

  
  }

  String sharedname = '';

  void getSharedname()async{
    var m = widget.postId;
    print("this is fuck : $m");
    widget.db.postDao.findPostByPostId(widget.postId).then((value) => setState((){
      if(value != null){
        print("bahara");
        if(value.sharedPost != null){ //so this is a shred post and we shoulf find the username
        print("jenaba");
          widget.db.postDao.findPostByPostId(value.sharedPost!).then((val) => setState(() {
            if(val != null){
              print("bahar jenaba");
              var shareduserid = val.userId ;
              widget.db.userDao.findUserNameByUserId(shareduserid).then((v) => setState(() {
                if(v!= null){
                  sharedname = v.userName ;
                  print("this shared name in otherpostcardd : $sharedname");
                }
              }));
            }
          }));
        }else{//this is not a shared post 
          sharedname = " " ;
          print("yohoooo");
        }
      }
    }));
  }


  // void getSharedname()async{
  //   widget.db.postDao.findPostByPostId(widget.postId).then((value) => setState((){
  //     if(value != null){
  //       if(value.sharedPost != null){ //so this is a shred post and we shoulf find the username
  //         widget.db.postDao.findPostByPostId(value.sharedPost!).then((val) => setState(() {
  //           if(val != null){
  //             var shareduserid = val.userId ;
  //             widget.db.userDao.findUserNameByUserId(shareduserid).then((v) => setState(() {
  //               if(v!= null){
  //                 sharedname = v.userName ;
  //               }
  //             }));
  //           }
  //         }));
  //       }else{//this is not a shared post 
  //         sharedname = " " ;
  //       }
  //     }
  //   }));
  // }

  var likeNumbers;
  List<int?> likelist = [];

  void countLike(int postId) async {
    likeNumbers = await widget.db.likeDao.likeNumbers(postId);
    widget.db.likeDao.likelist(postId).then((value) => setState(() {
          if (value != null) {
            int count = 0;
            for (int i = 0; i < value.length; i++) {
              // likeNumbers ++ ;
              likelist.add(value[i]?.userId);
              // print()
              print(likelist[i]);
            }
          }
        }));
  }

  void addLike(int postId, int userId) async {
    print("this liked post id : $postId");
    print("this liker userId :$userId");
    print(widget.id);
    var like = Like(userId: userId, PostId: postId);
    widget.db.likeDao.findLikeIdByUseridPostid(userId, postId).then((value) =>
        setState(() {
          if (value != null) {
            print("this is user id that we want:");
            print(userId);
            print("value is not null");
            print(value.LikeId);
            print(userId);
          }

          if (value == null) {
            print(userId);
            print("value is nulllllllllllllll");
            print(value);
            widget.db.likeDao.insertLike(like).then((value) => setState(() {
                  likelist = [];
                  countLike(postId);
                  //adding notification
          widget.db.postDao.findPostByPostId(postId).then((v) => setState(() {
          if (v != null) {
            print("start of sending notif by finding the reciever");
            var receiver = v.userId;
            if(receiver !=userId){
              print("reciever is : $receiver");
            print("myid is : $userId");
            print("network of notification founded");               
            int n = 4;
            
            var notif = Notificationn(
            post: postId,
            sender: userId,       
            notificationType: n,
            receiver: receiver);
            widget.db.notificationnDao.insertNotif(notif);
            print("notif like added successfully!!!!");
            print(postId);
            }
            
                  }
        }));

    ///end of adding notification
                }));
          }
        }));
  }

  var commentIds = [];
  List<String?> commentsTexts = [];
  List<int?> commentUserIds = [];
  List<String?> commentsUserNames = [];
  List<int?> commentrEPLY = [];
  List<int> temp = [];
  void addComment(int userId, int postId, String commentText, String replyto) async {
    print("we are in add comment");
    var comment ;
    if(replyto == ""){
      print("reply is empty");
      comment =Comment(postId: postId, userId: userId, commentText: commentText);

    }
    if(replyto != ""){
      print("reply is not empty");
      comment =Comment(ReplyCommentId: int.parse(replyto) , postId: postId, userId: userId, commentText: commentText);
    }
    widget.db.commentDao.insertComment(comment).then((ci) => setState(() {
      print("coment inserted");
      var comid = ci ;
       //adding notification if it is comment reply
      if(replyto!= ""){
        widget.db.commentDao.findCommentBycommentId(int.parse(replyto)).then((repid) => setState(() {
          if(repid!= null){
            var receiver = repid.userId;
            var notif = Notificationn(notificationType: 5, receiver: receiver, sender: userId , comment:comid );
            widget.db.notificationnDao.insertNotif(notif);
          }
          
        }));
      }//end of notif type 5
      //adding notification for comment on post
    widget.db.postDao.findPostByPostId(postId).then((v) => setState(() {
      if (v != null) {
        print("start of sending notif by finding the reciever");
        var receiver = v.userId;
        if(receiver != userId){
          print("reciever is : $receiver");
        print("myid is : $userId");
        print("network of notification founded");               
        var notif = Notificationn( post: postId , sender: userId , notificationType: 3 , receiver: receiver);
        widget.db.notificationnDao.insertNotif(notif);
        print("notif added successfully!!!!");
        }
        
              }
    }));

    ///end of adding notification


    }));
    print("controller of replyto :");
    print(replyto.toString());
    //for reply
    // if(replyto != null){
    //   widget.db.commentDao.updateCommentForReply(int.parse(replyto));
    // }

    print("after inserting comment");
    commentIds = [];
    commentsTexts = [];
    commentUserIds = [];
    commentrEPLY = [];
    allComments(postId);
    newCommentController.text = "";
  }

  List<int> commentlikes = [];
  void allComments(int postId) async {
    commentlikes = [];
    commentsTexts = [];
    commentsUserNames = [];
    commentIds = [];

    widget.db.commentDao.findAllComment(postId).then((value) => setState(() {
          if (value != null) {
            for (int i = 0; i < value.length; i++) {
              temp.add(0);
              var userid = value[i].userId;
              if (userid != null) {
                widget.db.userDao
                    .findUserNameByUserId(userid)
                    .then((val) => setState(() {
                          commentsUserNames.add(val?.userName);
                          print("username is adding to commentusernamelist");
                        }));
              }
              //adding commentlikes ;
              var com = value[i].commentId;
              if (com != null) {
                widget.db.commentLikeDao
                    .commentLikes(com)
                    .then((value) => setState(() {
                          int count = 0;
                          for (int i = 0; i < value.length; i++) {
                            count++;
                          }
                          commentlikes.add(count);
                        }));
              }

              print(value[i].commentId);
              commentIds.add(value[i].commentId);
              commentUserIds.add(value[i].userId);
              commentrEPLY.add(value[i].ReplyCommentId);
              if (value[i] != null) {
                commentsTexts.add(value[i].commentText);
              }

              print(commentIds);
            }
          }
        }));
  }

  void likeComment(int commentId, int userId) async {
    var commentLike = CommentLike(userId: userId, commentId: commentId);
    widget.db.commentLikeDao
        .findCommentLikeBYUseridCommentId(userId, commentId)
        .then((value) => setState(() {
              if (value == null) {
                widget.db.commentLikeDao.insertCommentLike(commentLike);

            //adding notification
            widget.db.commentDao.findCommentBycommentId(commentId).then((val) => setState((){
            if(val != null){
              var reciever = val.userId ;
              // var compost = val.commentText;
              var notif = Notificationn(notificationType: 5, receiver: reciever, sender: userId , comment: commentId);
              widget.db.notificationnDao.insertNotif(notif);
              print("notif comment like added successfully!!!!");
            // widget.db.commentLikeDao.findCommentLikeBYUseridCommentId(userId, commentId).then((v) => setState(() {
            //   if (v != null) {
            // print("start of sending notif by finding the reciever");
            // var receiver = v.userId;
            // if(receiver != userId){
            //   print("reciever is : $receiver");
            // print("myid is : $userId");
            // print("network of notification founded");               
            // int n = 5;
            // var notif = Notificationn(
            //   comment: commentId,
            // sender: userId,       
            // notificationType: n,
            // receiver: receiver);
            // widget.db.notificationnDao.insertNotif(notif);
            // print("notif added successfully!!!!");
            // }
            
                  }
        }));
        //end of adding notif

                print("after inserting commentlike ");
              } else {
                print("you have liked this comment before!");
              }
            }));
  }

  void sharePost()async{
    var pst = Post(PostCaption:widget.caption ,userId: widget.myid , sharedPost: widget.postId );
    widget.db.postDao.insertPost(pst);
    print("after inserting shared post to my post");
  }

  @override
  void initState() {
    print("we are in init");
    print(widget.myid);
    print(widget.id);
    print("end of init");
    getSharedname();
    getUserName();
    countLike(widget.postId);
    allComments(widget.postId);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 1.2,
      width: MediaQuery.of(context).size.width * 0.9,
      color: Colors.redAccent,
      margin: EdgeInsets.only(top: 20, bottom: 20),
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            height: 30,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  margin: EdgeInsets.only(left: 15),
                  child: Text(
                    username,
                    style: TextStyle(color: Colors.white, fontSize: 13),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(bottom:4),
                  child:Text("Post shared from :  " + sharedname , style: TextStyle(color: Colors.white),),
                  ),
                TextButton(onPressed: () {}, child: Text("..."))
              ],
            ),
          ),
          // Text(sharedname),

          Container(
            height: MediaQuery.of(context).size.height * 0.35,
            width: MediaQuery.of(context).size.width * 0.84,
            color: Colors.white12,
          ),

          Container(
            height: MediaQuery.of(context).size.height * 0.1,
            width: MediaQuery.of(context).size.width * 0.84,
            color: Colors.redAccent[100],
            child: Container(
              padding: EdgeInsets.only(left: 10, top: 5),
              child: Text(
                widget.caption,
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),

          Row(
            children: [
              Container(
                  child: TextButton(
                      onPressed: () {
                        return addLike(widget.postId, widget.myid);
                      },
                      child: Text(
                        "Likes",
                        style: TextStyle(color: Colors.white, fontSize: 13),
                      ))),
              Text(
                likelist.length.toString(),
                style: TextStyle(color: Colors.white),
              ),
              Container(
                margin: EdgeInsets.only(left: 5),
                child: TextButton(
                    onPressed: () {},
                    child: Text(
                      "Comments",
                      style: TextStyle(color: Colors.white, fontSize: 13),
                    )),
              ),
              Text(
                commentIds.length.toString(),
                style: TextStyle(color: Colors.white),
              ),
              TextButton(onPressed: (){
                return sharePost();
              }, 
              child: Text("share"))
            ],
          ),

          // NewCommentCard(),

          //start new comment
          Column(
            children: [
              Container(
                margin: EdgeInsets.only(top: 20),
                height: 130,
                width: MediaQuery.of(context).size.width * 0.5,
                color: Colors.redAccent[100],
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      padding: EdgeInsets.only(left: 10),
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "User",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          width: 200,
                          child: TextField(
                            controller: toWhomCommentController,
                            textAlign: TextAlign.left,
                            style: TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                                fillColor: Colors.white,
                                border: OutlineInputBorder(),
                                hintText: 'To whom ?',
                                hintStyle: TextStyle(color: Colors.white)),
                          ),
                        ),
                        Container(
                          width: 200,
                          child: TextField(
                            controller: newCommentController,
                            textAlign: TextAlign.left,
                            style: TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                                fillColor: Colors.white,
                                border: OutlineInputBorder(),
                                hintText: 'Add a comment...',
                                hintStyle: TextStyle(color: Colors.redAccent)),
                          ),
                        )
                      ],
                    ),
                    Container(
                      alignment: Alignment.bottomRight,
                      width: MediaQuery.of(context).size.width * 0.8,
                      child: TextButton(
                          onPressed: () {
                            return addComment(
                                widget.myid,
                                widget.postId,
                                newCommentController.text,
                                toWhomCommentController.text);
                          },
                          child: Text("Send")),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 20),
                height: 130,
                width: MediaQuery.of(context).size.width * 0.3,
                color: Colors.white10,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      padding: EdgeInsets.only(left: 10),
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "User",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 300,
                          child: TextField(
                            controller: likeCommentController,
                            textAlign: TextAlign.left,
                            style: TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                                fillColor: Colors.white,
                                border: OutlineInputBorder(),
                                hintText: 'Which Comment ?',
                                hintStyle: TextStyle(color: Colors.white)),
                          ),
                        ),
                      ],
                    ),
                    Container(
                        alignment: Alignment.center,
                        width: MediaQuery.of(context).size.width * 0.8,
                        child: ButtonTheme(
                            height: 30,
                            minWidth: MediaQuery.of(context).size.width * 0.2,
                            buttonColor: Colors.white,
                            child: RaisedButton(
                                onPressed: () {
                                  likeComment(
                                      int.parse(likeCommentController.text),
                                      widget.myid);
                                  allComments(widget.postId);
                                },
                                child: Text(
                                  "Like",
                                  style: TextStyle(color: Colors.redAccent),
                                )))),
                  ],
                ),
              ),
            ],
          ),

          //End new comment

          Flexible(
              child: ListView.builder(
                  itemCount: commentsTexts.length,
                  itemBuilder: (_, index) {
                    return Container(
                        margin: EdgeInsets.only(top: 20),
                        height: 50,
                        width: MediaQuery.of(context).size.width * 0.86,
                        color: Colors.redAccent[100],
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.86,
                          height: 30,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Container(
                                    padding: EdgeInsets.only(left: 10),
                                    child: Text(
                                      "commentId : ",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),

                                  Text(
                                    commentIds.length > 0
                                        ? commentIds[index].toString()
                                        : '0',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  Text("  "),
                                  Text(commentsUserNames.length > 0 ? commentsUserNames[index]! : '0' , style: TextStyle(color: Colors.white),),
                                  Text(
                                    "   likes : ",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  Text(
                                    commentlikes.length > 0
                                        ? commentlikes[index].toString()
                                        : '0',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  Text(
                                    "   Reply to : ",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  Text(
                                    commentrEPLY.length > 0
                                        ? commentrEPLY[index].toString()
                                        : " ",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ],
                              ),
                              Container(
                                padding: EdgeInsets.only(left: 10),
                                width: MediaQuery.of(context).size.width * 0.9,
                                child: Text(
                                  commentsTexts.length > 0
                                      ? commentsTexts[index]!
                                      : '0',
                                  style: TextStyle(color: Colors.white),
                                ),
                              )
                            ],
                          ),
                        ));
                  }))

          // Row(children: [
          //   TextButton(onPressed: (){}, child: Text("Like")),
          //   TextButton(onPressed: (){}, child: Text("Comment")),
          //   TextButton(onPressed: (){}, child: Text("Share"))
          // ],)
        ],
      ),
      
    );
  }
}

var otherFeatured ;
 List<OtherFeatureCard> otherFeatureTextList = [];
 List<OtherFeaturePost> otherFeaturePostList = [];
class OtherFeature extends StatefulWidget {
  const OtherFeature(this.db , this.user , this.myid);
  final AppDatabase db ;
  final int? user  ;
  final myid ;

  @override
  _OtherFeatureState createState() => _OtherFeatureState();
}

class _OtherFeatureState extends State<OtherFeature> {
      List accomplishmentsText = [] ;
    List accomplishmentsId = [] ;

void addFeatureCard(var id , var text){
  
  otherFeatureTextList.add(new OtherFeatureCard(id , text));
  setState((){});
}

addPostFeaturedCard(var caption , var id , int postId ){
  otherFeaturePostList.add(new OtherFeaturePost(caption, id, postId, widget.db , widget.myid));
  setState((){});
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
          
          print(val);

          widget.db.featuredDao.allAdditionalInfo(profileId).then((value) => setState((){
             if (value != null){
               print("all of features!!!!!!!!!!!!!!!");print(value);
              for ( var f in value){
               if(f?.postId ==null){//textfeature
                addFeatureCard(f?.featuredId, f?.featuredText);
               }else if(f?.postId != null){//postfeature
               var postid = f?.postId ;
                widget.db.postDao.findPostByPostId(postid!).then((po) => setState((){
                  var cap = po?.PostCaption ;
                addPostFeaturedCard(cap,f?.featuredId, postid);
                }));
               }
                
              }
             }
          }));
          }
      }));
    }
}
   
    

  // void getFeature()async{
  //   var a = widget.user;
  //   var profileId ;
   

  //   if (a != null){
  //     widget.db.userProfileDao.findProfileByUserId(a).then((val) => setState((){
  //       if (val != null) {
  //         profileId = val.ProfileId;
  //         // print("this profileid in test card $profileId");
  //         // skill = Skill(SkillText: "android" ,profileId: profileId);
  //         // widget.db.skillDao.insertSkill(skill);q

  //         widget.db.featuredDao.allAdditionalInfo(profileId).then((value) => setState((){
  //            if (value != null){
  //             for (int i = 0 ; i < value.length ; i++){
  //               if (value[i] != null){
  //                 print(value[i]?.featuredText);
  //                 print("this is the skillid :");
  //                 print(value[i]?.featuredId);
  //                 addFeatureCard(value[i]?.featuredId , value[i]?.featuredText );
  //                 var li = otherList[i].text;
  //                 print("$i , $li");
  //               }
                
  //             }
  //            }
  //         }));
  //         print(otherFeatured);
  //         }
  //     }));
  //   }

    
  //   // print("this my profileid $profileId");
    
  // }
  @override
  void initState() {
    getFeatures();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
       margin: EdgeInsets.only(top: 20),

      height: 400,
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
          child: Text("FEATURED",
          style: TextStyle(color: Colors.white , fontSize: 15),
          ),
        ),

      ],) ,),


      Container(
         height: 300,
         width: MediaQuery.of(context).size.width*0.9,
         child: 
       Row(
         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
         children: [

        Container(
          height: 300,
          width: MediaQuery.of(context).size.width*0.43,
          child: 
       ListView.builder(
        itemCount: otherFeatureTextList.length,
        itemBuilder: (_,index) { 
          return OtherFeatureCard(otherFeatureTextList[index].id.toString(), otherFeatureTextList[index].text);
          })),
    
       

       // post for features :
        Container(
          width: MediaQuery.of(context).size.width*0.43,
          child:
       ListView.builder(
        itemCount: otherFeaturePostList.length,
        itemBuilder: (_,index) { 
          return OtherFeaturePost(otherFeaturePostList[index].caption, otherFeaturePostList[index].id, otherFeaturePostList[index].postId, widget.db , widget.myid);
          })),
      ],),) 
        
      // Flexible(child:
      //  ListView.builder(
      //   itemCount: otherList.length,
      //   itemBuilder: (_,index) { 
      //     return OtherFeatureCard(otherList[index].id.toString(), otherList[index].text);
      //     }))
      /*Flexible(child: ListView.builder(
        itemCount: list.length,
        itemBuilder: (_,index) => list[index]))*/
      // OtherAccomplishCard() ,

      ], 
      )
      
    );
  }
}



class OtherFeatureCard extends StatefulWidget {
  const OtherFeatureCard(this.id , this.text);
  final id ;
  final text ;

  @override
  _OtherFeatureCardState createState() => _OtherFeatureCardState();
}

class _OtherFeatureCardState extends State<OtherFeatureCard> {
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
