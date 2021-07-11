import 'package:floor/floor.dart';

// CREATE TABLE CommentsLike  (
//     CommentLikeId INT PRIMARY KEY IDENTITY (1, 1),
//     CommentLikedAt DATETIME DEFAULT CURRENT_TIMESTAMP,
//     UserId INT NOT NULL,
//     CommentId INT NOT NULL,
//     FOREIGN KEY (UserId) REFERENCES Users (UserId),
//     FOREIGN KEY (CommentId) REFERENCES Comments (CommentId)

// );

@entity 
class CommentLike {
  @primaryKey
  final int CommentLikeId ;
  final DateTime CommentLikedAt ;
  final int UserId ;
  final int CommentId ;


  CommentLike(this.CommentLikeId , this.UserId , this.CommentId , this.CommentLikedAt) ;
}