import 'dart:ffi';

import 'package:dbproject/models/post.dart';
import 'package:floor/floor.dart';

import 'User.dart';

// CREATE TABLE share (
//     shareId INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
//     sharedAt DATETIME DEFAULT CURRENT_TIMESTAMP,
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
class Share {
  @PrimaryKey  (autoGenerate: true , )
  int? ShareId ;
  // final DateTime SharedAt ;
  @ColumnInfo(name: 'userId')
  int userId ;

  @ColumnInfo(name: 'postId')
  int postId ;

  Share( this.userId , this.postId );
}

@dao 
abstract class ShareDao {

  
  @insert 
  Future<void> insertShare(Share share);
}