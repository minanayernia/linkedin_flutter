import 'dart:ffi';

import 'package:floor/floor.dart';
import 'package:dbproject/models/UserProfile.dart';

// CREATE TABLE languages (
//     languageId INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
//     language VARCHAR (255) NOT NULL,
//     languageType VARCHAR (255),
//     profileId INT NOT NULL,
//     FOREIGN KEY (profileId) REFERENCES userProfile (profileId)
// )


@Entity(foreignKeys:[
    ForeignKey(childColumns: ['profileId'],
     parentColumns: ['profileId'],
      entity: UserProfile ),
] )
class Language  {
  @PrimaryKey  (autoGenerate: true , ) 
  int? LanguageId ;

  @ColumnInfo(name: 'profileId')
  int profileId ;

  String? languageType;
  String LanguageName  ;


  Language({this.languageType ,
  this.LanguageId , 
   required this.LanguageName , 
  required this.profileId });
}

@dao 
abstract class LanguageDao {

  @Query('SELECT * FROM Language WHERE profileId = :profileId')
  Future<List<Language>> allAdditionalInfo(int profileId);


  @Query('SELECT * FROM Language WHERE LanguageName = :languageText and profileId = :profid')
  Future<Language?> findLanguageByName(String languageText , int profid);

   @Query('SELECT * FROM Language WHERE LanguageId = :id and profileId = :profid')
  Future<Language?> findLanguageById(int id , int profid);

  @Query('UPDATE language SET LanguageName = :LanguageName WHERE LanguageId = :languageId')
  Future<void> editLanguage(String LanguageName , int languageId);

  @insert 
  Future<void> insertLanguage(Language language);
  
}