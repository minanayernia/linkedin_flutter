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
  int? profileId;

  String? featuredText;
  int? postId ;

  Featured({
    this.featuredId ,
    this.postId ,
    this.featuredText,
    required this.profileId
  }
    
  );

}

@dao 
abstract class FeaturedDao {
  @Query('SELECT * FROM Featured WHERE profileId = :profileId')
  Future<List<Featured?>> allAdditionalInfo(int profileId);

  @Query('SELECT * FROM Featured WHERE postId = :postId')
  Future<Featured?> findFeatureByPostid(int postId) ;

  @Query('SELECT * FROM Featured WHERE featuredId = :featuredId and profileId = :profid')
  Future<Featured?> findFeaturedById(int featuredId , int profid);

  @Query('SELECT * FROM Featured WHERE featuredText = :featuredText and profileId = :profid')
  Future<Featured?> findFeaturedByText(String featuredText , int profid);

  @Query('UPDATE Featured SET featuredText = :featuredText WHERE featuredId = :featuredId')
  Future<Featured?> editFeatured(String featuredText , int featuredId);

  @Query('DELETE FROM Featured WHERE featuredId = :featuredId')
  Future<void> deleteFeatureById(int featuredId);

  @Query('DELETE FROM Featured WHERE postId = :postId')
  Future<void> deletePostFeature(int postId);

  @insert 
  Future<void> insertFeatured(Featured featured);
  
}