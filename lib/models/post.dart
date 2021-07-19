

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

  int? sharedPost;

  @ColumnInfo(name: 'userId')
  int userId ;
  // final DateTime EndorseAt;

  Post({
    this.PostId,
    this.sharedPost ,
    required this.PostCaption , 
    required this.userId});
}




@dao
abstract class PostDao {
  @Query('SELECT * FROM Post WHERE userId = :userId')
  Future<List<Post>> findAllPosts(int userId);

  @Query('SELECT * FROM post WHERE userId in (select DISTINCT userReqId from network WHERE networkState = 1 and userId = :userId UNION select DISTINCT userId from network WHERE networkState = 1 and userReqId = :userId)')
  Future<List<Post>> allNetworkPosts(int userId);

  @Query('SELECT * FROM post  WHERE postId in (select DISTINCT postId from Like WHERE userId in (SELECT DISTINCT userReqId FROM Network WHERE networkState = 1 and userId = :userId UNION SELECT DISTINCT userId FROM Network WHERE networkState = 1 and userReqId = :userId ) )')
  Future<List<Post>> postlikedByNetwork(int userId) ;

  @Query('SELECT * FROM post WHERE postId in (select DISTINCT postId from comment WHERE userId in (select DISTINCT userReqId from network WHERE networkState = 1 and userId = :userId UNION SELECT DISTINCT userId FROM Network WHERE networkState = 1 and userReqId = :userId ))')
  Future<List<Post>> postCommentedByNetwork(int userId) ;

  @Query('SELECT * from post WHERE postId = :postId')
  Future<Post?> findPostByPostId(int postId);

  @insert
  Future<void> insertPost(Post post);
}
