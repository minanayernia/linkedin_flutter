import 'package:dbproject/models/post.dart';
import 'package:floor/floor.dart';

import 'User.dart';

// CREATE TABLE likes (
//     likeId INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
//     likedAt DATETIME DEFAULT CURRENT_TIMESTAMP,
//     userId INT NOT NULL,
//     postId INT NOT NULL,
//     FOREIGN KEY (userId) REFERENCES Users (userId),
//     FOREIGN KEY (postId) REFERENCES Posts (postId)

// )

@Entity(foreignKeys:[
    ForeignKey(childColumns: ['userId'],
     parentColumns: ['userId'],
      entity: User ),
      ForeignKey(childColumns: ['postId'],
     parentColumns: ['postId'],
      entity: Post ),
] )
class Like {
  @PrimaryKey  (autoGenerate: true , )
  int? LikeId ;
  // final DateTime LikedAt ;
  @ColumnInfo(name: 'userId')
  int userId ;

  @ColumnInfo(name: 'postId')
  int PostId ;

  Like(this.userId , this.PostId);
}

@dao 
abstract class LikeDao {

  @Query('SELECT COUNT(likeId) FROM likes WHERE postId = :postId')
  Future<int> likeNumbers(int postId);
  
  @insert
  Future<void> insertLike(Like like);
}