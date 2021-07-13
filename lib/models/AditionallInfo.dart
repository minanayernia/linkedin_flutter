import 'dart:ffi';

import 'package:dbproject/models/UserProfile.dart';
import 'package:floor/floor.dart';

// CREATE TABLE additionalInfo (
//     jobId INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
//     jobName VARCHAR (255) NOT NULL,
//     companyName VARCHAR (255),
//     profileId INT NOT NULL,
//     getJobAt DATETIME DEFAULT CURRENT_TIMESTAMP,
//     FOREIGN KEY (profileId) REFERENCES userProfile (profileId)
// )

@Entity(foreignKeys:[
    ForeignKey(childColumns: ['profileId'],
     parentColumns: ['profileId'],
      entity: UserProfile )
] ) 
class AdditionalInfo {
  @PrimaryKey  (autoGenerate: true , ) 
  int?  jobId ;

  @ColumnInfo(name: 'profileId')
  int? profileId ;

  String companyName ;
  String jobName ;

  AdditionalInfo(
    this.companyName ,
    this.jobName
  );


}

@dao 
abstract class AdditionalInfoDao {

  @Query('SELECT * FROM AdditionalInfo WHERE profileId = :profileId')
  Future<List<AdditionalInfo>> allAdditionalInfo(int profileId);
  
  @Query('UPDATE AdditionalInfo SET jobName = :jobName WHERE profileId in (SELECT profileId From userProfile WHERE userId = :userId')
  Future <AdditionalInfo> editAditinallInfo(String jobName , int userId , );
  @insert 
  Future<Void> insertAditionalInfo(AdditionalInfo additionalInfo);
}