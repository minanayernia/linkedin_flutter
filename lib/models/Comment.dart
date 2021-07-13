import 'dart:html';

import 'package:dbproject/models/post.dart';
import 'package:floor/floor.dart';

import 'User.dart';

// CREATE TABLE comments (
//     commentId INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
//     commentText VARCHAR (500) ,
//     commentedAt DATETIME DEFAULT CURRENT_TIMESTAMP,
//     userId INT NOT NULL,
//     postId INT NOT NULL,
//     FOREIGN KEY (userId) REFERENCES Users (userId),
//     FOREIGN KEY (postId) REFERENCES Posts (postId)

// )



@Entity(foreignKeys:[
    ForeignKey(childColumns: ['userId'],
     parentColumns: ['userId'],
      entity: User ),
      ForeignKey(childColumns: ['postId'],
     parentColumns: ['postId'],
      entity: Post ),
      ForeignKey(childColumns: ['ReplyCommentId'],
      parentColumns: ['commentId'],
      entity: Comment ),
] )
class Comment {
  @PrimaryKey  (autoGenerate: true , ) 
  int? commentId ;

  String commentText;
  // final DateTime CommentedAt;
  @ColumnInfo(name: 'userId')
  int userId ;

  @ColumnInfo(name: 'postId')
  int postId ;

  @ColumnInfo(name: 'ReplyCommentId')
  int? ReplyCommentId ;
  Comment( this.postId , this.userId , this.commentText );
}

@dao 
abstract class CommentDao {
  @Query('SELECT COUNT(commentId) FROM comment WHERE postId = :postId')
  Future<int> commentNumber(int postId);

  @Query('SELECT * FROM comments  WHERE postId = :postId')
  Future<List<Comment>> findAllComment(int postId);

  @insert
  Future<void> insertCommentReply(Comment comment);

  @insert 
  Future<void> insertComment(int postId , int userId);
  
}