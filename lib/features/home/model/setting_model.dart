
import 'package:hive/hive.dart';
part 'setting_model.g.dart';

@HiveType(typeId: 4) 
class SettingModel {
  @HiveField(0)
  final bool darkMOde;
  
  @HiveField(1)
  final String loctionTracking;

  @HiveField(2)
  final List<int> key;
 
  SettingModel({
    required this.darkMOde,
    required this.loctionTracking,
    required this.key
  });
}