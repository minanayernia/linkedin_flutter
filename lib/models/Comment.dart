

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
] 

)
class Comment {
  @PrimaryKey  (autoGenerate: true , ) 
  int? commentId ;

  String commentText;
  int is_replied = 0 ; // if 0 => not replied if 1 => replied
  // final DateTime CommentedAt;
  @ColumnInfo(name: 'userId')
  int userId ;

  @ColumnInfo(name: 'postId')
  int postId ; 

  int? ReplyCommentId ;

  Comment( {
    this.commentId ,
    this.ReplyCommentId,
    required this.postId ,
    required this.userId ,
    required this.commentText} );
}

@dao 
abstract class CommentDao {
  @Query('SELECT COUNT(commentId) FROM comment WHERE postId = :postId')
  Future<int?> commentNumber(int postId);

  @Query('UPDATE Comment SET ReplyCommentId = :ReplyCommentId AND is_replied = 1')
  Future<Comment?> updateCommentForReply(int ReplyCommentId);

  @Query('SELECT * FROM comment  WHERE postId = :postId')
  Future<List<Comment>> findAllComment(int postId);

  @Query('SELECT * From Comment WHERE commentId = :commentId')
  Future<Comment?> findCommentBycommentId(int commentId);


  @insert
  Future<int?> insertComment(Comment comment);

  
}