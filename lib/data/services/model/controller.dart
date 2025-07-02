import 'package:get/get.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:petadopt/data/services/api_services.dart';
import 'package:petadopt/data/services/model/adopt_model.dart';
import 'package:petadopt/data/services/model/pet_model.dart';

class AdoptController extends GetxController {
  final ApiServices _apiServices = ApiServices();
  
  // Form fields
  var name = ''.obs;
  var age = ''.obs;
  var gender = 'Male'.obs;
  var selectedPet = Rx<PetModel?>(null);
  var petsList = <PetModel>[].obs;
  var isLoading = true.obs;
  var isSubmitting = false.obs;

  @override
  void onInit() {
    fetchAvailablePets();
    super.onInit();
  }

  Future<void> fetchAvailablePets() async {
    try {
      isLoading(true);
      final pets = await _apiServices.fetchPetDetails();
      petsList.assignAll(pets);
      if (pets.isNotEmpty) selectedPet(pets.first);
    } finally {
      isLoading(false);
    }
  }

Future<void> submitAdoption({
  required String name,
  required String age,
  required String gender,
  required String petName,
}) async {
  if (name.isEmpty || age.isEmpty || gender.isEmpty || petName.isEmpty) {
    Get.snackbar('Error', 'Please fill all fields');
    return;
  }

  try {
    isSubmitting.value = true;
    final user = AdoptParentModel(
      name: name.trim(),
      age: int.parse(age),
      gender: gender.trim(),
      petName: petName.trim(),
    );

    await Hive.openBox<AdoptParentModel>('parent');
    final box = Hive.box<AdoptParentModel>('parent');
    await box.add(user);

    Get.snackbar('Success', 'Adoption form submitted!');
    await Future.delayed(Duration(seconds: 1));
    Get.back();
  } catch (e) {
    Get.snackbar('Error', 'Failed to submit form');
  } finally {
    isSubmitting.value = false;
  }
}

}