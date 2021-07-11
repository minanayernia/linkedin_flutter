// database.dart

// required package imports
import 'dart:async';
import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

// import 'dao/person_dao.dart';
import 'models/post.dart';
part 'database.g.dart'; // the generated code will be there

@Database(version: 1, entities: [Post])
abstract class AppDatabase extends FloorDatabase {
  PostDao get postDao;
}