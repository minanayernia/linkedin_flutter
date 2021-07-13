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
  int? profileId ;

  String languageType;
  String LanguageName  ;
  final int ProfileId ;

  Language(this.languageType ,this.LanguageId , this.LanguageName , this.ProfileId );
}

@dao 
abstract class LanguageDao {

  @Query('SELECT * FROM Language WHERE profileId = :profileId')
  Future<List<Language>> allAdditionalInfo(int profileId);

  @Query('UPDATE language SET languageName = :languageName WHERE profileId in (SELECT profileId From userProfile WHERE userId = :userId')
  Future<Language> editLanguage(String LanguageName , int userId);

  @insert 
  Future<void> insertLanguage(Language language);
  
}