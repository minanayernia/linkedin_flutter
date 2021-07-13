import 'package:floor/floor.dart';

import 'UserProfile.dart';

// CREATE TABLE accomplishments (
//     acomplishmentId INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
//     accomplishmentText VARCHAR (255) NOT NULL,
//     profileId INT NOT NULL,
//     FOREIGN KEY (profileId) REFERENCES userProfile (profileId)
// )

@Entity(foreignKeys:[
    ForeignKey(childColumns: ['profileId'],
     parentColumns: ['profileId'],
      entity: UserProfile ),
] )
class Accomplishment {
  @PrimaryKey  (autoGenerate: true , ) 
  int? AcomplishmentId  ;

  @ColumnInfo(name: 'profileId')
  int profileId ;

  String AccomplishmentText ;

  Accomplishment(this.AcomplishmentId ,this.AccomplishmentText , this.profileId);
}

@dao 
abstract class AccomplishmentDao {
  @Query('SELECT * FROM Accomplishment WHERE profileId = :profileId')
  Future<List<Accomplishment>> allAccomplishments (int profileId);

  @Query('UPDATE accomplishments SET accomplishmentText =  :accomplishmentText WHERE profileId in (SELECT profileId From userProfile WHERE userId = :userId')
  Future<Accomplishment> editAccomplishment(String accomplishmentText ,String userId);
  @insert 
  Future<void> insertAccomplishment(Accomplishment accomplishment);

}