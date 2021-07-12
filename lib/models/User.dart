import 'dart:ffi';

import 'package:floor/floor.dart';
import 'package:flutter/cupertino.dart';
// import 'package:intl/intl.dart';

// CREATE TABLE users (
//     userId INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
//     userName VARCHAR (50),
//     Userpassword VARCHAR (50),
//     createdAt DATETIME DEFAULT CURRENT_TIMESTAMP
// )



@entity
class  User {
  @PrimaryKey (autoGenerate: true , ) 
  int? userId ;
  // DateTime createdAt = DateTime.now() ;
  // var milliseconds = DateTime.now().millisecondsSinceEpoch ;
  // var createdAt = DateTime.fromMillisecondsSinceEpoch(DateTime.now().millisecondsSinceEpoch) ;

  @required final String password;
  @required final String userName ;

  User( 
    // this.userId  , 
     this.password ,
    this.userName ,
    
  );
  
}

@dao
abstract class UserDao {
  @Query('SELECT userId FROM User where password = :password and userName = :userName ')
  Stream<User?> findUserByUsernamePassword(String password , String userName);

  @Query('SELECT * FROM User')
  Future<List<User>>findAllusers();

  @insert
  Future<void> insertUser(User user);
  
} 