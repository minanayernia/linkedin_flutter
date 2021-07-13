// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

class $FloorAppDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder databaseBuilder(String name) =>
      _$AppDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder inMemoryDatabaseBuilder() =>
      _$AppDatabaseBuilder(null);
}

class _$AppDatabaseBuilder {
  _$AppDatabaseBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  /// Adds migrations to the builder.
  _$AppDatabaseBuilder addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  /// Adds a database [Callback] to the builder.
  _$AppDatabaseBuilder addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  /// Creates the database and initializes it.
  Future<AppDatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$AppDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$AppDatabase extends AppDatabase {
  _$AppDatabase([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  PostDao? _postDaoInstance;

  UserDao? _userDaoInstance;

  UserProfileDao? _userProfileDaoInstance;

  Future<sqflite.Database> open(String path, List<Migration> migrations,
      [Callback? callback]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 1,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
        await callback?.onConfigure?.call(database);
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        await MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `Post` (`PostId` INTEGER PRIMARY KEY AUTOINCREMENT, `PostCaption` TEXT NOT NULL, `userId` INTEGER NOT NULL, FOREIGN KEY (`userId`) REFERENCES `User` (`userId`) ON UPDATE NO ACTION ON DELETE NO ACTION)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `User` (`userId` INTEGER PRIMARY KEY AUTOINCREMENT, `password` TEXT NOT NULL, `userName` TEXT NOT NULL)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `UserProfile` (`ProfileId` INTEGER PRIMARY KEY AUTOINCREMENT, `userId` INTEGER, `FirstName` TEXT NOT NULL, `LastName` TEXT NOT NULL, `UserName` TEXT NOT NULL, `About` TEXT NOT NULL, `AdditionalInfo` TEXT NOT NULL, `location` TEXT NOT NULL, FOREIGN KEY (`userId`) REFERENCES `User` (`userId`) ON UPDATE NO ACTION ON DELETE NO ACTION)');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  PostDao get postDao {
    return _postDaoInstance ??= _$PostDao(database, changeListener);
  }

  @override
  UserDao get userDao {
    return _userDaoInstance ??= _$UserDao(database, changeListener);
  }

  @override
  UserProfileDao get userProfileDao {
    return _userProfileDaoInstance ??=
        _$UserProfileDao(database, changeListener);
  }
}

class _$PostDao extends PostDao {
  _$PostDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database),
        _postInsertionAdapter = InsertionAdapter(
            database,
            'Post',
            (Post item) => <String, Object?>{
                  'PostId': item.PostId,
                  'PostCaption': item.PostCaption,
                  'userId': item.userId
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Post> _postInsertionAdapter;

  @override
  Future<List<Post>> findAllPosts(int userId) async {
    return _queryAdapter.queryList('SELECT * FROM Post WHERE userId = ?1',
        mapper: (Map<String, Object?> row) => Post(row['PostId'] as int?,
            row['PostCaption'] as String, row['userId'] as int),
        arguments: [userId]);
  }

  @override
  Future<void> insertPost(Post post) async {
    await _postInsertionAdapter.insert(post, OnConflictStrategy.abort);
  }
}

class _$UserDao extends UserDao {
  _$UserDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database, changeListener),
        _userInsertionAdapter = InsertionAdapter(
            database,
            'User',
            (User item) => <String, Object?>{
                  'userId': item.userId,
                  'password': item.password,
                  'userName': item.userName
                },
            changeListener);

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<User> _userInsertionAdapter;

  @override
  Stream<User?> findUserByUsernamePassword(String password, String userName) {
    return _queryAdapter.queryStream(
        'SELECT userId FROM User where password = ?1 and userName = ?2',
        mapper: (Map<String, Object?> row) =>
            User(row['password'] as String, row['userName'] as String),
        arguments: [password, userName],
        queryableName: 'User',
        isView: false);
  }

  @override
  Future<List<User>> findAllusers() async {
    return _queryAdapter.queryList('SELECT * FROM User',
        mapper: (Map<String, Object?> row) =>
            User(row['password'] as String, row['userName'] as String));
  }

  @override
  Future<void> insertUser(User user) async {
    await _userInsertionAdapter.insert(user, OnConflictStrategy.abort);
  }
}

class _$UserProfileDao extends UserProfileDao {
  _$UserProfileDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database),
        _userProfileInsertionAdapter = InsertionAdapter(
            database,
            'UserProfile',
            (UserProfile item) => <String, Object?>{
                  'ProfileId': item.ProfileId,
                  'userId': item.userId,
                  'FirstName': item.FirstName,
                  'LastName': item.LastName,
                  'UserName': item.UserName,
                  'About': item.About,
                  'AdditionalInfo': item.AdditionalInfo,
                  'location': item.location
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<UserProfile> _userProfileInsertionAdapter;

  @override
  Future<UserProfile?> findProfileByUserId(int userId) async {
    return _queryAdapter.query('SELECT * FROM userProfile WHERE userId = ?1',
        mapper: (Map<String, Object?> row) => UserProfile(
            location: row['location'] as String,
            FirstName: row['FirstName'] as String,
            LastName: row['LastName'] as String,
            UserName: row['UserName'] as String,
            AdditionalInfo: row['AdditionalInfo'] as String,
            About: row['About'] as String),
        arguments: [userId]);
  }

  @override
  Future<UserProfile?> editAbout(int userId, String about) async {
    return _queryAdapter.query(
        'UPDATE userProfile SET about = ?2 WHERE userId = ?1',
        mapper: (Map<String, Object?> row) => UserProfile(
            location: row['location'] as String,
            FirstName: row['FirstName'] as String,
            LastName: row['LastName'] as String,
            UserName: row['UserName'] as String,
            AdditionalInfo: row['AdditionalInfo'] as String,
            About: row['About'] as String),
        arguments: [userId, about]);
  }

  @override
  Future<UserProfile?> editAllProfile(int userId, String firstname,
      String lastname, String about, String additionalInfo) async {
    return _queryAdapter.query(
        'UPDATE userProfile SET firstName = ?2 , lastName = ?3, about =  ?4 , additionalInfo = ?5  WHERE userId =  ?1',
        mapper: (Map<String, Object?> row) => UserProfile(location: row['location'] as String, FirstName: row['FirstName'] as String, LastName: row['LastName'] as String, UserName: row['UserName'] as String, AdditionalInfo: row['AdditionalInfo'] as String, About: row['About'] as String),
        arguments: [userId, firstname, lastname, about, additionalInfo]);
  }

  @override
  Future<void> insertUserProfile(UserProfile userProfile) async {
    await _userProfileInsertionAdapter.insert(
        userProfile, OnConflictStrategy.abort);
  }
}
