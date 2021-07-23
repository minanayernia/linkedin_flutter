import 'package:dbproject/models/User.dart';
import 'package:floor/floor.dart';

// CREATE TABLE messages  (
//     messageId INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
//     recieverId INT NOT NULL ,
//     senderId INT NOT NULL,
//     archived INT,
//     unread INT ,
//     deleted INT ,
//     messageText VARCHAR (500) ,
//     messagedAt DATETIME DEFAULT CURRENT_TIMESTAMP

// )

@Entity(foreignKeys: [
  ForeignKey(
      childColumns: ['recieverId'], parentColumns: ['userId'], entity: User),
  ForeignKey(
      childColumns: ['senderId'], parentColumns: ['userId'], entity: User),
])
class Messagee {
  @PrimaryKey(
    autoGenerate: true,
  )
  int? messageId;

  @ColumnInfo(name: 'recieverId')
  int recieverId;

  @ColumnInfo(name: 'senderId')
  int senderId;

  String messageText ;
  int archived = 0;
  int unread = 0;
  int deleted = 0;

  Messagee({
    this.messageId,
    required this.recieverId,
    required this.senderId,
    required this.messageText,
  });
}

@dao 
abstract class MessageeDao {
  @Query('SELECT * FROM Messagee WHERE (senderId =:myid OR recieverId = :myid) AND messageText LIKE :text')
  Future<List<Messagee?>> searchMessage(int myid , String text);

  @Query('SELECT * FROM Messagee WHERE (senderId = :myid and recieverId = :otherId) or (senderId = :otherId and recieverId = :myid)')
  Future<List<Messagee?>> showMessage(int myid , int otherId);

  @insert
  Future<void> insertMessage(Messagee msg);
}
