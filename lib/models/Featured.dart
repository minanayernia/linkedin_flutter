import 'dart:ffi';

import 'package:dbproject/models/UserProfile.dart';
import 'package:floor/floor.dart';

// CREATE TABLE featured (
//     featuredId INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
//     featuredText VARCHAR (255) NOT NULL,
//     profileId INT NOT NULL,
//     featuredAt DATETIME DEFAULT CURRENT_TIMESTAMP,
//     FOREIGN KEY (profileId) REFERENCES userProfile (profileId)
// )

@Entity(
  foreignKeys: [
    ForeignKey(
      childColumns: ['profileId'],
      parentColumns: ['ProfileId'],
      entity: UserProfile,
    )
  ],
)
class Featured{
  @PrimaryKey  (autoGenerate: true , ) 
  int? featuredId ;

  @ColumnInfo(name: 'profileId')
  int? userId;

  String featuredText;

  Featured(
    this.featuredText
  );

}

@dao 
abstract class FeaturedDao {
  @Query('UPDATE featured SET featuredText = :featuredText WHERE profileId in (SELECT profileId From userProfile WHERE userId = :userId')
  Future<Featured> editFeatured(String featuredText , int userId);

  @insert 
  Future<Void> insertFeatured(Featured featured);
  
}