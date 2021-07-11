import 'package:floor/floor.dart';

// CREATE TABLE Accomplishments (
//     AcomplishmentId INT PRIMARY KEY IDENTITY (1, 1),
//     AccomplishmentText VARCHAR (255) NOT NULL,
//     ProfileId INT NOT NULL,
//     FOREIGN KEY (ProfileId) REFERENCES UserProfile (ProfileId)
// );

@entity 
class Accomplishment {
  @primaryKey
  final int AcomplishmentId  ;
  final String AccomplishmentText ;
  final int ProfileId ;

  Accomplishment(this.AcomplishmentId ,this.AccomplishmentText , this.ProfileId );
}

@dao 
abstract class AccomplishmentDao {
  
}