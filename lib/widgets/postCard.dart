import 'dart:ffi';
// import 'dart:html';

import 'package:dbproject/models/Comment.dart';
import 'package:dbproject/models/CommentLike.dart';
import 'package:dbproject/models/Featured.dart';
import 'package:dbproject/models/Like.dart';
import 'package:dbproject/models/User.dart';
import 'package:dbproject/models/Notification.dart';
import 'package:dbproject/models/post.dart';
import 'package:dbproject/widgets/direct.dart';
import 'package:dbproject/widgets/skillsAndEndorsement.dart';
import 'package:flutter/material.dart';

import '../database.dart';

class PostCard extends StatefulWidget {
  const PostCard(this.caption, this.id, this.postId, this.db);
  final postId;
  final id;
  final caption;
  final AppDatabase db;
  @override
  _PostCardState createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
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
  void deleteFeaturedPost()async{
    
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
                  addtofeatured();
                }, child: Text("Add to featured"))
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
          Row(
            children: [
              Container(
                margin: EdgeInsets.only(top: 20),
                height: 130,
                width: MediaQuery.of(context).size.width * 0.6,
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
                          width: 300,
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
                          width: 400,
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

// class PostCard extends StatelessWidget {
//   const PostCard(this.caption, this.id) ;
//   final caption ;
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: MediaQuery.of(context).size.height*2,
//       width: MediaQuery.of(context).size.width*0.86,
//       color: Colors.redAccent,
//       margin: EdgeInsets.only(top: 20 , bottom: 20),
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//         children: [

//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//           Container(
//             margin: EdgeInsets.only(left: 15),
//             child: Text("user" ,
//             style: TextStyle(color: Colors.white , fontSize: 13),
//             ),
//           ) ,
//           TextButton(onPressed: (){}, child: Text("..."))
//         ],),
//         Container(
//           height: MediaQuery.of(context).size.height*0.35,
//           width: MediaQuery.of(context).size.width*0.84,
//           color: Colors.white12,
//         ),

//         Container(
//           height: MediaQuery.of(context).size.height*0.1,
//           width: MediaQuery.of(context).size.width*0.84,
//           color: Colors.redAccent[100],
//           child:Container(
//             padding: EdgeInsets.only(left: 10 , top: 5),
//             child: Text(caption , style: TextStyle(color: Colors.white),),),

//         ),

//         Row(children: [

//         Container(
//           child: TextButton(onPressed: (){}, child: Text("Likes" ,style: TextStyle(color: Colors.white , fontSize: 13),
//           ))
//           ),
//         Text("132" , style: TextStyle(color: Colors.white),),
//         Container(
//           margin: EdgeInsets.only(left: 5),
//           child: TextButton(onPressed: (){}, child: Text("Comments" ,style: TextStyle(color: Colors.white , fontSize: 13),
//             ))
//             ,),
//             Text("24",style: TextStyle(color: Colors.white),),

//         ],

//         ),

//         Row(children: [
//           TextButton(onPressed: (){}, child: Text("Like")),
//           TextButton(onPressed: (){}, child: Text("Comment")),
//           TextButton(onPressed: (){}, child: Text("Share"))
//         ],)
//       ],),

//     );
//   }
// }

class PostList extends StatefulWidget {
  const PostList(this.db, this.user);
  final user;
  final AppDatabase db;

  @override
  _PostListState createState() => _PostListState();
}

class _PostListState extends State<PostList> {
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(top: 20),
        height: MediaQuery.of(context).size.height * 1.1,
        width: MediaQuery.of(context).size.width * 0.9,
        color: Colors.black87,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.only(bottom: 39),
              child: Align(
                alignment: Alignment.topRight,
                child: TextButton(onPressed: () {}, child: Text("NEW POST")),
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.9,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    NewPostCard(widget.db, widget.user),
                    // NewCommentCard()
                  ],
                ),
              ),
            )
          ],
        ));
  }
}

// class PostList extends StatelessWidget {
//   const PostList({ Key ?key }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: EdgeInsets.only(top: 20),
//       height: MediaQuery.of(context).size.height*1.2,
//       width: MediaQuery.of(context).size.width*0.9,
//       color: Colors.black87,
//       child : Column(children: [
//         Container(
//           child:Align(alignment: Alignment.centerRight,
//         child: TextButton(onPressed: (){}, child: Text("NEW POST")),) ,),

//         Container(
//         height: MediaQuery.of(context).size.height*1.1,
//           child: SingleChildScrollView(

//         child: Column(children: [
//          NewPostCard(),
//         NewCommentCard()

//         ],),
//       ),)

//       ],)

//     );
//   }
// }

List<PostCard> userPosts = [];

class AddPost extends StatefulWidget {
  const AddPost(this.db, this.user);
  final user;
  final AppDatabase db;

  @override
  _AddPostState createState() => _AddPostState();
}

class _AddPostState extends State<AddPost> {
  List<AddComment> list = [];
  addSkillCard() {
    list.add(new AddComment());
    setState(() {});
  }

  void addPostCard(String text, var postId) {
    print("in adding post function lets see the id");
    print(widget.user);
    userPosts.add(new PostCard(text, widget.user, postId, widget.db));
  }

  void getAllUserPosts() async {
    var a = widget.user;
    if (a != null) {
      print("we are in get all posts");
      widget.db.postDao.findAllPosts(a).then((value) => setState(() {
            if (value != null) {
              print("the list of posts is not empty");
              for (int i = 0; i < value.length; i++) {
                print("inside for of list posts");
                // userPosts[i] = value[i];
                print("before calling addpostcard?!!!!!!!!!!!!!!");
                addPostCard(value[i].PostCaption, value[i].PostId);
                print("post id");
                print(value[i].PostId);
                print("post caption");
                print(value[i].PostCaption);
                print("userid of post");
                print(value[i].userId);
              }
            }
          }));
    }
  }

  @override
  void initState() {
    print("adding post useridddddddddd");
    print(widget.user);
    print("before get all user posts");
    getAllUserPosts();
    print("all posts");
    print(userPosts);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(top: 20),
        height: MediaQuery.of(context).size.height * 1,
        width: MediaQuery.of(context).size.width * 0.9,
        color: Colors.black87,
        child: Column(
          children: [
            Container(
              child: Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                    onPressed: addSkillCard, child: Text("NEW POST")),
              ),
            ),
            Flexible(
                child: ListView.builder(
                    itemCount: userPosts.length,
                    itemBuilder: (_, index) {
                      return PostCard(userPosts[index].caption, widget.user,
                          userPosts[index].postId, widget.db);
                    }))
          ],
        ));
  }
}

class CommentCard extends StatelessWidget {
  const CommentCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 80,
        width: MediaQuery.of(context).size.width * 0.86,
        color: Colors.white38,
        margin: EdgeInsets.only(top: 10),
        child: Column(
          children: [
            Container(
              alignment: Alignment.topLeft,
              height: 30,
              margin: EdgeInsets.only(left: 10, top: 10),
              child: Text(
                "user",
                style: TextStyle(color: Colors.white, fontSize: 13),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  margin: EdgeInsets.only(left: 10),
                  child: Text(
                    "Text",
                    style: TextStyle(color: Colors.white, fontSize: 13),
                  ),
                ),
                Row(
                  children: [
                    TextButton(onPressed: () {}, child: Text("Like")),
                    TextButton(onPressed: () {}, child: Text("Reply"))
                  ],
                )
              ],
            ),
          ],
        ));
  }
}

TextEditingController newCaptionController = TextEditingController();

class NewPostCard extends StatefulWidget {
  const NewPostCard(this.db, this.user);
  final AppDatabase db;
  final user;

  @override
  _NewPostCardState createState() => _NewPostCardState();
}

class _NewPostCardState extends State<NewPostCard> {
  void makeNewPostInDataBase(String caption) async {
    var newPost = Post(PostCaption: caption, userId: widget.user);
    await widget.db.postDao.insertPost(newPost);
    print("new post added ");
    // userPosts = [];
    var a = widget.user;
    widget.db.postDao.findAllPosts(a).then((value) => setState(() {
          // if()
        }));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 20),
      height: MediaQuery.of(context).size.height * 0.7,
      width: MediaQuery.of(context).size.width * 0.9,
      color: Colors.redAccent,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            color: Colors.white38,
            height: 40,
            alignment: Alignment.centerLeft,
            child: Container(
              padding: EdgeInsets.only(left: 10),
              child: Text(
                "NEW POST",
                style: TextStyle(color: Colors.redAccent, fontSize: 20),
              ),
            ),
          ),
          Container(
            height: 200,
            width: MediaQuery.of(context).size.width * 0.88,
            color: Colors.white12,
            child: TextButton(
                onPressed: () {},
                child: Text(
                  "select photo",
                  style: TextStyle(color: Colors.white),
                )),
          ),
          Container(
            color: Colors.white12,
            child: TextField(
              controller: newCaptionController,
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                  fillColor: Colors.white,
                  border: OutlineInputBorder(),
                  hintText: 'Caption',
                  hintStyle: TextStyle(color: Colors.white)),
            ),
          ),
          ButtonTheme(
              height: 50,
              minWidth: MediaQuery.of(context).size.width * 0.88,
              buttonColor: Colors.redAccent[100],
              child: RaisedButton(
                  onPressed: () {
                    return makeNewPostInDataBase(newCaptionController.text);
                  },
                  child: Text(
                    "Send",
                    style: TextStyle(color: Colors.white),
                  )))
        ],
      ),
    );
  }
}

// class NewPostCard extends StatelessWidget {
//   const NewPostCard({ Key ?key }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: EdgeInsets.only(top: 20),
//       height: MediaQuery.of(context).size.height*0.8,
//       width: MediaQuery.of(context).size.width * 0.9,
//       color: Colors.redAccent,
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.spaceEvenly,

//       children: [

//         Container(

//           color: Colors.white38,
//           height: 40,
//         alignment: Alignment.centerLeft,
//         child:
//         Container(
//           padding: EdgeInsets.only(left: 10),
//           child:Text("NEW POST" ,
//         style: TextStyle(color: Colors.redAccent , fontSize: 20),) ,),

//         ),
//         Container(
//       height: 200,
//       width: MediaQuery.of(context).size.width * 0.88,

//       color: Colors.white12,
//       child: TextButton(onPressed: (){}, child: Text("select photo" , style: TextStyle(color: Colors.white),)),

//         ),
//         Container(

//           color: Colors.white12,
//           child:TextField(
//           controller: newCaptionController,

//           style: TextStyle(color: Colors.white),
//           decoration: InputDecoration(
//           fillColor: Colors.white,
//           border: OutlineInputBorder(),
//           hintText: 'Caption' ,
//           hintStyle: TextStyle(color: Colors.white)
//   ),

//         ) ,
//         ),

//           ButtonTheme(
//           height: 50,
//           minWidth: MediaQuery.of(context).size.width*0.88,
//           buttonColor: Colors.redAccent[100],
//           child: RaisedButton(onPressed: (){}
//           ,
//            child: Text("Send" , style: TextStyle(color: Colors.white),))
//            )

//         ],
//       ),

//     );
//   }
// }

class NewCommentCard extends StatelessWidget {
  const NewCommentCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 20),
      height: 130,
      width: MediaQuery.of(context).size.width * 0.86,
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
          TextField(
            // controller: newCommentController,
            textAlign: TextAlign.left,
            style: TextStyle(color: Colors.white),
            decoration: InputDecoration(
                fillColor: Colors.white,
                border: OutlineInputBorder(),
                hintText: 'Add a comment...',
                hintStyle: TextStyle(color: Colors.redAccent)),
          ),
          Container(
            alignment: Alignment.bottomRight,
            width: MediaQuery.of(context).size.width * 0.8,
            child: TextButton(onPressed: () {}, child: Text("Send")),
          ),
        ],
      ),
    );
  }
}

class AddComment extends StatefulWidget {
  const AddComment({Key? key}) : super(key: key);

  @override
  _AddCommentState createState() => _AddCommentState();
}

class _AddCommentState extends State<AddComment> {
  List<CommentCard> list = [];
  addSkillCard() {
    list.add(new CommentCard());
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.8,
      width: MediaQuery.of(context).size.width * 0.86,
      color: Colors.redAccent,
      margin: EdgeInsets.only(top: 20, bottom: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                margin: EdgeInsets.only(left: 15),
                child: Text(
                  "user",
                  style: TextStyle(color: Colors.white, fontSize: 13),
                ),
              ),
              TextButton(onPressed: () {}, child: Text("..."))
            ],
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
                "caption",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
          Row(
            children: [
              Container(
                  child: TextButton(
                      onPressed: () {},
                      child: Text(
                        "Likes",
                        style: TextStyle(color: Colors.white, fontSize: 13),
                      ))),
              Text(
                "132",
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
                "24",
                style: TextStyle(color: Colors.white),
              ),
            ],
          ),
          Row(
            children: [
              TextButton(onPressed: () {}, child: Text("Like")),
              TextButton(onPressed: addSkillCard, child: Text("Comment")),
              TextButton(onPressed: () {}, child: Text("Share"))
            ],
          ),
          Flexible(
              child: ListView.builder(
                  itemCount: list.length,
                  itemBuilder: (_, index) => list[index]))
        ],
      ),
    );
  }
}

class OtherPostCard extends StatefulWidget {
  const OtherPostCard(this.postId, this.id, this.caption, this.db, this.myid);
  final postId;
  final id;
  final caption;
  final AppDatabase db;
  final myid;

  @override
  _OtherPostCardState createState() => _OtherPostCardState();
}

class _OtherPostCardState extends State<OtherPostCard> {
  TextEditingController newCommentController = TextEditingController();
  TextEditingController toWhomCommentController = TextEditingController();
  TextEditingController likeCommentController = TextEditingController();

  String username = '';
  void getUserName() async {
    widget.db.userDao
        .findUserNameByUserId(widget.id)
        .then((value) => setState(() {
              print("entered the query");
              if (value != null) {
                username = value.userName;
                print("the username is : $username");
              }
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
          Row(
            children: [
              Container(
                margin: EdgeInsets.only(top: 20),
                height: 130,
                width: MediaQuery.of(context).size.width * 0.6,
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
                          width: 300,
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
                          width: 400,
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

class OtherPost extends StatefulWidget {
  const OtherPost(this.db, this.user, this.myid);
  final user;
  final AppDatabase db;
  final myid;

  @override
  _OtherPostState createState() => _OtherPostState();
}

class _OtherPostState extends State<OtherPost> {
  List<OtherPostCard> otherUserPosts = [];
  void addPostCard(String text, var postId) {
    otherUserPosts.add(
        new OtherPostCard(text, widget.user, postId, widget.db, widget.myid));
  }

  void getAllUserPosts() async {
    var a = widget.user;
    if (a != null) {
      print("we are in get all posts");
      widget.db.postDao.findAllPosts(a).then((value) => setState(() {
            if (value != null) {
              print("the list of posts is not empty");
              for (int i = 0; i < value.length; i++) {
                print("inside for of list posts");
                // userPosts[i] = value[i];
                addPostCard(value[i].PostCaption, value[i].PostId);
                print("post id");
                print(value[i].PostId);
                print("post caption");
                print(value[i].PostCaption);
                print("userid of post");
                print(value[i].userId);
              }
            }
          }));
    }
  }

  @override
  void initState() {
    print("before get all user posts");
    getAllUserPosts();
    print("all posts");
    print(userPosts);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(top: 20),
        height: MediaQuery.of(context).size.height * 0.8,
        width: MediaQuery.of(context).size.width * 0.9,
        color: Colors.black87,
        child: Column(
          children: [
            Container(
              height: 30,
              alignment: Alignment.centerLeft,
              margin: EdgeInsets.only(left: 10, top: 7),
              child: Text(
                "POSTS",
                style: TextStyle(color: Colors.white, fontSize: 15),
              ),
            ),

            /*Flexible(child: ListView.builder(
        itemCount: list.length,
        itemBuilder: (_,index) => list[index]))*/
            Flexible(
                child: ListView.builder(
                    itemCount: otherUserPosts.length,
                    itemBuilder: (_, index) {
                      return OtherPostCard(
                          otherUserPosts[index].caption,
                          otherUserPosts[index].id,
                          otherUserPosts[index].postId,
                          widget.db,
                          widget.myid);
                    }))
          ],
        ));
  }
}
// class OtherPost extends StatelessWidget {
//   const OtherPost({ Key? key }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: EdgeInsets.only(top: 20),
//       height: MediaQuery.of(context).size.height*0.8,
//       width: MediaQuery.of(context).size.width*0.9,
//       color: Colors.black87,
//       child : Column(children: [
//         Container(
//           height: 30,
//           alignment: Alignment.centerLeft,
//           margin: EdgeInsets.only(left: 10 , top: 7),
//           child:Text("POSTS" , style: TextStyle(color: Colors.white , fontSize: 15),)
//         ,),

//         /*Flexible(child: ListView.builder(
//         itemCount: list.length,
//         itemBuilder: (_,index) => list[index]))*/
//         Container(
//           height: 500,
//           child:SingleChildScrollView(child: Column(children: [
//           // PostCard(),
//         ],),
//         ) ,)

//       ],)

//     );
//   }
// }

class HomePosts extends StatefulWidget {
  const HomePosts(this.db, this.myid);
  final myid;
  final AppDatabase db;

  @override
  _HomePostsState createState() => _HomePostsState();
}

class _HomePostsState extends State<HomePosts> {
  List<OtherPostCard> allPosts = [];
  void addPostCard(String text, var postId, var userId) {
    allPosts
        .add(new OtherPostCard(postId, userId, text, widget.db, widget.myid));
  }

  void getAllUserPosts() async {
    var a = widget.myid;
    if (a != null) {
      print("we are in get all posts");
      widget.db.postDao.allNetworkPosts(a).then((value) => setState(() {
            if (value != null) {
              print("the list of posts is not empty");
              for (int i = 0; i < value.length; i++) {
                print("inside for of list posts");
                // userPosts[i] = value[i];
                addPostCard(
                    value[i].PostCaption, value[i].PostId, value[i].userId);
                print("post id");
                print(value[i].PostId);
                print("post caption");
                print(value[i].PostCaption);
                print("userid of post");
                print(value[i].userId);
              }
            }
          }));
    }
  }

  @override
  void initState() {
    print("before get all user posts");
    getAllUserPosts();
    print("all posts");
    print(userPosts);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(top: 20),
        height: MediaQuery.of(context).size.height * 1,
        width: MediaQuery.of(context).size.width * 0.9,
        color: Colors.black87,
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.only(left: 10),
              height: 40,
              color: Colors.redAccent,
              child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "HOME POSTS",
                    style: TextStyle(color: Colors.white),
                  )),
            ),
            Flexible(
                child: ListView.builder(
                    itemCount: allPosts.length,
                    itemBuilder: (_, index) {
                      return OtherPostCard(
                          allPosts[index].postId,
                          allPosts[index].id,
                          allPosts[index].caption,
                          widget.db,
                          widget.myid);
                    }))
          ],
        ));
  }
}

class LikeCommentPost extends StatefulWidget {
  const LikeCommentPost(this.db, this.user);
  final user;
  final AppDatabase db;

  @override
  _LikeCommentPostState createState() => _LikeCommentPostState();
}

class _LikeCommentPostState extends State<LikeCommentPost> {
  List<OtherPostCard> likeCommentPost = [];
  List<String> networkCommentedLike = [];

  void addPostCard(String text, var postId, var userId) {
    likeCommentPost
        .add(new OtherPostCard(text, userId, postId, widget.db, widget.user));
  }

  void getAllUserPosts() async {
    var a = widget.user;
    var b = widget.user;
    if (a != null) {
      print("post like by network is called");
      widget.db.postDao.postlikedByNetwork(a).then((value) => setState(() {
            if (value != null) {
              print("the list of posts is not empty");
              for (int i = 0; i < value.length; i++) {
                print("inside for of list posts");
                // userPosts[i] = value[i];
                // var x = value[i]?.
                addPostCard(value[i].PostCaption, value[i].PostId, value[i].userId);
                widget.db.userDao.findUserNameByUserId(a).then((u) => setState((){
                  var name = u?.userName ;
                  networkCommentedLike.add(name!);
                }));
                
                print("post is added in likecomment post");
                print("post id");
                print(value[i].PostId);
                print("post caption");
                print(value[i].PostCaption);
                print("userid of post");
                print(value[i].userId);
              }
            }
            widget.db.postDao.postCommentedByNetwork(b).then((val) => setState(() {
              if (val != null) {
                print("the list of posts is not empty");
                for (int i = 0; i < val.length; i++) {
                  print("inside for of list posts");
                  // userPosts[i] = value[i];
                  addPostCard(val[i].PostCaption, val[i].PostId, val[i].userId);
                  widget.db.userDao.findUserNameByUserId(b).then((u) => setState((){
                  var name = u?.userName ;
                  networkCommentedLike.add(name!);
                }));
                  print("post is added in likecomment post");
                  print("post id");
                  print(val[i].PostId);
                  print("post caption");
                  print(val[i].PostCaption);
                  print("userid of post");
                  print(val[i].userId);
                }
              }
            }));
          }));
    }
  }

  @override
  void initState() {
    print("before get all user posts");
    getAllUserPosts();
    print("all posts");
    print(userPosts);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(top: 20),
        height: MediaQuery.of(context).size.height * 1,
        width: MediaQuery.of(context).size.width * 0.9,
        color: Colors.black87,
        child: Column(children: [
          Container(
            padding: EdgeInsets.only(left: 10),
            height: 40,
            color: Colors.redAccent,
            child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "ACTIVITIES",
                  style: TextStyle(color: Colors.white),
                )),
          ),
          Flexible(
              child: ListView.builder(
                  itemCount: likeCommentPost.length,
                  itemBuilder: (_, index) {
                    return Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Liked by :",
                            style: TextStyle(color: Colors.white),
                          ),
                          Text(
                            "Commented by :",
                            style: TextStyle(color: Colors.white),
                          ),
                          // Text(networkCommentedLike[index]),
                          OtherPostCard(
                              likeCommentPost[index].caption,
                              likeCommentPost[index].id,
                              likeCommentPost[index].postId,
                              widget.db,
                              widget.user)
                        ],
                      ),
                    );
                  }))
        ]));
  }
}
