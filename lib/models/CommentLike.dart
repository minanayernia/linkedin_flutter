import 'package:dbproject/models/User.dart';
import 'package:floor/floor.dart';

import 'Comment.dart';

// CREATE TABLE commentsLike  (
//     commentLikeId INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
//     commentLikedAt DATETIME DEFAULT CURRENT_TIMESTAMP,
//     userId INT NOT NULL,
//     commentId INT NOT NULL,
//     FOREIGN KEY (userId) REFERENCES Users (userId),
//     FOREIGN KEY (commentId) REFERENCES Comments (commentId)

// )

@Entity(foreignKeys:[
    ForeignKey(childColumns: ['userId'],
     parentColumns: ['userId'],
      entity: User ),
      ForeignKey(childColumns: ['commentId'],
      parentColumns: ['commentId'],
      entity: Comment ),
] )
class CommentLike {
  @PrimaryKey  (autoGenerate: true , ) 
  int? commentLikeId ;
  // final DateTime CommentLikedAt ;
  @ColumnInfo(name: 'userId')
  int userId ;

  @ColumnInfo(name: 'commentId')
  int commentId ;


  CommentLike( {
    this.commentLikeId ,
    required this.userId ,
    required this.commentId }) ;
}

@dao abstract class CommentLikeDao {

  @Query('SELECT COUNT(commentLikeId) FROM commentLike WHERE commentId = :commentId')
  Future<int?> commentLikenNumber(int commentId);

  @Query('SELECT * FROM CommentLike WHERE userId = :userId AND commentId  = :commentId')
  Future<CommentLike?> findCommentLikeBYUseridCommentId(int userId , int commentId);


  @Query('SELECT * FROM CommentLike WHERE commentId = :commentId')
  Future<List<CommentLike?>> commentLikes(int commentId);
  
  
  @insert
  Future<void> insertCommentLike(CommentLike commentLike);
}