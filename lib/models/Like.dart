import 'package:floor/floor.dart';

// CREATE TABLE Likes (
//     LikeId INT PRIMARY KEY IDENTITY (1, 1),
//     LikedAt DATETIME DEFAULT CURRENT_TIMESTAMP,
//     UserId INT NOT NULL,
//     PostId INT NOT NULL,
//     FOREIGN KEY (UserId) REFERENCES Users (UserId),
//     FOREIGN KEY (PostId) REFERENCES Posts (PostId)

// );

@entity 
class Like {
  @primaryKey 
  final int LikeId ;
  final DateTime LikedAt ;
  final int UserId ;
  final int PostId ;

  Like(this.LikeId , this.PostId , this.UserId , this.LikedAt);
}

@dao 
abstract class LikeDao {
  
}