// database.dart

// required package imports
import 'dart:async';
import 'package:dbproject/models/Featured.dart';
import 'package:dbproject/models/Like.dart';
import 'package:dbproject/models/Network.dart';
import 'package:dbproject/models/User.dart';
import 'package:dbproject/models/UserProfile.dart';
import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

// import 'dao/person_dao.dart';
import 'models/Skill.dart';
import 'models/Accomplishment.dart';
import 'models/User.dart';
import 'models/post.dart'; 
import 'models/Featured.dart';
part 'database.g.dart'; // 

@Database(version: 1, entities: [ Like ,Post , User , UserProfile , Skill , Accomplishment , Featured , Network ,])

abstract class AppDatabase extends FloorDatabase {
  
  PostDao get postDao;
  UserDao get userDao;
  UserProfileDao get userProfileDao;
  SkillDao get skillDao;
  AccomplishmentDao get accomplishmentDao;
  FeaturedDao get featuredDao ;
  NetworkDao get netwokDao ;
  LikeDao get likeDao ;


}