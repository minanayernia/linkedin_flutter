import 'package:floor/floor.dart';

// CREATE TABLE Endorse (
//     EndorseId INT PRIMARY KEY IDENTITY (1, 1),
//     EndorseAt DATETIME DEFAULT CURRENT_TIMESTAMP,
//     UserId INT NOT NULL,
//     SkillId INT NOT NULL,
//     FOREIGN KEY (UserId) REFERENCES Users (UserId),
//     FOREIGN KEY (SkillId) REFERENCES Skills (SkillId)
// );

@entity 
class Endorse  {
  @primaryKey
  final int EndorseId ;
  final DateTime EndorseAt;
  final int UserId;
  final int SkillId;


  Endorse(this.EndorseId , this.EndorseAt , this.UserId , this.SkillId);
}

@dao 
abstract class EndorseDao {
  
}