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

  Accomplishment({this.AcomplishmentId ,
   required this.AccomplishmentText ,
    required this.profileId});
}

@dao 
abstract class AccomplishmentDao {
  @Query('SELECT * FROM Accomplishment WHERE profileId = :profileId')
  Future<List<Accomplishment?>> allAccomplishments(int profileId);

  @Query('SELECT * FROM Accomplishment WHERE AcomplishmentId = :id and profileId = :profid')
  Future<Accomplishment?> findAccomplishmentById(int id , int profid);

  @Query('SELECT * FROM Accomplishment WHERE AccomplishmentText = :AccomplishmentText and profileId = :profid')
  Future<Accomplishment?> findAccomplishmentByText(String AccomplishmentText , int profid);

  @Query('UPDATE Accomplishment SET AccomplishmentText =  :accomplishmentText WHERE  AcomplishmentId = :accomplishmentId')
  Future<Accomplishment?> editAccomplishment(String accomplishmentText ,int accomplishmentId);

  @Query('DELETE FROM Accomplishment WHERE AcomplishmentId = :AcomplishmentId')
  Future<void> deleteAccomplishmentById(int AcomplishmentId);
  @insert 
  Future<void> insertAccomplishment(Accomplishment accomplishment);

}