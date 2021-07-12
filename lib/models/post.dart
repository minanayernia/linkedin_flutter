

import 'package:flutter/cupertino.dart';
import 'package:sqflite/sqflite.dart';
import 'package:floor/floor.dart';


// CREATE TABLE Posts (
//     PostId INT PRIMARY KEY IDENTITY (1, 1),
//     PostCaption VARCHAR (500) ,
//     PostImage VARCHAR (500) ,
//     USerId INT NOT NULL,
//     EndorseAt DATETIME DEFAULT CURRENT_TIMESTAMP,
//     FOREIGN KEY (UserId) REFERENCES Users (UserId)
// );

@entity
class Post {
  @primaryKey
  final int PostId ;
  final String PostCaption ;
  final int owner ;
  final int USerId ;
  // final DateTime EndorseAt;

  Post(this.PostId, this.PostCaption ,this.owner , this.USerId);
}




@dao
abstract class PostDao {
  // @Query('SELECT * FROM Person')
  // Future<List<Post>> findAllPersons();

  // @Query('SELECT * FROM Person WHERE id = :id')
  // // Stream<Post?> findPersonById(int id);

  // @insert
  // Future<void> insertPerson(Post post);
}

// class Post{
//   final int post_id ;
//   final String caption ;
//   final int owner ;

//   Post({
//     @required this.post_id ,
//     @required this.caption ,
//     @required this.owner ,
//   });
//   Map<String , dynamic> toMap(){
//     return {
//      'post_id' : post_id ,
//      'caption' : caption ,
//      'owner': owner ,
//     };
//     @override
//     String toString(){
//       return 'Post{post_id : $post_id , caption : $caption , $owner : owner }' ;
//     }
//   }
// }
