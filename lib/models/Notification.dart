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

@Entity(foreignKeys:[
    ForeignKey(childColumns: ['networkId'],
     parentColumns: ['networkId'],
      entity: Network ),
] )
class Notification {
  @PrimaryKey  (autoGenerate: true , ) 
  int? notificationId;

  @ColumnInfo(name: 'networkId')
  int networkId ;

  int notificationType ;

  Notification({
    this.notificationId ,
    required this.networkId ,
    required this.notificationType
  });
  
}