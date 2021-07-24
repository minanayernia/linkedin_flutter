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

  AdditionalInfo({
    this.jobId,
    required this.companyName ,
    required this.jobName,
    required this.profileId,
    }

  );


}

@dao 
abstract class AdditionalInfoDao {

  @Query('SELECT * FROM AdditionalInfo WHERE profileId = :profileId')
  Future<List<AdditionalInfo>> allAdditionalInfo(int profileId);


  @Query('SELECT * FROM AdditionalInfo WHERE jobId = :jobid and profileId = :profid')
  Future<AdditionalInfo?> findAdditionalInfoById(int jobid , int profid);

  @Query('SELECT * FROM AdditionalInfo WHERE jobName = :jobname and companyName = :companyname and profileId = :profid')
  Future<AdditionalInfo?> findAdditionalInfoByText(String jobname ,  String companyname , int profid);
  
  @Query('UPDATE AdditionalInfo SET jobName = :jobname , companyName = :companyname WHERE jobId = :jobid ')
  Future <void> editAditinallInfo(String jobname , String companyname ,  int jobid);

  @Query('SELECT * FROM AdditionalInfo WHERE profileId = :profid')
  Future<List<AdditionalInfo>> findJobById(int profid);

  @Query('DELETE FROM AdditionalInfo WHERE jobId = :jobId')
  Future<void> deleteJobByjobid(int jobId);
  
  @insert 
  Future<void> insertAditionalInfo(AdditionalInfo additionalInfo);
}