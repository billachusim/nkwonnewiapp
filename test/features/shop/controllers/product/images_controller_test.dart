import 'package:flutter_test/flutter_test.dart';
import 'package:nkwonnewiapp/features/shop/controllers/product/images_controller.dart';
import 'package:nkwonnewiapp/features/shop/models/product_model.dart';
import 'package:nkwonnewiapp/features/shop/models/product_variation_model.dart';

void main() {
  ProductModel buildProduct({List<ProductVariationModel>? variations}) {
    return ProductModel(
      id: 'p1',
      title: 'Product',
      stock: 10,
      price: 100,
      thumbnail: 'thumb.jpg',
      productType: 'single',
      images: const ['gallery.jpg'],
      productVariations: variations,
    );
  }

  group('ImagesController.buildProductImageList', () {
    test('handles null variations', () {
      final product = buildProduct(variations: null);

      final images = ImagesController.buildProductImageList(product);

      expect(images, equals(['thumb.jpg', 'gallery.jpg']));
    });

    test('handles empty variations', () {
      final product = buildProduct(variations: const []);

      final images = ImagesController.buildProductImageList(product);

      expect(images, equals(['thumb.jpg', 'gallery.jpg']));
    });

    test('deduplicates duplicated variation images and keeps thumbnail first', () {
      final product = buildProduct(
        variations: [
          ProductVariationModel(id: 'v1', image: 'gallery.jpg', attributeValues: const {}),
          ProductVariationModel(id: 'v2', image: 'variant.jpg', attributeValues: const {}),
          ProductVariationModel(id: 'v3', image: 'variant.jpg', attributeValues: const {}),
        ],
      );

      final images = ImagesController.buildProductImageList(product);

      expect(images.first, equals('thumb.jpg'));
      expect(images, containsAllInOrder(['thumb.jpg', 'gallery.jpg', 'variant.jpg']));
      expect(images.where((image) => image == 'variant.jpg').length, 1);
    });
  });
}
