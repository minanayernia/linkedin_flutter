import 'dart:ffi';

import 'package:floor/floor.dart';
import 'package:flutter/cupertino.dart';

@entity
class  User {
  @PrimaryKey (autoGenerate: true , ) 
  int? userId ;
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