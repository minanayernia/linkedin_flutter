import 'package:floor/floor.dart';

import 'UserProfile.dart';

// CREATE TABLE Skill (
//     SkillId INT PRIMARY KEY IDENTITY (1, 1),
//     SkillText VARCHAR (255) NOT NULL,
//     ProfileId INT NOT NULL,
//     FOREIGN KEY (ProfileId) REFERENCES UserProfile (ProfileId)
// );

@Entity(foreignKeys:[
    ForeignKey(childColumns: ['profileId'],
     parentColumns: ['profileId'],
      entity: UserProfile ),
] )
class Skill {
  @PrimaryKey  (autoGenerate: true , ) 
  int? SkillId ;

  String SkillText ;
  
  @ColumnInfo(name: 'profileId')
  int profileId ;

  Skill( this.SkillText , this.profileId);
}

@dao 
abstract class SkillDao {


  @Query('SELECT * FROM skill WHERE profileId = :profileId')
  Future<List<Skill?>> allSkills (int profileId);

  

  @Query('UPDATE skill SET skillText = :skillText WHERE profileId in (SELECT profileId From userProfile WHERE userId = :userId')
  Future<Skill?> editSkill(String skillText , int userId);
  @insert 
  Future<void>insertSkill(Skill skill);
  
}