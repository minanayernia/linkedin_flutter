import 'package:dbproject/models/User.dart';
import 'package:floor/floor.dart';

// CREATE TABLE network  (     
//     networkId INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
//     netWorkDate DATETIME DEFAULT CURRENT_TIMESTAMP,
//     networkState INT ,
//     userReqId INT NOT NULL,
//     userId INT NOT NULL,
//     FOREIGN KEY (userId) REFERENCES Users (userId)

// )

@Entity(
  foreignKeys: [
    ForeignKey(
     childColumns: ['userReqId'],
     parentColumns: ['userId'], 
     entity: User),
    ForeignKey(
     childColumns: ['userId'], 
     parentColumns: ['userId'], 
     entity: User)

  ]
)
class Network {
  @PrimaryKey  (autoGenerate: true , )
  int? networkId ;

  @ColumnInfo(name: 'userReqId')
  int? userReqId ;

  @ColumnInfo(name: 'userId')
  int? userId;

  int? networkState  = 0 ; //if 0 => invitation is pending //if 1 => invitation is accepted

  Network({
    this.networkId ,
    required this.userReqId,
    required this.userId , 
  });
  
}

@dao 
abstract class NetworkDao{
  @Query('SELECT COUNT(*) FROM network WHERE networkState = 1 and (userId = :userId or userReqId = :userId)')
  Future<int?> countMutualConnection(int userId); 

  @Query('((SELECT userReqId as user_id FROM network WHERE userId = :userId) UNION (SELECT userId as user_id FROM network WHERE userReqId = :userId))') 
  Future<int?> AllUsersInYourNetwork(int userId);

  @insert 
  Future<void> insertNetwork(Network network);
}
