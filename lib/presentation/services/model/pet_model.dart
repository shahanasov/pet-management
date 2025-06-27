class PetModel {
  final int id;
  final String userName;
  final String petName;
  final String petImage;
  final bool isFriendly;

  PetModel({
    required this.id,
    required this.userName,
    required this.petName,
    required this.petImage,
    required this.isFriendly,
  });

  // Using a named constructor (not factory)
  PetModel.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int? ?? 0, // Fallback to 0 if null
        userName = json['userName'] as String,
        petName = json['petName'] as String,
        petImage = json['petImage'] as String,
        isFriendly = json['isFriendly'] as bool? ?? false;

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userName': userName,
      'petName': petName,
      'petImage': petImage,
      'isFriendly': isFriendly,
    };
  }
}