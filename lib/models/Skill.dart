import 'package:floor/floor.dart';

// CREATE TABLE Skill (
//     SkillId INT PRIMARY KEY IDENTITY (1, 1),
//     SkillText VARCHAR (255) NOT NULL,
//     ProfileId INT NOT NULL,
//     FOREIGN KEY (ProfileId) REFERENCES UserProfile (ProfileId)
// );

@entity 
class Skill {
  @primaryKey
  final int SkillId ;
  final String SkillText ;
  final int ProfileId ;

  Skill(this.SkillId , this.SkillText , this.ProfileId);
}

@dao 
abstract class SkillDao {
  
}