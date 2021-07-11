import 'package:floor/floor.dart';

@entity
class  User {
  @primaryKey
  final int userId ;
  User(this.userId);
}

@dao
abstract class UserDao {
  
} 