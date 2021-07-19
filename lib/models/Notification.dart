import 'package:dbproject/models/Network.dart';
import 'package:floor/floor.dart';

// CREATE TABLE notifications  (
//     notificationId INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
//     notifiactionedAt DATETIME DEFAULT CURRENT_TIMESTAMP,
//     notificationText VARCHAR (500) ,
//     notificationType VARCHAR (255) ,
//     networkId INT NOT NULL,
//     FOREIGN KEY (networkId) REFERENCES network (networkId)

// )

// @Entity(foreignKeys:[
//     ForeignKey(childColumns: ['networkId'],
//      parentColumns: ['networkId'],
//       entity: Network ),
// ] )
@entity
class Notificationn {
  @PrimaryKey  (autoGenerate: true , ) 
  int? notificationId;

  // @ColumnInfo(name: 'networkId')
  // int? networkId ;

  int? notificationType ;
  /*
  1 => birthday 
  2 => see profile
  3 => comment on your post
  4 => like your post
  5 => like or comment your comment
  6 => endorse your skill
  7 => your network job changed
  */
  int? sender ;
  int? receiver ;
  int? post ;
  int? comment ;

  Notificationn({
    this.notificationId ,
    this.post  ,
    this.comment  ,
    // required this.networkId ,
    required this.notificationType ,
    required this.receiver ,
    required this.sender 
  });
  
}

@dao 
abstract class NotificationnDao {

  @Query('SELECT * FROM Notificationn WHERE receiver = :receiver')
  Future<List<Notificationn?>> showNotif(int receiver);

  @insert 
  Future<void> insertNotif(Notificationn notif);
}