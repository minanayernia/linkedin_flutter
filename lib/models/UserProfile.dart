import 'dart:ffi';
import 'dart:typed_data';

import 'package:dbproject/models/User.dart';
import 'package:floor/floor.dart';

// CREATE TABLE userProfile(
//     profileId INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
//     firstName VARCHAR (50),
//     lastName VARCHAR (50),
//     about VARCHAR (255),
//     location VARCHAR (255),
//     birthDate DATE ,
//     userId INT NOT NULL,
//     background VARCHAR (255),
//     createdAt DATETIME DEFAULT CURRENT_TIMESTAMP
    
// )

@Entity(
  foreignKeys: [
    ForeignKey(
      childColumns: ['userId'],
      parentColumns: ['userId'],
      entity: User,
    )
  ],
)
class UserProfile {
  @PrimaryKey  (autoGenerate: true , ) 
  int? ProfileId ;

  @ColumnInfo(name: 'userId')
  int? userId;

  String FirstName ;
  String LastName ;
  // String UserName ;
  String About ;
  // String AdditionalInfo;
  String location ;
  // Uint8List? background;

  UserProfile({
    // this.picture = "not_fileed" ,
    this.ProfileId ,
    // this.background ,
    required this.userId ,
    
    this.location = "not_filled" ,
    this.FirstName = "not_filled" ,
    this.LastName = "not_filled", 
    // this.UserName = "not_filled" , 
    // this.AdditionalInfo = "not_filled", 
    this.About = "not_filled",
  }
   );
}

@dao
abstract class UserProfileDao {

  @Query('SELECT * FROM userProfile WHERE userId = :userId')
  Future<UserProfile?> findProfileByUserId(int userId);

  @Query('DELETE FROM UserProfile')
  Future<void> deletAllProfile();

  // @Query('SELECT * FROM UserProfile WHERE userId = :userId')
  // Future<UserProfile?> getUserProfile(int userId);

  @Query('UPDATE UserProfile SET about = :about WHERE userId = :userId ')
  Future<UserProfile?> editAbout(int userId , String about);

  @Query('UPDATE UserProfile SET firstName = :firstname , lastName = :lastname, about =  :about , location = :location   WHERE userId =  :userId')
  Future<UserProfile?> editAllProfile(int userId, String firstname , String lastname , String about  , String location );

  @Query('SELECT * FROM userProfile WHERE location LIKE :location')
  Future<List<UserProfile>> filterByLocation(String location);

  @Query('SELECT * FROM userProfile WHERE profileId in (SELECT  profileId from additionalInfo where CompanyName LIKE :CompanyName)')
  Future<List<UserProfile>> filterByCompanyname(String CompanyName);

  @Query('SELECT * FROM userProfile WHERE profileId in (SELECT  profileId from additionalInfo where jobId = :jobid AND CompanyName LIKE :CompanyName)')
  Future<UserProfile?> findProfileByJobId(String CompanyName , int jobid);

  @insert
  Future<void> insertUserProfile(UserProfile userProfile);
  
}