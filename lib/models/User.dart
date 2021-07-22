import 'dart:ffi';

import 'package:floor/floor.dart';
import 'package:flutter/cupertino.dart';

import 'TypeConverter.dart';
// import 'package:intl/intl.dart';

// CREATE TABLE users (
//     userId INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
//     userName VARCHAR (50),
//     Userpassword VARCHAR (50),
//     createdAt DATETIME DEFAULT CURRENT_TIMESTAMP
// )


@TypeConverters([DateTimeConverter])
@entity
class  User {
    
  @PrimaryKey (autoGenerate: true , ) 
  int? userId ;

  DateTime birthday ;

  // DateTime createdAt = DateTime.now() ;
  // var milliseconds = DateTime.now().millisecondsSinceEpoch ;
  // var createdAt = DateTime.fromMillisecondsSinceEpoch(DateTime.now().millisecondsSinceEpoch) ;

  String password;
  String userName ;

  User( {
    this.userId  , 
    required this.birthday ,
    required this.password ,
    required this.userName ,
    // this.userId
  }
  );
  
}
@TypeConverters([DateTimeConverter])
@dao
abstract class UserDao {


  @Query("SELECT * FROM User WHERE userName LIKE :userName")
  Future<List<User?>> searchByUsername(String userName);

  @Query('Delete FROM User')
  Future<void> deleteAllUsers();

  @Query('SELECT * FROM User where userId = :userId')
  Future<User?> findUserNameByUserId(int userId);

  @Query('SELECT * FROM User where password = :password and userName = :userName ')
  Future<User?> findUserByUsernamePassword(String password , String userName);

  @Query('SELECT * FROM User WHERE userName = :userName')
  Future<User?> findeUserByUserName(String userName);

  @Query('SELECT * FROM User')
  Future<List<User>>findAllusers();


  @insert
  Future<void> insertUser(User user);
  
} 