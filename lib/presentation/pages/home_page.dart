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
      appBar: AppBar(
        title: const Text('Own a Pet'),
        actions: [
          IconButton.outlined(onPressed: () {}, icon: const Icon(Icons.star)),
        ],
      ),
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
                child: Card(
                  elevation: 5,
                  color: Colors.white,
                  child: SizedBox(
                    height: 150,
                    width: double.infinity,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Column(
                            spacing: 0,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('🐶', style: TextStyle(fontSize: 25)),
                              Text(
                                'Found a pet you like?',
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              SizedBox(height: 10),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  padding: const EdgeInsets.all(10),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),

                                child: const Text(
                                  'Apply to Adopt ',
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                onPressed: () {},
                              ),
                            ],
                          ),
                          Image.asset('asset/adopt-us.jpg', width: 200),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 25),
              Expanded(
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    crossAxisCount: 2,
                    childAspectRatio: 0.8,
                  ),
                  itemCount: controller.pets.length,
                  itemBuilder: (context, index) {
                    final pet = controller.pets[index];
                    return Card(
                      elevation: 2,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Stack(
                              alignment: Alignment.topRight,
                              children: [
                                SizedBox(
                                  height: 120,
                                  width: double.infinity,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(8),
                                    child: Image.asset(
                                      'asset/profiledog.jpg',
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                pet.isFriendly
                                    ? IconButton(
                                      icon: const Icon(
                                        Icons.star,
                                        color: Colors.white,
                                      ),
                                      onPressed: () {
                                        // Handle favorite action
                                      },
                                      style: IconButton.styleFrom(
                                        backgroundColor: Colors.white
                                            .withValues(
                                              alpha: (0.2),
                                            ), // THIS gives real transparency
                                      ),
                                    )
                                    : IconButton(
                                      icon: const Icon(
                                        Icons.star_border,
                                        color: Colors.white,
                                      ),
                                      onPressed: () {
                                        // Handle favorite action
                                      },
                                      style: IconButton.styleFrom(
                                        backgroundColor: Colors.white
                                            .withValues(
                                              alpha: (0.2),
                                            ), // ~20% opacity
                                        // THIS gives real transparency
                                      ),
                                    ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            Text(
                              pet.petName,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),

                            Text(
                              pet.userName,
                              style: const TextStyle(
                                fontSize: 14,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
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
