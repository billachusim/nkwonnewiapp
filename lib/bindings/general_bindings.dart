import 'package:get/get.dart';
import '../features/personalization/controllers/address_controller.dart';
import '../features/shop/controllers/brand_controller.dart';
import '../features/shop/controllers/checkout_controller.dart';
import '../features/shop/controllers/product/images_controller.dart';
import '../features/shop/controllers/product/variation_controller.dart';
import '../utils/helpers/network_manager.dart';

class GeneralBindings extends Bindings {
  @override
  void dependencies() {
    /// -- Core
    Get.put(NetworkManager());

    /// -- Product
    Get.put(CheckoutController());
    Get.put(VariationController());
    Get.put(ImagesController());
    Get.put(BrandController());

    /// -- Other
    Get.put(AddressController());
  }
}
