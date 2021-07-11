import 'package:floor/floor.dart';

// CREATE TABLE Language (
//     LanguageId INT PRIMARY KEY IDENTITY (1, 1),
//     Lang VARCHAR (255) NOT NULL,
//     ProfileId INT NOT NULL,
//     FOREIGN KEY (ProfileId) REFERENCES UserProfile (ProfileId)
// );


@entity 
class Language  {
  @primaryKey
  final int LanguageId ;

  final String Lang  ;
  final int ProfileId ;

  Language(this.LanguageId , this.Lang , this.ProfileId );
}