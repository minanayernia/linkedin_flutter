import 'package:floor/floor.dart';

@entity 
class UserProfile {
  @primaryKey
  final int ProfileId ;

  final String FirstName ;
  final String LastName ;
  final String UserName ;
  final String About ;
  final String AdditionalInfo;

  UserProfile(this.ProfileId , this.FirstName ,this.LastName , this.UserName , this.AdditionalInfo , this.About
   );
}

@dao
abstract class UserProfileDao {
  
}