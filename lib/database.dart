// database.dart

// required package imports
import 'dart:async';
import 'package:dbproject/models/User.dart';
import 'package:dbproject/models/UserProfile.dart';
import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

// import 'dao/person_dao.dart';
import 'models/User.dart';
import 'models/post.dart'; 
part 'database.g.dart'; // 

@Database(version: 1, entities: [Post , User , UserProfile])
abstract class AppDatabase extends FloorDatabase {
  PostDao get postDao;
  UserDao get userDao;
  UserProfileDao get userProfileDao;
}