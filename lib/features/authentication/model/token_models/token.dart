import 'package:hive/hive.dart';

part 'token.g.dart'; 

@HiveType(typeId: 2) 
class Token {
  @HiveField(0)
  final String refresh;
  
  @HiveField(1)
  final String token;

  @HiveField(2)
  final List<int> key;
 
  Token({
    required this.refresh,
    required this.token,
    required this.key
  });
}