

import 'package:flutter/cupertino.dart';
import 'package:sqflite/sqflite.dart';
import 'package:floor/floor.dart';

import 'User.dart';


// CREATE TABLE posts (
//     postId INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
//     postCaption VARCHAR (500) ,
//     postImage VARCHAR (500) ,
//     userId INT NOT NULL,
//     postAt DATETIME DEFAULT CURRENT_TIMESTAMP,
//     FOREIGN KEY (userId) REFERENCES users (userId)
// )

@Entity(foreignKeys:[
    ForeignKey(childColumns: ['userId'],
     parentColumns: ['userId'],
      entity: User ),
] )
class Post {
  @PrimaryKey  (autoGenerate: true , ) 
  int? PostId ;

  String PostCaption ;

  @ColumnInfo(name: 'userId')
  int userId ;
  // final DateTime EndorseAt;

  Post({
    this.PostId,
    required this.PostCaption , 
    required this.userId});
}




@dao
abstract class PostDao {
  @Query('SELECT * FROM Post WHERE userId = :userId')
  Future<List<Post>> findAllPosts(int userId);

  @insert
  Future<void> insertPost(Post post);
}
