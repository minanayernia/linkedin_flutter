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

  Skill({  
    this.SkillId ,
    required this.SkillText ,
    required this.profileId});
}

@dao 
abstract class SkillDao {


  @Query('SELECT * FROM skill WHERE profileId = :profileId')
  Future<List<Skill?>> allSkills (int profileId);

  @Query('DELETE FROM Skill')
  Future<void> deleteSkills();

  @Query('SELECT * FROM Skill WHERE skillText = :skillText')
  Future<Skill?> findSkillByName(String skillText);

  @Query('SELECT * FROM Skill WHERE skillId = :id')
  Future<Skill?> findSkillById(int id);

  @Query('UPDATE skill SET skillText = :skillText WHERE skillId = :skillId')
  Future<Skill?> editSkill(String skillText , int skillId);
  
  @insert 
  Future<void>insertSkill(Skill skill);
  
}