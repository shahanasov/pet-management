import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:petadopt/presentation/pages/pet_adopt_form.dart';
import 'package:petadopt/presentation/services/api_services.dart';
import 'package:petadopt/presentation/services/model/pet_model.dart';

class HomeController extends GetxController {
  final ApiServices _apiServices = ApiServices();
  var pets = <PetModel>[].obs;
  var isLoading = true.obs;

  @override
  void onInit() {
    fetchPets();
    super.onInit();
  }

  Future<void> fetchPets() async {
    try {
      isLoading(true);
      final result = await _apiServices.fetchPetDetails();
      pets.assignAll(result);
    } finally {
      isLoading(false);
    }
  }
}

class HomePage extends StatelessWidget {
  final HomeController controller = Get.put(HomeController());

  HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Own a Pet')),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Obx(() {
          if (controller.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          }

          return Column(
            children: [
              GestureDetector(
                onTap: () => Get.to(() => AdoptPage()),

                child: Card(elevation: 5,
                  color: Colors.white,
                  child: SizedBox(
                    height: 150,
                    width: double.infinity,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Pets are awaiting\n    to be Loved',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 25,
                          ),
                        ),
                        Text('Adopt a pet')
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 25,),
              Expanded(
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisSpacing: 2,
                    mainAxisSpacing: 5,
                    crossAxisCount: 2,
                  ),
                  itemCount: controller.pets.length,
                  itemBuilder: (context, index) {
                    final pet = controller.pets[index];
                    return Card(
                      elevation: 2,
                      child: Column(
                        children: [
                          Stack(
                            children: [
                              !pet.isFriendly
                                  ? const Icon(Icons.star_border)
                                  : const Icon(Icons.star_purple500_outlined),
                              SizedBox(
                                height: 100,
                                width: 150,
                                child: Image.network(pet.petImage),
                              ),
                            ],
                          ),
                          ListTile(
                            title: Text(
                              pet.petName,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            subtitle: Text(
                              pet.userName,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}
