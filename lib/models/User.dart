import 'dart:ffi';

import 'package:floor/floor.dart';

@entity
class  User {
  @primaryKey
  final int userId ;
  final int password;
  final String userName ;

  User(this.userId , this.password , this.userName);
}

@dao
abstract class UserDao {
  @Query('SELECT * from User where password = :password and userName = :userName ')
  Stream<User?> findUaerByUsernamePassword(int password , String userName);

  @Query('SELECT * FROM User')
  Future<List<User>>findAllusers();

  @insert
  Future<void> insertUser(User user);
  
} 