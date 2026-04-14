import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../common/widgets/appbar/appbar.dart';
import '../../../../common/widgets/brands/brand_card.dart';
import '../../../../common/widgets/layouts/grid_layout.dart';
import '../../../../common/widgets/shimmers/brands_shimmer.dart';
import '../../../../common/widgets/texts/section_heading.dart';
import '../../../../utils/constants/sizes.dart';
import '../../controllers/brand_controller.dart';
import 'brand.dart';

class AllBrandsScreen extends StatelessWidget {
  const AllBrandsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(BrandController());
    return Scaffold(
      appBar: const TAppBar(showBackArrow: true, title: Text('Retailers')),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            children: [
              /// Sub Categories
              const TSectionHeading(title: 'Retailers', showActionButton: false),
              const SizedBox(height: TSizes.spaceBtwItems),

              /// -- Brands
              Obx(
                    () {
                  // Check if categories are still loading
                  if (controller.isLoading.value) return const TBrandsShimmer();

                  // Check if there are no featured categories found
                  if (controller.allBrands.isEmpty) {
                    return Center(
                      child: Text(
                        'No Data Found!',
                        style: Theme.of(context).textTheme.bodyMedium!.apply(color: Colors.white),
                      ),
                    );
                  } else {
                    /// Data Found
                    return ListView.builder(
                      shrinkWrap: true, // Allows the ListView to take up only the necessary space
                      physics: const NeverScrollableScrollPhysics(), // Disable scrolling since it's inside a SingleChildScrollView
                      itemCount: controller.allBrands.length,
                      itemBuilder: (_, index) {
                        final brand = controller.allBrands[index];
                        return Padding(
                          padding: const EdgeInsets.only(bottom: TSizes.spaceBtwItems), // Add space below each card
                          child: TBrandCard(
                            brand: brand,
                            showBorder: true,
                            onTap: () => Get.to(() => BrandScreen(brand: brand)),
                          ),
                        );
                      },
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
