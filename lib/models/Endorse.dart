import 'dart:ffi';

import 'package:dbproject/models/Skill.dart';
import 'package:dbproject/models/User.dart';
import 'package:floor/floor.dart';

// CREATE TABLE endorse (
//     endorseId INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
//     endorseAt DATETIME DEFAULT CURRENT_TIMESTAMP,
//     userId INT NOT NULL,
//     skillId INT NOT NULL,
//     FOREIGN KEY (userId) REFERENCES Users (userId),
//     FOREIGN KEY (skillId) REFERENCES Skills (skillId)

// )

@Entity(foreignKeys:[
    ForeignKey(childColumns: ['userId'],
     parentColumns: ['userId'],
      entity: User ),
      ForeignKey(childColumns: ['skillId'],
      parentColumns: ['skillId'],
      entity: Skill ),
] )
class Endorse  {
  @PrimaryKey  (autoGenerate: true , ) 
  int? endorseId ;
  // final DateTime EndorseAt;
  @ColumnInfo(name: 'userId')
  int userId;

  @ColumnInfo(name: 'skillId')
  int skillId;


  Endorse( this.userId , this.skillId);
}

@dao 
abstract class EndorseDao {
  @insert
  Future<void> insertEndorse(Endorse endorse);
}