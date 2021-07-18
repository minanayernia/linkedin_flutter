
import 'dart:ffi';

import 'package:dbproject/models/Comment.dart';
import 'package:dbproject/models/CommentLike.dart';
import 'package:dbproject/models/Like.dart';
import 'package:dbproject/models/User.dart';
import 'package:dbproject/models/post.dart';
import 'package:dbproject/widgets/skillsAndEndorsement.dart';
import 'package:flutter/material.dart';

import '../database.dart';
 
class PostCard extends StatefulWidget {
  const PostCard(this.caption , this.id ,  this.postId ,this.db);
  final postId ;
  final id ;
  final caption;
  final AppDatabase db ;
  @override
  _PostCardState createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  TextEditingController newCommentController = TextEditingController();
  TextEditingController toWhomCommentController = TextEditingController();
  TextEditingController likeCommentController = TextEditingController();


  String username= '' ;
  void getUserName()async{
    widget.db.userDao.findUserNameByUserId(widget.id).then((value) => setState((){
      print("entered the query");
      if (value != null){
        username = value.userName ;
        print("the username is : $username");
      }
    }));

  }
var likeNumbers ;
List<int?> likelist  = [] ;

void countLike(int postId)async{
  likeNumbers = await widget.db.likeDao.likeNumbers(postId);
  widget.db.likeDao.likelist(postId).then((value) => setState((){
    if (value != null){
      int count = 0 ;
      for(int i = 0 ; i < value.length ; i++){
        // likeNumbers ++ ;
        likelist.add(value[i]?.userId);
        // print()
        print(likelist[i]);
      }
    }
  }
  
  ));

}

void addLike(int postId , int userId)async{
  print("this liked post id : $postId");
  print("this liker userId :$userId");
  var like = Like(userId: userId , PostId: postId);
  widget.db.likeDao.findLikeIdByUseridPostid(userId, postId).then((value) => setState(() {
    if (value != null){
      print("value is not null");
      print(value);
    }

    if (value == null ){
      print(userId);
      print("value is nulllllllllllllll");
      print(value);
      widget.db.likeDao.insertLike(like).then((value) => setState((){
      likelist = [];
      countLike(postId);
  }));
    }
  }));
  
}
var commentIds = [];
List<String?> commentsTexts=[];
List<int?> commentUserIds= [];
List<String?> commentsUserNames = [];
List<int?> commentrEPLY = [] ;
List<int> temp = [] ;
  void addComment(int userId , int postId , String commentText , String replyto)async{
    var comment = Comment(postId: postId, userId: userId, commentText: commentText);
    await widget.db.commentDao.insertComment(comment);
    print("controller of replyto :");
    print(replyto.toString());
    //for reply
    // if(replyto != null){
    //   widget.db.commentDao.updateCommentForReply(int.parse(replyto));
    // }

    print("after inserting comment");
    commentIds = [];
    commentsTexts=[];
    commentUserIds= [];
    commentrEPLY = [] ;
    allComments(postId);
    newCommentController.text = "" ;
  }
List<int> commentlikes = [];
void allComments(int postId)async{
  commentlikes = [] ;
  commentsTexts = [] ;
  commentsUserNames = [] ;
  commentIds = [] ;

  widget.db.commentDao.findAllComment(postId).then((value) => setState(() { 
    if (value != null){
      for (int i = 0 ; i < value.length ; i++){
        temp.add(0);
        var userid = value[i].userId ;
        if (userid != null ){
          widget.db.userDao.findUserNameByUserId(userid).then((val) => setState(() {
            commentsUserNames.add(val?.userName);
            print("username is adding to commentusernamelist");
          }));
        }
        //adding commentlikes ;
        var com = value[i].commentId ;
        if (com != null){
          widget.db.commentLikeDao.commentLikes(com).then((value) => setState(() {
            int count = 0 ;
            for(int i = 0 ; i < value.length ; i++){
              count ++ ;
            }
            commentlikes.add(count);
          }));
        }
        


        print(value[i].commentId);
        commentIds.add(value[i].commentId);
        commentUserIds.add(value[i].userId);
        // commentrEPLY.add(value[i].ReplyCommentId);
        if (value[i] != null){
          commentsTexts.add(value[i].commentText);
        }
        
        print(commentIds);
      }
    }
    }));
}

void likeComment(int commentId , int userId)async{
  var commentLike = CommentLike(userId: userId, commentId: commentId);
  widget.db.commentLikeDao.findCommentLikeBYUseridCommentId(userId, commentId).then((value) => setState(() {
    if (value == null){
      widget.db.commentLikeDao.insertCommentLike(commentLike);
      print("after inserting commentlike ");
    }else{
      print("you have liked this comment before!");
    }
  }));
  
}
  @override
  void initState() {
    getUserName();
    countLike(widget.postId);
    allComments(widget.postId);
    super.initState();
  }
  @override
  void setState(VoidCallback fn) {
    // countLike(widget.postId);
    super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height*1.2,
      width: MediaQuery.of(context).size.width*0.86,
      color: Colors.redAccent,
      margin: EdgeInsets.only(top: 20 , bottom: 20),
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [

        Container(
          height: 30,
          child:Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
          Container(
            margin: EdgeInsets.only(left: 15),
            child: Text(username , 
            style: TextStyle(color: Colors.white , fontSize: 13),
            ),
          ) , 
          TextButton(onPressed: (){}, child: Text("..."))
        ],) ,),

        
        Container(
          height: MediaQuery.of(context).size.height*0.35,
          width: MediaQuery.of(context).size.width*0.84,
          color: Colors.white12,
        ),

        Container(
          height: MediaQuery.of(context).size.height*0.1,
          width: MediaQuery.of(context).size.width*0.84,
          color: Colors.redAccent[100],
          child:Container(
            padding: EdgeInsets.only(left: 10 , top: 5),
            child: Text(widget.caption , style: TextStyle(color: Colors.white),),),
          
        ),

        Row(children: [
        
        Container(
          child: TextButton(
            onPressed: (){
              return addLike(widget.postId, widget.id);
          }, child: Text("Likes" ,style: TextStyle(color: Colors.white , fontSize: 13),
          ))
          ),
        Text(likelist.length.toString() , style: TextStyle(color: Colors.white),),
        Container(
          margin: EdgeInsets.only(left: 5),
          child: TextButton(
            onPressed: (){}, child: Text("Comments" ,style: TextStyle(color: Colors.white , fontSize: 13),
            ))
            ,),
            Text(commentIds.length.toString(),style: TextStyle(color: Colors.white),),
            
        

        ],
        
        ),

        // NewCommentCard(),

        //start new comment
        Row(children: [

          Container(
      margin: EdgeInsets.only(top: 20),
      height: 130,
      width: MediaQuery.of(context).size.width*0.6,
      color: Colors.redAccent[100],
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [

          Container(
            padding: EdgeInsets.only(left: 10),
          alignment: Alignment.centerLeft,  
          child: Text("User" , style: TextStyle(color: Colors.white),),) ,

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
          hintText: 'To whom ?' , 
          hintStyle: TextStyle(color: Colors.white )  
         ),),
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
          hintText: 'Add a comment...' , 
          hintStyle: TextStyle(color: Colors.redAccent )  
         ),),)

          ],),
         Container(
           alignment: Alignment.bottomRight,
           width: MediaQuery.of(context).size.width*0.8,
           child: TextButton(
             onPressed: (){
             return addComment(widget.id, widget.postId, newCommentController.text , toWhomCommentController.text);
           }, child: Text("Send")) ,),
         

        ],
      ), 
    ),
      Container(
      margin: EdgeInsets.only(top: 20),
      height: 130,
      width: MediaQuery.of(context).size.width*0.3,
      color: Colors.white10,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [

          Container(
            padding: EdgeInsets.only(left: 10),
          alignment: Alignment.centerLeft,  
          child: Text("User" , style: TextStyle(color: Colors.white),),) ,

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
          hintText: 'Which Comment ?' , 
          hintStyle: TextStyle(color: Colors.white )  
         ),),
         ),

          ],),
         Container(
           alignment: Alignment.center,
           width: MediaQuery.of(context).size.width*0.8,
           child: ButtonTheme(
          height: 30,
          minWidth: MediaQuery.of(context).size.width*0.2,
          buttonColor: Colors.white,
          child: RaisedButton(onPressed: (){
            likeComment(int.parse(likeCommentController.text), widget.id);
            allComments(widget.postId);
          },
           child: Text("Like" , style: TextStyle(color: Colors.redAccent),)))
           
           ),
         

        ],
      ), 
    ),

        ],),
        

    //End new comment


    
    Flexible(child: ListView.builder(
      itemCount: commentsTexts.length,
      itemBuilder: (_,index) {
      return Container(
        margin: EdgeInsets.only(top:20),
        height: 50,
        width: MediaQuery.of(context).size.width*0.86,
        color: Colors.redAccent[100],
        child: Container(
          width: MediaQuery.of(context).size.width*0.86,
          height: 30,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
          Text("commentId :"),
          Text(commentIds.length > 0 ? commentIds[index].toString() : '0'),
          Text("  "),
          // Text(commentsUserNames.length > 0 ? commentsUserNames[index]! : '0'),
          Text("   likes:"),
          Text(commentlikes.length > 0 ? commentlikes[index].toString() : '0'),
          Text("   Reply to:"),
          Text(commentrEPLY.length > 0 ? commentrEPLY[index].toString() : ""),

          ],),

          Container(
            width: MediaQuery.of(context).size.width*0.9,
            color: Colors.white,
            child: Text(commentsTexts.length > 0 ? commentsTexts[index]! : '0' , style: TextStyle(color: Colors.redAccent),) ,)
          
      ],),
        )
      
      );
      }))

        // Row(children: [
        //   TextButton(onPressed: (){}, child: Text("Like")),
        //   TextButton(onPressed: (){}, child: Text("Comment")),
        //   TextButton(onPressed: (){}, child: Text("Share"))
        // ],)
      ],),

      
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
  const PostList(this.db , this.user) ;
  final user ;
  final AppDatabase db ;
  

  @override
  _PostListState createState() => _PostListState();
}

class _PostListState extends State<PostList> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 20),
      height: MediaQuery.of(context).size.height*1.2,
      width: MediaQuery.of(context).size.width*0.9,
      color: Colors.black87,
      child : Column(children: [
        Container(
          child:Align(alignment: Alignment.centerRight,
        child: TextButton(onPressed: (){}, child: Text("NEW POST")),) ,),
        


        Container(
        height: MediaQuery.of(context).size.height*1.1,
          child: SingleChildScrollView(
        
        child: Column(children: [
         NewPostCard(widget.db,widget.user),
        NewCommentCard()
          
        ],),
      ),)
        
        

      ],) 
    );
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

List<PostCard> userPosts = [] ; 

class AddPost extends StatefulWidget {
  const AddPost(this.db , this.user);
  final user ;
  final AppDatabase db ;

  @override
  _AddPostState createState() => _AddPostState();
}

class _AddPostState extends State<AddPost> {
  List<AddComment> list = [];
addSkillCard(){
  
  list.add(new AddComment()
  );
  setState((){});
}
void addPostCard( String text , var postId){
  userPosts.add(new PostCard(text , widget.user , postId, widget.db));
}

void getAllUserPosts()async{
  var a = widget.user ;
  if (a != null){
    print("we are in get all posts");
    widget.db.postDao.findAllPosts(a).then((value) => setState((){
      if (value != null){
        print("the list of posts is not empty");
        for(int i = 0 ; i < value.length ; i++){
          print("inside for of list posts");
          // userPosts[i] = value[i];
          addPostCard(value[i].PostCaption , value[i].PostId);
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
void initState(){
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
      height: MediaQuery.of(context).size.height*1,
      width: MediaQuery.of(context).size.width*0.9,
      color: Colors.black87,
      child : Column(children: [
        Container(
          child:Align(alignment: Alignment.centerRight,
        child: TextButton(onPressed: addSkillCard, child: Text("NEW POST")),) ,),
        
        Flexible(child: ListView.builder(
        itemCount: userPosts.length,
        itemBuilder: (_,index) {
          return PostCard(userPosts[index].caption , userPosts[index].id, userPosts[index].postId, widget.db);}))
      
        

      ],)
      
      
    );
  }
}

class CommentCard extends StatelessWidget {
  const CommentCard({ Key ?key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(

        height: 80,
      width: MediaQuery.of(context).size.width*0.86,
      color: Colors.white38,
      margin: EdgeInsets.only(top: 10),

      child : Column(
        children: [
        
        Container(
          alignment: Alignment.topLeft,
          height: 30,
          margin: EdgeInsets.only(left: 10 , top: 10),
          child: Text("user" , 
          style: TextStyle(color: Colors.white , fontSize: 13),
          ),
        ),


        Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
        Container(
          margin: EdgeInsets.only(left: 10),
          child: Text("Text" , 
          style: TextStyle(color: Colors.white , fontSize: 13),
          ),
        ),
        
        Row(children: [
        TextButton(onPressed: (){}, child: Text("Like")),
        TextButton(onPressed: (){}, child: Text("Reply"))
        ],)
        

      ],),

      ],)

      
    );
  }
}

TextEditingController newCaptionController = TextEditingController();


class NewPostCard extends StatefulWidget {
  const NewPostCard( this.db , this.user );
  final AppDatabase db ;
  final user ;


  @override
  _NewPostCardState createState() => _NewPostCardState();
}

class _NewPostCardState extends State<NewPostCard> {

  void makeNewPostInDataBase(String caption)async{
    var newPost = Post(PostCaption: caption, userId: widget.user);
    await widget.db.postDao.insertPost(newPost);
    print("new post added ");
    userPosts = [];
    var a = widget.user ;
    widget.db.postDao.findAllPosts(a).then((value) => setState((){
      // if()
    }));
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 20),
      height: MediaQuery.of(context).size.height*0.8,
      width: MediaQuery.of(context).size.width * 0.9,
      color: Colors.redAccent,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,

      children: [

        Container(
          
          color: Colors.white38,
          height: 40,
        alignment: Alignment.centerLeft,
        child: 
        Container(
          padding: EdgeInsets.only(left: 10),
          child:Text("NEW POST" , 
        style: TextStyle(color: Colors.redAccent , fontSize: 20),) ,),
        
        ),
        Container(
      height: 200,
      width: MediaQuery.of(context).size.width * 0.88,

      color: Colors.white12,
      child: TextButton(onPressed: (){}, child: Text("select photo" , style: TextStyle(color: Colors.white),)),
        
        ),
        Container(
          
          color: Colors.white12,
          child:TextField(
          controller: newCaptionController,
          
          style: TextStyle(color: Colors.white),
          decoration: InputDecoration(
          fillColor: Colors.white,
          border: OutlineInputBorder(),
          hintText: 'Caption' , 
          hintStyle: TextStyle(color: Colors.white)
  ),
          
        ) ,
        ),
        

          ButtonTheme(
          height: 50,
          minWidth: MediaQuery.of(context).size.width*0.88,
          buttonColor: Colors.redAccent[100],
          child: RaisedButton(onPressed:(){ 
            return makeNewPostInDataBase(newCaptionController.text);}
          ,
           child: Text("Send" , style: TextStyle(color: Colors.white),))
           )
        


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
  const NewCommentCard({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 20),
      height: 130,
      width: MediaQuery.of(context).size.width*0.86,
      color: Colors.redAccent[100],
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [

          Container(
            padding: EdgeInsets.only(left: 10),
          alignment: Alignment.centerLeft,  
          child: Text("User" , style: TextStyle(color: Colors.white),),) ,

          TextField(
            // controller: newCommentController,
            textAlign: TextAlign.left,
            style: TextStyle(color: Colors.white),
          decoration: InputDecoration(
          fillColor: Colors.white,
          border: OutlineInputBorder(),
          hintText: 'Add a comment...' , 
          hintStyle: TextStyle(color: Colors.redAccent )  
         ),),
         Container(
           alignment: Alignment.bottomRight,
           width: MediaQuery.of(context).size.width*0.8,
           child: TextButton(onPressed: (){}, child: Text("Send")) ,),
         

        ],
      ),
      
      
    );
  }
}


class AddComment extends StatefulWidget {
  const AddComment({ Key? key }) : super(key: key);

  @override
  _AddCommentState createState() => _AddCommentState();
}

class _AddCommentState extends State<AddComment> {
    List<CommentCard> list = [];
    addSkillCard(){
  
    list.add(new CommentCard()
    );
    setState((){});
}
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height*0.8,
      width: MediaQuery.of(context).size.width*0.86,
      color: Colors.redAccent,
      margin: EdgeInsets.only(top: 20 , bottom: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
          Container(
            margin: EdgeInsets.only(left: 15),
            child: Text("user" , 
            style: TextStyle(color: Colors.white , fontSize: 13),
            ),
          ) , 
          TextButton(onPressed: (){}, child: Text("..."))
        ],),
        Container(
          height: MediaQuery.of(context).size.height*0.35,
          width: MediaQuery.of(context).size.width*0.84,
          color: Colors.white12,
        ),

        Container(
          height: MediaQuery.of(context).size.height*0.1,
          width: MediaQuery.of(context).size.width*0.84,
          color: Colors.redAccent[100],
          child:Container(
            padding: EdgeInsets.only(left: 10 , top: 5),
            child: Text("caption" , style: TextStyle(color: Colors.white),),),
          
        ),

        Row(children: [
        
        Container(
          child: TextButton(onPressed: (){}, child: Text("Likes" ,style: TextStyle(color: Colors.white , fontSize: 13),
          ))
          ),
        Text("132" , style: TextStyle(color: Colors.white),),
        Container(
          margin: EdgeInsets.only(left: 5),
          child: TextButton(onPressed: (){}, child: Text("Comments" ,style: TextStyle(color: Colors.white , fontSize: 13),
            ))
            ,),
            Text("24",style: TextStyle(color: Colors.white),),
            
        

        ],
        
        ),


        Row(children: [
          TextButton(onPressed: (){}, child: Text("Like")),
          TextButton(onPressed: addSkillCard, child: Text("Comment")),
          TextButton(onPressed: (){}, child: Text("Share"))
        ],),


        Flexible(child: ListView.builder(
        itemCount: list.length,
        itemBuilder: (_,index) => list[index]))
      


      ],),

      
      
    );
  }
}
List<PostCard> otherUserPosts = [] ; 
class OtherPost extends StatefulWidget {
  const OtherPost(this.db , this.user);
  final user ;
  final AppDatabase db ;

  @override
  _OtherPostState createState() => _OtherPostState();
}

class _OtherPostState extends State<OtherPost> {
  void addPostCard( String text , var postId){
  userPosts.add(new PostCard(text , widget.user , postId, widget.db));
}
void getAllUserPosts()async{
  var a = widget.user ;
  if (a != null){
    print("we are in get all posts");
    widget.db.postDao.findAllPosts(a).then((value) => setState((){
      if (value != null){
        print("the list of posts is not empty");
        for(int i = 0 ; i < value.length ; i++){
          print("inside for of list posts");
          // userPosts[i] = value[i];
          addPostCard(value[i].PostCaption , value[i].PostId);
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
void initState(){
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
      height: MediaQuery.of(context).size.height*0.8,
      width: MediaQuery.of(context).size.width*0.9,
      color: Colors.black87,
      child : Column(children: [
        Container(
          height: 30,
          alignment: Alignment.centerLeft,
          margin: EdgeInsets.only(left: 10 , top: 7),
          child:Text("POSTS" , style: TextStyle(color: Colors.white , fontSize: 15),) 
        ,),
        
        /*Flexible(child: ListView.builder(
        itemCount: list.length,
        itemBuilder: (_,index) => list[index]))*/
        Flexible(child: ListView.builder(
        itemCount: otherUserPosts.length,
        itemBuilder: (_,index) {
          return PostCard(otherUserPosts[index].caption , otherUserPosts[index].id, otherUserPosts[index].postId, widget.db);}))
        
        
        

      ],)




    );
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
  const HomePosts({ Key? key }) : super(key: key);

  @override
  _HomePostsState createState() => _HomePostsState();
}

class _HomePostsState extends State<HomePosts> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 20),
      height: MediaQuery.of(context).size.height*1,
      width: MediaQuery.of(context).size.width*0.9,
      color: Colors.black87,
      child : Column(children: [
        Container(
          padding: EdgeInsets.only(left: 10),
          height: 40,
          color: Colors.redAccent,
          child:Align(alignment: Alignment.centerLeft,
        child: Text("HOME POSTS" , style: TextStyle(color: Colors.white),)
        
        
        )
         ,),
        
        
      
        

      ],)

      
    );
  }
}