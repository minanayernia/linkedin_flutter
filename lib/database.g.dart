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

  NetworkDao? _netwokDaoInstance;

  LikeDao? _likeDaoInstance;

  CommentDao? _commentDaoInstance;

  CommentLikeDao? _commentLikeDaoInstance;

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
            'CREATE TABLE IF NOT EXISTS `CommentLike` (`commentLikeId` INTEGER PRIMARY KEY AUTOINCREMENT, `userId` INTEGER NOT NULL, `commentId` INTEGER NOT NULL, FOREIGN KEY (`userId`) REFERENCES `User` (`userId`) ON UPDATE NO ACTION ON DELETE NO ACTION, FOREIGN KEY (`commentId`) REFERENCES `Comment` (`commentId`) ON UPDATE NO ACTION ON DELETE NO ACTION)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `Comment` (`commentId` INTEGER PRIMARY KEY AUTOINCREMENT, `commentText` TEXT NOT NULL, `is_replied` INTEGER NOT NULL, `userId` INTEGER NOT NULL, `postId` INTEGER NOT NULL, FOREIGN KEY (`userId`) REFERENCES `User` (`userId`) ON UPDATE NO ACTION ON DELETE NO ACTION, FOREIGN KEY (`postId`) REFERENCES `Post` (`postId`) ON UPDATE NO ACTION ON DELETE NO ACTION)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `Like` (`LikeId` INTEGER PRIMARY KEY AUTOINCREMENT, `userId` INTEGER NOT NULL, `postId` INTEGER NOT NULL, FOREIGN KEY (`userId`) REFERENCES `User` (`userId`) ON UPDATE NO ACTION ON DELETE NO ACTION, FOREIGN KEY (`postId`) REFERENCES `Post` (`postId`) ON UPDATE NO ACTION ON DELETE NO ACTION)');
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
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `Network` (`networkId` INTEGER PRIMARY KEY AUTOINCREMENT, `userReqId` INTEGER, `userId` INTEGER, `networkState` INTEGER, FOREIGN KEY (`userReqId`) REFERENCES `User` (`userId`) ON UPDATE NO ACTION ON DELETE NO ACTION, FOREIGN KEY (`userId`) REFERENCES `User` (`userId`) ON UPDATE NO ACTION ON DELETE NO ACTION)');

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

  @override
  NetworkDao get netwokDao {
    return _netwokDaoInstance ??= _$NetworkDao(database, changeListener);
  }

  @override
  LikeDao get likeDao {
    return _likeDaoInstance ??= _$LikeDao(database, changeListener);
  }

  @override
  CommentDao get commentDao {
    return _commentDaoInstance ??= _$CommentDao(database, changeListener);
  }

  @override
  CommentLikeDao get commentLikeDao {
    return _commentLikeDaoInstance ??=
        _$CommentLikeDao(database, changeListener);
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
  Future<List<Post>> allNetworkPosts(int userId) async {
    return _queryAdapter.queryList(
        'SELECT * FROM posts WHERE userId in ((select DISTINCT userReqId from network WHERE networkState = 1 and userId = ?1)UNION(select DISTINCT userId from network WHERE networkState = 1 and userReqId = ?1))',
        mapper: (Map<String, Object?> row) => Post(PostId: row['PostId'] as int?, PostCaption: row['PostCaption'] as String, userId: row['userId'] as int),
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
  Future<List<User?>> searchByUsername(String userName) async {
    return _queryAdapter.queryList('SELECT * FROM User WHERE userName LIKE ?1',
        mapper: (Map<String, Object?> row) => User(
            userId: row['userId'] as int?,
            password: row['password'] as String,
            userName: row['userName'] as String),
        arguments: [userName]);
  }

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
  Future<Accomplishment?> findAccomplishmentByText(
      String AccomplishmentText) async {
    return _queryAdapter.query(
        'SELECT * FROM Accomplishment WHERE AccomplishmentText = ?1',
        mapper: (Map<String, Object?> row) => Accomplishment(
            AcomplishmentId: row['AcomplishmentId'] as int?,
            AccomplishmentText: row['AccomplishmentText'] as String,
            profileId: row['profileId'] as int),
        arguments: [AccomplishmentText]);
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
  Future<Featured?> findFeaturedById(int featuredId) async {
    return _queryAdapter.query('SELECT * FROM Featured WHERE featuredId = ?1',
        mapper: (Map<String, Object?> row) => Featured(
            featuredId: row['featuredId'] as int?,
            featuredText: row['featuredText'] as String,
            profileId: row['profileId'] as int?),
        arguments: [featuredId]);
  }

  @override
  Future<Featured?> findFeaturedByText(String featuredText) async {
    return _queryAdapter.query('SELECT * FROM Featured WHERE featuredText = ?1',
        mapper: (Map<String, Object?> row) => Featured(
            featuredId: row['featuredId'] as int?,
            featuredText: row['featuredText'] as String,
            profileId: row['profileId'] as int?),
        arguments: [featuredText]);
  }

  @override
  Future<Featured?> editFeatured(String featuredText, int featuredId) async {
    return _queryAdapter.query(
        'UPDATE Featured SET featuredText = ?1 WHERE featuredId = ?2',
        mapper: (Map<String, Object?> row) => Featured(
            featuredId: row['featuredId'] as int?,
            featuredText: row['featuredText'] as String,
            profileId: row['profileId'] as int?),
        arguments: [featuredText, featuredId]);
  }

  @override
  Future<void> insertFeatured(Featured featured) async {
    await _featuredInsertionAdapter.insert(featured, OnConflictStrategy.abort);
  }
}

class _$NetworkDao extends NetworkDao {
  _$NetworkDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database),
        _networkInsertionAdapter = InsertionAdapter(
            database,
            'Network',
            (Network item) => <String, Object?>{
                  'networkId': item.networkId,
                  'userReqId': item.userReqId,
                  'userId': item.userId,
                  'networkState': item.networkState
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Network> _networkInsertionAdapter;

  @override
  Future<int?> countMutualConnection(int userId) async {
    await _queryAdapter.queryNoReturn(
        'SELECT COUNT(*) FROM network WHERE networkState = 1 and (userId = ?1 or userReqId = ?1)',
        arguments: [userId]);
  }

  @override
  Future<List<Network?>> AllUsersInYourNetwork(int userId) async {
    return _queryAdapter.queryList(
        '((SELECT * FROM network WHERE userId = ?1) UNION (SELECT * FROM network WHERE userReqId = ?1))',
        mapper: (Map<String, Object?> row) => Network(networkId: row['networkId'] as int?, userReqId: row['userReqId'] as int?, userId: row['userId'] as int?),
        arguments: [userId]);
  }

  @override
  Future<Network?> acceptInvitation(int networkId) async {
    return _queryAdapter.query(
        'UPDATE Network SET networkState = 1 WHERE networkId = ?1',
        mapper: (Map<String, Object?> row) => Network(
            networkId: row['networkId'] as int?,
            userReqId: row['userReqId'] as int?,
            userId: row['userId'] as int?),
        arguments: [networkId]);
  }

  @override
  Future<List<Network?>> invitations(int yourId) async {
    return _queryAdapter.queryList(
        'SELECT * FROM Network WHERE networkState = 0 and userId = ?1',
        mapper: (Map<String, Object?> row) => Network(
            networkId: row['networkId'] as int?,
            userReqId: row['userReqId'] as int?,
            userId: row['userId'] as int?),
        arguments: [yourId]);
  }

  @override
  Future<Network?> findNetwork(int myuser, int anotheruser) async {
    return _queryAdapter.query(
        'SELECT * FROM Network WHERE (userId = ?1 and userReqId = ?2) or (userId = ?2 and userReqId = ?1)',
        mapper: (Map<String, Object?> row) => Network(networkId: row['networkId'] as int?, userReqId: row['userReqId'] as int?, userId: row['userId'] as int?),
        arguments: [myuser, anotheruser]);
  }

  @override
  Future<void> deletNetwork(int anotheruser, int myid) async {
    await _queryAdapter.queryNoReturn(
        'DELETE FROM Network WHERE userReqId = ?1 and userId = ?2',
        arguments: [anotheruser, myid]);
  }

  @override
  Future<void> insertNetwork(Network network) async {
    await _networkInsertionAdapter.insert(network, OnConflictStrategy.abort);
  }
}

class _$LikeDao extends LikeDao {
  _$LikeDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database),
        _likeInsertionAdapter = InsertionAdapter(
            database,
            'Like',
            (Like item) => <String, Object?>{
                  'LikeId': item.LikeId,
                  'userId': item.userId,
                  'postId': item.PostId
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Like> _likeInsertionAdapter;

  @override
  Future<int?> likeNumbers(int postId) async {
    await _queryAdapter.queryNoReturn(
        'SELECT COUNT(LikeId) FROM Like WHERE PostId = ?1',
        arguments: [postId]);
  }

  @override
  Future<Like?> findLikeIdByUseridPostid(int userId, int PostId) async {
    return _queryAdapter.query(
        'SELECT * FROM Like WHERE userId = ?1 and PostId = ?2',
        mapper: (Map<String, Object?> row) => Like(
            LikeId: row['LikeId'] as int?,
            userId: row['userId'] as int,
            PostId: row['postId'] as int),
        arguments: [userId, PostId]);
  }

  @override
  Future<List<Like?>> likelist(int postId) async {
    return _queryAdapter.queryList('SELECT * FROM Like where PostId = ?1',
        mapper: (Map<String, Object?> row) => Like(
            LikeId: row['LikeId'] as int?,
            userId: row['userId'] as int,
            PostId: row['postId'] as int),
        arguments: [postId]);
  }

  @override
  Future<void> insertLike(Like like) async {
    await _likeInsertionAdapter.insert(like, OnConflictStrategy.abort);
  }
}

class _$CommentDao extends CommentDao {
  _$CommentDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database),
        _commentInsertionAdapter = InsertionAdapter(
            database,
            'Comment',
            (Comment item) => <String, Object?>{
                  'commentId': item.commentId,
                  'commentText': item.commentText,
                  'is_replied': item.is_replied,
                  'userId': item.userId,
                  'postId': item.postId
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Comment> _commentInsertionAdapter;

  @override
  Future<int?> commentNumber(int postId) async {
    await _queryAdapter.queryNoReturn(
        'SELECT COUNT(commentId) FROM comment WHERE postId = ?1',
        arguments: [postId]);
  }

  @override
  Future<Comment?> updateCommentForReply(int ReplyCommentId) async {
    return _queryAdapter.query(
        'UPDATE Comment SET ReplyCommentId = ?1 AND is_replied = 1',
        mapper: (Map<String, Object?> row) => Comment(
            commentId: row['commentId'] as int?,
            postId: row['postId'] as int,
            userId: row['userId'] as int,
            commentText: row['commentText'] as String),
        arguments: [ReplyCommentId]);
  }

  @override
  Future<List<Comment>> findAllComment(int postId) async {
    return _queryAdapter.queryList('SELECT * FROM comment  WHERE postId = ?1',
        mapper: (Map<String, Object?> row) => Comment(
            commentId: row['commentId'] as int?,
            postId: row['postId'] as int,
            userId: row['userId'] as int,
            commentText: row['commentText'] as String),
        arguments: [postId]);
  }

  @override
  Future<void> insertComment(Comment comment) async {
    await _commentInsertionAdapter.insert(comment, OnConflictStrategy.abort);
  }
}

class _$CommentLikeDao extends CommentLikeDao {
  _$CommentLikeDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database),
        _commentLikeInsertionAdapter = InsertionAdapter(
            database,
            'CommentLike',
            (CommentLike item) => <String, Object?>{
                  'commentLikeId': item.commentLikeId,
                  'userId': item.userId,
                  'commentId': item.commentId
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<CommentLike> _commentLikeInsertionAdapter;

  @override
  Future<int?> commentLikenNumber(int commentId) async {
    await _queryAdapter.queryNoReturn(
        'SELECT COUNT(commentLikeId) FROM commentLike WHERE commentId = ?1',
        arguments: [commentId]);
  }

  @override
  Future<CommentLike?> findCommentLikeBYUseridCommentId(
      int userId, int commentId) async {
    return _queryAdapter.query(
        'SELECT * FROM CommentLike WHERE userId = ?1 AND commentId  = ?2',
        mapper: (Map<String, Object?> row) => CommentLike(
            commentLikeId: row['commentLikeId'] as int?,
            userId: row['userId'] as int,
            commentId: row['commentId'] as int),
        arguments: [userId, commentId]);
  }

  @override
  Future<List<CommentLike?>> commentLikes(int commentId) async {
    return _queryAdapter.queryList(
        'SELECT * FROM CommentLike WHERE commentId = ?1',
        mapper: (Map<String, Object?> row) => CommentLike(
            commentLikeId: row['commentLikeId'] as int?,
            userId: row['userId'] as int,
            commentId: row['commentId'] as int),
        arguments: [commentId]);
  }

  @override
  Future<void> insertCommentLike(CommentLike commentLike) async {
    await _commentLikeInsertionAdapter.insert(
        commentLike, OnConflictStrategy.abort);
  }
}
