import 'package:hive_flutter/adapters.dart';
part 'adopt_model.g.dart';

@HiveType(typeId: 0)
class AdoptParentModel extends HiveObject{
  @HiveField(0)
  String name;
  @HiveField(1)
  int age;
  @HiveField(2)
  String gender;
  @HiveField(3
  )
  String petName;
  AdoptParentModel({
    required this.name,
    required this.age,
    required this.gender,
    required this.petName
  });
}