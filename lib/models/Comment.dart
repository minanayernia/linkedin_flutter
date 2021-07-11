import 'package:floor/floor.dart';

// CREATE TABLE Comments (
//     CommentId INT PRIMARY KEY IDENTITY (1, 1),
//     CommentText VARCHAR (500) ,
//     CommentedAt DATETIME DEFAULT CURRENT_TIMESTAMP,
//     UserId INT NOT NULL,
//     PostId INT NOT NULL,
//     ReplyCommentId INT NOT NULL,
//     FOREIGN KEY (ReplyCommentId) REFERENCES comments(CommentId)
//     FOREIGN KEY (UserId) REFERENCES Users (UserId),
//     FOREIGN KEY (PostId) REFERENCES Posts (PostId)

// );


@entity 
class Comment {
  @primaryKey 
  final int CommentId ;
  final String CommentText;
  final DateTime CommentedAt;
  final int UserId ;
  final int PostId ;
  final int ReplyCommentId ;
  Comment(this.CommentId , this.PostId , this.UserId , this.CommentText , this.CommentedAt , this.ReplyCommentId );
}