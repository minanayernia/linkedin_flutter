
import 'package:flutter/material.dart';

class PostCard extends StatelessWidget {
  const PostCard({ Key ?key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height*0.9,
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
          TextButton(onPressed: (){}, child: Text("Comment")),
          TextButton(onPressed: (){}, child: Text("Share"))
        ],)
      ],),

      
    );
  }
}

class PostList extends StatelessWidget {
  const PostList({ Key ?key }) : super(key: key);

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
         NewPostCard(),
        NewCommentCard()
          
        ],),
      ),)
        
        

      ],)
      


     
      
    );
  }
}



class AddPost extends StatefulWidget {
  const AddPost({ Key ?key }) : super(key: key);

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
  @override
  Widget build(BuildContext context) {
    return Container(

      margin: EdgeInsets.only(top: 20),
      height: MediaQuery.of(context).size.height*0.8,
      width: MediaQuery.of(context).size.width*0.9,
      color: Colors.black87,
      child : Column(children: [
        Container(
          child:Align(alignment: Alignment.centerRight,
        child: TextButton(onPressed: addSkillCard, child: Text("NEW POST")),) ,),
        
        Flexible(child: ListView.builder(
        itemCount: list.length,
        itemBuilder: (_,index) => list[index]))
      
        

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

class NewPostCard extends StatelessWidget {
  const NewPostCard({ Key ?key }) : super(key: key);

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
          child: RaisedButton(onPressed: (){}
          ,
           child: Text("Send" , style: TextStyle(color: Colors.white),))
           )
        


        ],
      ),

      
    );
  }
}


class NewCommentCard extends StatelessWidget {
  const NewCommentCard({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 20),
      height: 130,
      width: MediaQuery.of(context).size.width*0.86,
      color: Colors.white30,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [

          Container(
            padding: EdgeInsets.only(left: 10),
          alignment: Alignment.centerLeft,  
          child: Text("User" , style: TextStyle(color: Colors.white),),) ,

          TextField(
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
            height: MediaQuery.of(context).size.height*0.6,
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


class OtherPost extends StatelessWidget {
  const OtherPost({ Key? key }) : super(key: key);

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
        Container(
          height: 500,
          child:SingleChildScrollView(child: Column(children: [
          PostCard(),
        ],),
        ) ,)
        
        
        

      ],)
      
      
      
    );
  }
}