import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:petadopt/presentation/services/model/controller.dart';
import 'package:petadopt/presentation/services/model/pet_model.dart';

class AdoptPage extends StatelessWidget {
  final AdoptController controller = Get.put(AdoptController());

  AdoptPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Adoption Form'),
        centerTitle: true,
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        return SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              buildNameField(),
              const SizedBox(height: 20),
              buildAgeField(),
              const SizedBox(height: 20),
              buildGenderDropdown(),
              const SizedBox(height: 20),
              buildPetDropdown(),
              const SizedBox(height: 30),
              buildSubmitButton(),
            ],
          ),
        );
      }),
    );
  }

  Widget buildNameField() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: 'Your Name',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        prefixIcon: const Icon(Icons.person),
      ),
      onChanged: (value) => controller.name(value),
      validator: (value) => value!.isEmpty ? 'Please enter your name' : null,
    );
  }

  Widget buildAgeField() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: 'Your Age',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        prefixIcon: const Icon(Icons.cake),
      ),
      keyboardType: TextInputType.number,
      onChanged: (value) => controller.age(value),
      validator: (value) => value!.isEmpty ? 'Please enter your age' : null,
    );
  }

  Widget buildGenderDropdown() {
    return DropdownButtonFormField<String>(
      decoration: InputDecoration(
        labelText: 'Gender',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        prefixIcon: const Icon(Icons.transgender),
      ),
      value: controller.gender.value,
      items: ['Male', 'Female', 'Other']
          .map((gender) => DropdownMenuItem(
                value: gender,
                child: Text(gender),
              ))
          .toList(),
      onChanged: (value) => controller.gender(value!),
    );
  }

  Widget buildPetDropdown() {
    return Obx(() {
      return DropdownButtonFormField<PetModel>(
        decoration: InputDecoration(
          labelText: 'Select Pet',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          prefixIcon: const Icon(Icons.pets),
        ),
        value: controller.selectedPet.value,
        items: controller.petsList.map((PetModel pet) {
          return DropdownMenuItem<PetModel>(
            value: pet,
            child: Text(pet.petName),
          );
        }).toList(),
        onChanged: (PetModel? pet) => controller.selectedPet(pet),
        validator: (value) => value == null ? 'Please select a pet' : null,
      );
    });
  }

  Widget buildSubmitButton() {
    return Obx(() {
      return ElevatedButton(
        onPressed: controller.isSubmitting.value ? null : controller.submitAdoption,
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 15),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: controller.isSubmitting.value
            ? const CircularProgressIndicator(color: Colors.white)
            : const Text(
                'Submit Adoption',
                style: TextStyle(fontSize: 16),
              ),
      );
    });
  }
}