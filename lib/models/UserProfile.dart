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
  String UserName ;
  String About ;
  String AdditionalInfo;
  String location ;
  // final Uint8List picture;

  UserProfile({
    // this.picture = "not_fileed" ,
    required this.userId ,
    this.location = "not_filled" ,
    // this.ProfileId = "not_filled" ,
    this.FirstName = "not_filled" ,
    this.LastName = "not_filled", 
    this.UserName = "not_filled" , 
    this.AdditionalInfo = "not_filled", 
    this.About = "not_filled",
  }
   );
}

@dao
abstract class UserProfileDao {

  @Query('SELECT * FROM userProfile WHERE userId = :userId')
  Future<UserProfile?> findProfileByUserId(int userId);

  @Query('UPDATE userProfile SET about = :about WHERE userId = :userId ')
  Future<UserProfile?> editAbout(int userId , String about);

  @Query('UPDATE userProfile SET firstName = :firstname , lastName = :lastname, about =  :about , additionalInfo = :additionalInfo  WHERE userId =  :userId')
  Future<UserProfile?> editAllProfile(int userId, String firstname , String lastname , String about , String additionalInfo );

  @insert
  Future<void> insertUserProfile(UserProfile userProfile);
  
}