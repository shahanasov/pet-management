import 'package:get/get.dart';
import 'package:petadopt/presentation/services/api_services.dart';
import 'package:petadopt/presentation/services/model/pet_model.dart';

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

  Future<void> submitAdoption() async {
    isSubmitting(true);
    try {
      if (name.isEmpty || age.isEmpty || selectedPet.value == null) {
        Get.snackbar('Error', 'Please fill all fields');
        return;
      }

       // await _apiServices.submitAdoption(
        // name.value,
        // int.parse(age.value),
        // gender.value,
        // selectedPet.value!.id ,
      // );

      Get.snackbar('Success', 'Adoption submitted successfully!');
      Get.back(); // Return to previous screen
    } catch (e) {
      Get.snackbar('Error', 'Failed to submit adoption: $e');
    } finally {
      isSubmitting(false);
    }
  }
}