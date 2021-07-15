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

  SkillDao? _skillDaoInstance;

  AccomplishmentDao? _accomplishmentDaoInstance;

  FeaturedDao? _featuredDaoInstance;

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
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `Skill` (`SkillId` INTEGER PRIMARY KEY AUTOINCREMENT, `SkillText` TEXT NOT NULL, `profileId` INTEGER NOT NULL, FOREIGN KEY (`profileId`) REFERENCES `UserProfile` (`profileId`) ON UPDATE NO ACTION ON DELETE NO ACTION)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `Accomplishment` (`AcomplishmentId` INTEGER PRIMARY KEY AUTOINCREMENT, `profileId` INTEGER NOT NULL, `AccomplishmentText` TEXT NOT NULL, FOREIGN KEY (`profileId`) REFERENCES `UserProfile` (`profileId`) ON UPDATE NO ACTION ON DELETE NO ACTION)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `Featured` (`featuredId` INTEGER PRIMARY KEY AUTOINCREMENT, `profileId` INTEGER, `featuredText` TEXT NOT NULL, FOREIGN KEY (`profileId`) REFERENCES `UserProfile` (`ProfileId`) ON UPDATE NO ACTION ON DELETE NO ACTION)');

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

  @override
  SkillDao get skillDao {
    return _skillDaoInstance ??= _$SkillDao(database, changeListener);
  }

  @override
  AccomplishmentDao get accomplishmentDao {
    return _accomplishmentDaoInstance ??=
        _$AccomplishmentDao(database, changeListener);
  }

  @override
  FeaturedDao get featuredDao {
    return _featuredDaoInstance ??= _$FeaturedDao(database, changeListener);
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
        mapper: (Map<String, Object?> row) => Post(
            PostId: row['PostId'] as int?,
            PostCaption: row['PostCaption'] as String,
            userId: row['userId'] as int),
        arguments: [userId]);
  }

  @override
  Future<void> insertPost(Post post) async {
    await _postInsertionAdapter.insert(post, OnConflictStrategy.abort);
  }
}

class _$UserDao extends UserDao {
  _$UserDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database),
        _userInsertionAdapter = InsertionAdapter(
            database,
            'User',
            (User item) => <String, Object?>{
                  'userId': item.userId,
                  'password': item.password,
                  'userName': item.userName
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<User> _userInsertionAdapter;

  @override
  Future<void> deleteAllUsers() async {
    await _queryAdapter.queryNoReturn('Delete FROM User');
  }

  @override
  Future<User?> findUserNameByUserId(int userId) async {
    return _queryAdapter.query('SELECT * FROM User where userId = ?1',
        mapper: (Map<String, Object?> row) => User(
            userId: row['userId'] as int?,
            password: row['password'] as String,
            userName: row['userName'] as String),
        arguments: [userId]);
  }

  @override
  Future<User?> findUserByUsernamePassword(
      String password, String userName) async {
    return _queryAdapter.query(
        'SELECT * FROM User where password = ?1 and userName = ?2',
        mapper: (Map<String, Object?> row) => User(
            userId: row['userId'] as int?,
            password: row['password'] as String,
            userName: row['userName'] as String),
        arguments: [password, userName]);
  }

  @override
  Future<User?> findeUserByUserName(String userName) async {
    return _queryAdapter.query('SELECT * FROM User WHERE userName = ?1',
        mapper: (Map<String, Object?> row) => User(
            userId: row['userId'] as int?,
            password: row['password'] as String,
            userName: row['userName'] as String),
        arguments: [userName]);
  }

  @override
  Future<List<User>> findAllusers() async {
    return _queryAdapter.queryList('SELECT * FROM User',
        mapper: (Map<String, Object?> row) => User(
            userId: row['userId'] as int?,
            password: row['password'] as String,
            userName: row['userName'] as String));
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
            ProfileId: row['ProfileId'] as int?,
            userId: row['userId'] as int?,
            location: row['location'] as String,
            FirstName: row['FirstName'] as String,
            LastName: row['LastName'] as String,
            UserName: row['UserName'] as String,
            AdditionalInfo: row['AdditionalInfo'] as String,
            About: row['About'] as String),
        arguments: [userId]);
  }

  @override
  Future<void> deletAllProfile() async {
    await _queryAdapter.queryNoReturn('DELETE FROM UserProfile');
  }

  @override
  Future<UserProfile?> editAbout(int userId, String about) async {
    return _queryAdapter.query(
        'UPDATE UserProfile SET about = ?2 WHERE userId = ?1',
        mapper: (Map<String, Object?> row) => UserProfile(
            ProfileId: row['ProfileId'] as int?,
            userId: row['userId'] as int?,
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
      String lastname, String about, String location) async {
    return _queryAdapter.query(
        'UPDATE UserProfile SET firstName = ?2 , lastName = ?3, about =  ?4 , location = ?5   WHERE userId =  ?1',
        mapper: (Map<String, Object?> row) => UserProfile(ProfileId: row['ProfileId'] as int?, userId: row['userId'] as int?, location: row['location'] as String, FirstName: row['FirstName'] as String, LastName: row['LastName'] as String, UserName: row['UserName'] as String, AdditionalInfo: row['AdditionalInfo'] as String, About: row['About'] as String),
        arguments: [userId, firstname, lastname, about, location]);
  }

  @override
  Future<void> insertUserProfile(UserProfile userProfile) async {
    await _userProfileInsertionAdapter.insert(
        userProfile, OnConflictStrategy.abort);
  }
}

class _$SkillDao extends SkillDao {
  _$SkillDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database),
        _skillInsertionAdapter = InsertionAdapter(
            database,
            'Skill',
            (Skill item) => <String, Object?>{
                  'SkillId': item.SkillId,
                  'SkillText': item.SkillText,
                  'profileId': item.profileId
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Skill> _skillInsertionAdapter;

  @override
  Future<List<Skill?>> allSkills(int profileId) async {
    return _queryAdapter.queryList('SELECT * FROM skill WHERE profileId = ?1',
        mapper: (Map<String, Object?> row) => Skill(
            SkillId: row['SkillId'] as int?,
            SkillText: row['SkillText'] as String,
            profileId: row['profileId'] as int),
        arguments: [profileId]);
  }

  @override
  Future<void> deleteSkills() async {
    await _queryAdapter.queryNoReturn('DELETE FROM Skill');
  }

  @override
  Future<Skill?> findSkillByName(String skillText) async {
    return _queryAdapter.query('SELECT * FROM Skill WHERE skillText = ?1',
        mapper: (Map<String, Object?> row) => Skill(
            SkillId: row['SkillId'] as int?,
            SkillText: row['SkillText'] as String,
            profileId: row['profileId'] as int),
        arguments: [skillText]);
  }

  @override
  Future<Skill?> findSkillById(int id) async {
    return _queryAdapter.query('SELECT * FROM Skill WHERE skillId = ?1',
        mapper: (Map<String, Object?> row) => Skill(
            SkillId: row['SkillId'] as int?,
            SkillText: row['SkillText'] as String,
            profileId: row['profileId'] as int),
        arguments: [id]);
  }

  @override
  Future<Skill?> editSkill(String skillText, int skillId) async {
    return _queryAdapter.query(
        'UPDATE skill SET skillText = ?1 WHERE skillId = ?2',
        mapper: (Map<String, Object?> row) => Skill(
            SkillId: row['SkillId'] as int?,
            SkillText: row['SkillText'] as String,
            profileId: row['profileId'] as int),
        arguments: [skillText, skillId]);
  }

  @override
  Future<void> insertSkill(Skill skill) async {
    await _skillInsertionAdapter.insert(skill, OnConflictStrategy.abort);
  }
}

class _$AccomplishmentDao extends AccomplishmentDao {
  _$AccomplishmentDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database),
        _accomplishmentInsertionAdapter = InsertionAdapter(
            database,
            'Accomplishment',
            (Accomplishment item) => <String, Object?>{
                  'AcomplishmentId': item.AcomplishmentId,
                  'profileId': item.profileId,
                  'AccomplishmentText': item.AccomplishmentText
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Accomplishment> _accomplishmentInsertionAdapter;

  @override
  Future<List<Accomplishment?>> allAccomplishments(int profileId) async {
    return _queryAdapter.queryList(
        'SELECT * FROM Accomplishment WHERE profileId = ?1',
        mapper: (Map<String, Object?> row) => Accomplishment(
            AcomplishmentId: row['AcomplishmentId'] as int?,
            AccomplishmentText: row['AccomplishmentText'] as String,
            profileId: row['profileId'] as int),
        arguments: [profileId]);
  }

  @override
  Future<Accomplishment?> findAccomplishmentById(int id) async {
    return _queryAdapter.query(
        'SELECT * FROM Accomplishment WHERE AcomplishmentId = ?1',
        mapper: (Map<String, Object?> row) => Accomplishment(
            AcomplishmentId: row['AcomplishmentId'] as int?,
            AccomplishmentText: row['AccomplishmentText'] as String,
            profileId: row['profileId'] as int),
        arguments: [id]);
  }

  @override
  Future<Accomplishment?> editAccomplishment(
      String accomplishmentText, int accomplishmentId) async {
    return _queryAdapter.query(
        'UPDATE Accomplishment SET AccomplishmentText =  ?1 WHERE  AcomplishmentId = ?2',
        mapper: (Map<String, Object?> row) => Accomplishment(AcomplishmentId: row['AcomplishmentId'] as int?, AccomplishmentText: row['AccomplishmentText'] as String, profileId: row['profileId'] as int),
        arguments: [accomplishmentText, accomplishmentId]);
  }

  @override
  Future<void> insertAccomplishment(Accomplishment accomplishment) async {
    await _accomplishmentInsertionAdapter.insert(
        accomplishment, OnConflictStrategy.abort);
  }
}

class _$FeaturedDao extends FeaturedDao {
  _$FeaturedDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database),
        _featuredInsertionAdapter = InsertionAdapter(
            database,
            'Featured',
            (Featured item) => <String, Object?>{
                  'featuredId': item.featuredId,
                  'profileId': item.profileId,
                  'featuredText': item.featuredText
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Featured> _featuredInsertionAdapter;

  @override
  Future<List<Featured?>> allAdditionalInfo(int profileId) async {
    return _queryAdapter.queryList(
        'SELECT * FROM Featured WHERE profileId = ?1',
        mapper: (Map<String, Object?> row) => Featured(
            featuredId: row['featuredId'] as int?,
            featuredText: row['featuredText'] as String,
            profileId: row['profileId'] as int?),
        arguments: [profileId]);
  }

  @override
  Future<Featured?> editFeatured(String featuredText, int userId) async {
    return _queryAdapter.query(
        'UPDATE Featured SET featuredText = ?1 WHERE profileId in (SELECT profileId From userProfile WHERE userId = ?2',
        mapper: (Map<String, Object?> row) => Featured(featuredId: row['featuredId'] as int?, featuredText: row['featuredText'] as String, profileId: row['profileId'] as int?),
        arguments: [featuredText, userId]);
  }

  @override
  Future<void> insertFeatured(Featured featured) async {
    await _featuredInsertionAdapter.insert(featured, OnConflictStrategy.abort);
  }
}
