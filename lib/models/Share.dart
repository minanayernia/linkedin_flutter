import 'package:floor/floor.dart';

// CREATE TABLE Share (
//     ShareId INT PRIMARY KEY IDENTITY (1, 1),
//     SharedAt DATETIME DEFAULT CURRENT_TIMESTAMP,
//     UserId INT NOT NULL,
//     PostId INT NOT NULL,
//     FOREIGN KEY (UserId) REFERENCES Users (UserId),
//     FOREIGN KEY (PostId) REFERENCES Posts (PostId)

// );


@entity 
class Share {
  @primaryKey
  final int ShareId ;
  final DateTime SharedAt ;
  final int UserId ;
  final int PostId;

  Share(this.ShareId , this.UserId , this.PostId , this.SharedAt);
}

@dao 
abstract class ShareDao {
  
}