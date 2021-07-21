import 'dart:ffi';

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

  @Query('(SELECT * FROM network WHERE userId = :userId AND networkState = 1 UNION SELECT * FROM network WHERE userReqId = :userId AND networkState = 1)') 
  Future<List<Network?>> AllUsersInYourNetwork(int userId);

  @Query('(SELECT userReq FROM network WHERE userId = :userId UNION SELECT userId FROM network WHERE userReqId = :userId)')
  Future<int?> findMyNetwork(int userId);


  @Query('UPDATE Network SET networkState = 1 WHERE networkId = :networkId')
  Future<Network?> acceptInvitation(int networkId);

  @Query('SELECT * FROM Network WHERE networkState = 0 and userId = :yourId')
  Future<List<Network?>> invitations(int yourId);

  @Query('SELECT * FROM Network WHERE (userId = :myuser and userReqId = :anotheruser AND networkState = 1) or (userId = :anotheruser and userReqId = :myuser AND networkState = 1)')
  Future<Network?> findNetwork(int myuser , int anotheruser);

    @Query('SELECT * FROM Network WHERE (userId = :myuser and userReqId = :anotheruser AND networkState = 0) or (userId = :anotheruser and userReqId = :myuser AND networkState = 0)')
  Future<Network?> findUnAcceptedNetwork(int myuser , int anotheruser);

  @Query('DELETE FROM Network WHERE userReqId = :anotheruser and userId = :myid')
  Future<void> deletNetwork(int anotheruser , int myid);

  @Query('SELECT * FROM Network WHERE networkId = :networkid and (userReqId = :id or userId = :id)')
  Future<Network?> findNetworkByoneIdNetworkid(int networkid , int id );

  @Query('SELECT * FROM Network WHERE networkState = 1 AND userReqId = :userId or ( networkState = 1 and userId = :userId )')
  Future<List<Network?>> allNetwork(int userId);

  @insert 
  Future<void> insertNetwork(Network network);
}
