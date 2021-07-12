import 'dart:ffi';

import 'package:floor/floor.dart';

@entity
class  User {
  @PrimaryKey (autoGenerate: true , ) 
  int? userId ;
  final int password;
  final String userName ;

  User( this.password , this.userName);
}

@dao
abstract class UserDao {
  @Query('SELECT userId FROM User where password = :password and userName = :userName ')
  Stream<User?> findUserByUsernamePassword(int password , String userName);

  @Query('SELECT * FROM User')
  Future<List<User>>findAllusers();

  @insert
  Future<void> insertUser(User user);
  
} 