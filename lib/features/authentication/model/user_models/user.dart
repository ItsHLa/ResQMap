import 'package:hive/hive.dart';

part 'user.g.dart'; 

@HiveType(typeId: 0) 
class User {
  @HiveField(0)
  final String firstName;
  
  @HiveField(1)
  final String lastName;
  
  @HiveField(2)
  final String userName;
  
  @HiveField(3)
  final String email;
  
  @HiveField(4)
  final String phoneNumber;
  
  @HiveField(5)
  final String password;


  User({
    required this.firstName,
    required this.lastName,
    required this.userName,
    required this.email,
    required this.phoneNumber,
    required this.password,

  });
}