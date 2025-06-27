import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:petadopt/presentation/services/model/pet_model.dart';

class ApiServices {
  final String apiUrl =
      "https://jatinderji.github.io/users_pets_api/users_pets.json";

  Future<List<PetModel>> fetchPetDetails() async {
    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        // Decode the JSON response
        final Map<String, dynamic> jsonResponse = jsonDecode(response.body);

        // Extract the "data" array from the JSON
        final List<dynamic> petList = jsonResponse['data'];

        // Convert each item in the list to a PetModel
        return petList.map((petJson) => PetModel.fromJson(petJson)).toList();
      } else {
        throw Exception('Failed to load data: ${response.statusCode}');
      }
    } catch (e) {
      // Handle network errors or JSON parsing errors
      throw Exception('Failed to fetch pets: $e');
    }
  }

  Future<void> submitAdoption(
    String name,
    int age,
    String gender,
    int petId,
  ) async {
    
  }
}
