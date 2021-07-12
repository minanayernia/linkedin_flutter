//import 'package:flutter/cupertino.dart';
//import 'package:sqflite/sqflite.dart' ;
//import 'dart:async';

// import 'package:path_provider/path_provider.dart';
//import 'package:path/path.dart';
//import 'package:flutter/widgets.dart' ;
//import 'package:dbproject/models/post.dart';


// class DatabaseHelper{
//   static DatabaseHelper _databaseHelper ;
//   static Database _database ;
//   DatabaseHelper._createInstance();
//   factory DatabaseHelper(){
//     if ( _databaseHelper == null ){
//       _databaseHelper = DatabaseHelper._createInstance();
//     }
//     return _databaseHelper;
//   }

//   Future<Database> get database async{

//     if (_database == null){
//       _database = await initializeDatabase();
//     }
//     return _database ;
//   }

//   Future<Database> initializeDatabase() async{
//     Directory directory = await getApplicationDocumentsDirectory();
//     String path = directory.path + 'linkedin.db' ;
//     var linkedin_database = await openDatabase( path, version: 1, onCreate: _creatDb);
//     return linkedin_database ;
//   }


//   void _creatDb(Database db , int newVersion) async{
//     await db.execute('CREATE TABLE user(user_id varchar(15) primary key ,password varchar(15) ,email varchar(30))')  ;
//     await db.execute('CREATE TABLE post (post_id int primary key ,caption text ,media image ,owner int ,foreignkey (owner) references user(id),create_date datetime)');
//   }
// }

// void main() async {
//   print("hiiiiiiiiiiii") ;
//   WidgetsFlutterBinding.ensureInitialized();

// final database = openDatabase(
//   join(await getDatabasesPath(), 'linkedin.db'),
//   onCreate: (db, version) {
//     // Run the CREATE TABLE statement on the database.
//     return db.execute(
//       'CREATE TABLE post (post_id int primary key ,caption text ,media image ,owner int ,foreignkey (owner) references user(id),create_date datetime)',
//     );
//   },
//   // Set the version. This executes the onCreate function and provides a
//   // path to perform database upgrades and downgrades.
//   version: 1,
// );

// Future <void> insertPost(Post post)async{
//   final db = await database ;
//   await db.insert('posts', post.toMap(),conflictAlgorithm: ConflictAlgorithm.replace,);
// }
// Future<List<Post>> posts() async {
//     // Get a reference to the database.
//     final db = await database;
//     final List<Map<String, dynamic>> maps = await db.query('posts');

//     // Convert the List<Map<String, dynamic> into a List<Dog>.
//     return List.generate(maps.length, (i) {
//       return Post(
//         post_id: maps[i]['post_id'],
//         caption: maps[i]['caption'],
//         owner: maps[i]['owner'],
//       );
//     });
//   }
  
//   var new_post = Post(caption: "new_post testing" , owner: 1 , post_id: 1);
//   await insertPost(new_post);
//   print(await posts()) ;
//   print("hiiiiiiiiiiii") ;

// }

